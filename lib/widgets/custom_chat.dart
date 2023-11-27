import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taousapp/core/app_export.dart';
import 'package:taousapp/presentation/home_screen/controller/home_controller.dart';
import 'package:taousapp/widgets/bottomChatWidget.dart';
import 'package:timeago/timeago.dart' as timeago;

// ignore: must_be_immutable
class CustomChat extends StatefulWidget {
  var chat;
  CustomChat(this.chat);

  @override
  State<CustomChat> createState() => _CustomChatState();
}

class _CustomChatState extends State<CustomChat> {
  // ignore: non_constant_identifier_names
  var Ncontroller = Get.find<HomeController>();

  final CollectionReference firestoreInstance =
      FirebaseFirestore.instance.collection('messages');

  final CollectionReference firestoreInstance2 =
      FirebaseFirestore.instance.collection('TaousUser');

  /// [on typing]
  Future<void> _updateTypingStatus({required bool isTyping}) async {
    var userid = Ncontroller.getUid();

    if (!isTyping) {
      await FirebaseFirestore.instance
          .collection('messages')
          .doc(widget.chat)
          .set({
        'typing': FieldValue.arrayRemove([userid])
      }, SetOptions(merge: true)).catchError((_) {});
    } else {
      await FirebaseFirestore.instance
          .collection('messages')
          .doc(widget.chat)
          .set({
        'typing': FieldValue.arrayUnion([userid])
      }, SetOptions(merge: true)).catchError((_) {});
    }
  }

  var chat;

  @override
  void dispose() {
    super.dispose();
    _updateTypingStatus(isTyping: false);
  }

  initData() async {
    final doc2 = await firestoreInstance.doc(widget.chat.toString()).get();

    final doc = await firestoreInstance
        .doc(widget.chat.toString())
        .collection(widget.chat.toString())
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();

    chat = doc.docs;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    scheduleMicrotask(() {
      initData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15.h, bottom: 5.v, top: 0.v, right: 15.h),
      child: chat != null
          ? InkWell(
              onTap: () async {
                if (chat[0]['idFrom'].toString() !=
                    Ncontroller.getUid().toString()) {
                  FirebaseFirestore.instance
                      .collection('messages')
                      .doc(widget.chat.toString())
                      .collection(widget.chat.toString())
                      .doc('counter')
                      .set({'unread': 0});
                }

                final userDoc =
                    chat[0]['idTo'] == Ncontroller.getUid().toString()
                        ? await firestoreInstance2
                            .doc(chat[0]['idFrom'].toString())
                            .get()
                        : await firestoreInstance2
                            .doc(chat[0]['idTo'].toString())
                            .get();

                if (userDoc.exists) {
                  final userData = userDoc;
                  if (mounted) {
                    BottomChatWidget().chatModalBottomSheet(
                      context,
                      userData['fullName'].toString() ?? '',
                      userData['UserName'].toString(),
                      userData['uid'].toString(),
                    );
                  }
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgProfile,
                    height: 48.adaptSize,
                    width: 48.adaptSize,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 13.h,
                        top: 3.v,
                        bottom: 4.v,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: FutureBuilder<DocumentSnapshot>(
                                    future: chat[0]['idTo'] ==
                                            Ncontroller.getUid().toString()
                                        ? firestoreInstance2
                                            .doc(chat[0]['idFrom'].toString())
                                            .get()
                                        : firestoreInstance2
                                            .doc(chat[0]['idTo'].toString())
                                            .get(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<DocumentSnapshot>
                                            snapshot) {
                                      if (snapshot.hasError) {
                                        print("error");
                                      }

                                      if (snapshot.hasData &&
                                          !snapshot.data!.exists) {
                                        print("error");
                                      }

                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        var thirdData = snapshot.data;
                                        return Text(
                                          thirdData!["fullName"].toString(),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: theme.textTheme.titleSmall,
                                        );
                                      }

                                      return Text("");
                                    }),
                              ),
                              //Spacer(),
                              Padding(
                                padding: EdgeInsets.only(top: 2.v),
                                child: Text(
                                  timeago.format(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          int.parse(chat[0]['timestamp']))),
                                  maxLines: null,
                                  textAlign: TextAlign.right,
                                  style: theme.textTheme.bodySmall,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 2.v),

                          /// [typing]
                          Row(
                            children: [
                              Expanded(
                                child: StreamBuilder<DocumentSnapshot>(
                                  stream: firestoreInstance
                                      .doc(widget.chat.toString())
                                      .snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<DocumentSnapshot>
                                          snapshot) {
                                    final data = snapshot.data;

                                    final messageType = chat[0]['type'];

                                    final typingList = data?['typing'] ?? [];
                                    final isPeerUserTyping =
                                        List.from(typingList ?? []).any(
                                            (element) =>
                                                element !=
                                                Ncontroller.getUid()
                                                    .toString());
                                    if (isPeerUserTyping) {
                                      return const Text(
                                        'typing...',
                                        style: TextStyle(color: Colors.green),
                                      );
                                    } else {
                                      return Text(
                                        chat[0]['idFrom'].toString() !=
                                                Ncontroller.getUid().toString()
                                            ? messageType == 1
                                                ? 'Photo'
                                                : chat[0]['content'].toString()
                                            : 'You: ${messageType == 1 ? 'Photo' : chat[0]['content'].toString()}',
                                        style: theme.textTheme.bodyMedium,
                                        overflow: TextOverflow.ellipsis,
                                      );
                                    }
                                  },
                                ),
                              ),
                              Spacer(),
                              StreamBuilder<DocumentSnapshot>(
                                stream: firestoreInstance
                                    .doc(widget.chat.toString())
                                    .collection(widget.chat.toString())
                                    .doc('counter')
                                    .snapshots(),
                                builder: ((context,
                                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                                  var data = snapshot.data;
                                  //print(data?['unread'].toString());
                                  if (data == null) {
                                    return Container();
                                  } else {
                                    if (chat[0]['idFrom'].toString() !=
                                            Ncontroller.getUid().toString() &&
                                        data['unread'] > 0) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 6.h,
                                          vertical: 1.v,
                                        ),
                                        decoration:
                                            AppDecoration.fillPrimary.copyWith(
                                          borderRadius:
                                              BorderRadiusStyle.roundedBorder8,
                                        ),
                                        child: Text(
                                          data['unread'].toString(),
                                          style: CustomTextStyles
                                              .bodySmallPrimaryContainer12,
                                        ),
                                      );
                                    } else {
                                      return Container();
                                    }
                                  }
                                }),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Container(),
    );
  }
}
