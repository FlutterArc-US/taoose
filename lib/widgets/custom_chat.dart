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

  var previousChat;

  var otherUserData;

  var userFullName;

  @override
  void dispose() {
    super.dispose();
    _updateTypingStatus(isTyping: false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            EdgeInsets.only(left: 15.h, bottom: 5.v, top: 0.v, right: 15.h),
        child: FutureBuilder<QuerySnapshot>(
          future: firestoreInstance
              .doc(widget.chat.toString())
              .collection(widget.chat.toString())
              .orderBy('timestamp', descending: true)
              .limit(1)
              .get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              print("error");
            }

            if (!snapshot.hasData) {
              print("error");
            }

            if (snapshot.hasData) {
              previousChat = snapshot.data!.docs;
            }
            if (previousChat != null) {
              try {
                //print(firstData[0]['content'].toString() + 'ssssssssssss');
                return FutureBuilder<DocumentSnapshot>(
                  future:
                      previousChat[0]['idTo'] == Ncontroller.getUid().toString()
                          ? firestoreInstance2
                              .doc(previousChat[0]['idFrom'].toString())
                              .get()
                          : firestoreInstance2
                              .doc(previousChat[0]['idTo'].toString())
                              .get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      print("error");
                    }

                    if (snapshot.hasData && !snapshot.data!.exists) {
                      print("error");
                    }

                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.data!.exists) {
                      otherUserData = snapshot.data;
                    }
                    if (otherUserData != null) {
                      return InkWell(
                        onTap: () {
                          if (previousChat[0]['idFrom'].toString() !=
                              Ncontroller.getUid().toString()) {
                            FirebaseFirestore.instance
                                .collection('messages')
                                .doc(widget.chat.toString())
                                .collection(widget.chat.toString())
                                .doc('counter')
                                .set({'unread': 0});
                          }
                          BottomChatWidget().chatModalBottomSheet(
                            context,
                            otherUserData!['fullName'].toString(),
                            otherUserData['UserName'].toString(),
                            otherUserData['uid'].toString(),
                          );
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
                                            future: previousChat[0]['idTo'] ==
                                                    Ncontroller.getUid()
                                                        .toString()
                                                ? firestoreInstance2
                                                    .doc(previousChat[0]
                                                            ['idFrom']
                                                        .toString())
                                                    .get()
                                                : firestoreInstance2
                                                    .doc(previousChat[0]['idTo']
                                                        .toString())
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
                                                      ConnectionState.done &&
                                                  (snapshot.data?.exists ??
                                                      false)) {
                                                userFullName = snapshot.data;
                                              }

                                              if (userFullName != null) {
                                                var thirdData = snapshot.data;
                                                return Text(
                                                  userFullName!["fullName"]
                                                      .toString(),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: theme
                                                      .textTheme.titleSmall,
                                                );
                                              }

                                              return Text("");
                                            }),
                                      ),
                                      //Spacer(),
                                      Padding(
                                        padding: EdgeInsets.only(top: 2.v),
                                        child: Text(
                                          timeago.format(DateTime
                                              .fromMillisecondsSinceEpoch(
                                                  int.parse(previousChat[0]
                                                      ['timestamp']))),
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

                                              final messageType =
                                                  previousChat[0]['type'];

                                              final typingList =
                                                  data?['typing'];
                                              final isPeerUserTyping =
                                                  List.from(typingList ?? [])
                                                      .any((element) =>
                                                          element !=
                                                          Ncontroller.getUid()
                                                              .toString());
                                              return isPeerUserTyping
                                                  ? const Text(
                                                      'typing...',
                                                      style: TextStyle(
                                                          color: Colors.green),
                                                    )
                                                  : Text(
                                                      previousChat[0]['idFrom']
                                                                  .toString() !=
                                                              Ncontroller
                                                                      .getUid()
                                                                  .toString()
                                                          ? messageType == 1
                                                              ? 'Photo'
                                                              : previousChat[0][
                                                                      'content']
                                                                  .toString()
                                                          : "You: " +
                                                              (messageType == 1
                                                                  ? 'Photo'
                                                                  : previousChat[
                                                                              0]
                                                                          [
                                                                          'content']
                                                                      .toString()),
                                                      style: theme
                                                          .textTheme.bodyMedium,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    );
                                            }),
                                      ),
                                      Spacer(),
                                      StreamBuilder<DocumentSnapshot>(
                                          stream: firestoreInstance
                                              .doc(widget.chat.toString())
                                              .collection(
                                                  widget.chat.toString())
                                              .doc('counter')
                                              .snapshots(),
                                          builder: ((context,
                                              AsyncSnapshot<DocumentSnapshot>
                                                  snapshot) {
                                            var data = snapshot.data;
                                            //print(data?['unread'].toString());
                                            if (data == null) {
                                              return Container();
                                            } else {
                                              if (previousChat[0]['idFrom']
                                                          .toString() !=
                                                      Ncontroller.getUid()
                                                          .toString() &&
                                                  data['unread'] > 0) {
                                                return Container(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 6.h,
                                                    vertical: 1.v,
                                                  ),
                                                  decoration: AppDecoration
                                                      .fillPrimary
                                                      .copyWith(
                                                    borderRadius:
                                                        BorderRadiusStyle
                                                            .roundedBorder8,
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
                                          }))
                                    ],
                                  ),
                                ],
                              ),
                            )),
                          ],
                        ),
                      );
                    }

                    return Text("");
                  },
                );
              } catch (e) {
                return Container();
              }
            }

            return Container();
          },
        ));
  }
}
