import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taousapp/core/app_export.dart';
import 'package:taousapp/presentation/chat_screen/models/chat_model.dart';
import 'package:taousapp/presentation/chat_screen/widgets/conversation_view.dart';
import 'package:taousapp/presentation/home_screen/controller/home_controller.dart';
import 'package:taousapp/widgets/bottomChatWidget.dart';
import 'package:timeago/timeago.dart' as timeago;

// ignore: must_be_immutable
class CustomChat extends StatefulWidget {
  late ChatModel chat;
  CustomChat({
    super.key,
    required this.chat,
  });

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
          .doc(widget.chat.id)
          .set({
        'typing': FieldValue.arrayRemove([userid])
      }, SetOptions(merge: true)).catchError((_) {});
    } else {
      await FirebaseFirestore.instance
          .collection('messages')
          .doc(widget.chat.id)
          .set({
        'typing': FieldValue.arrayUnion([userid])
      }, SetOptions(merge: true)).catchError((_) {});
    }
  }

  Future<void> getUser() async {
    final otherUserId = widget.chat.members
        .firstWhere((element) => element != Ncontroller.getUid());
    final document = await FirebaseFirestore.instance
        .collection('TaousUser')
        .doc(otherUserId)
        .get();
    if (document.exists) {
      setState(() {});
    }
  }

  var user;
  @override
  void initState() {
    super.initState();
    scheduleMicrotask(() {
      getUser();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _updateTypingStatus(isTyping: false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15.h, bottom: 5.v, top: 0.v, right: 15.h),
      child: InkWell(
        onTap: () async {
          FirebaseFirestore.instance
              .collection('messages')
              .doc(widget.chat.id.toString())
              .collection(widget.chat.id.toString())
              .doc('counter')
              .set({'unread': 0});

          final otherUserId = widget.chat.members
              .firstWhere((element) => element != Ncontroller.getUid());
          final document = await FirebaseFirestore.instance
              .collection('TaousUser')
              .doc(otherUserId)
              .get();
          if (document.exists) {
            final user = document.data();
            if (mounted) {
              showModalBottomSheet(
                  isDismissible: true,
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35.0),
                      topRight: Radius.circular(35.0),
                    ),
                  ),
                  builder: (context) {
                    return ConversationView(
                        username: user!['UserName'].toString(),
                        peeruid: user['uid'].toString(),
                        fullname: user['fullName'].toString());
                  });

              // BottomChatWidget().chatModalBottomSheet(
              //   context,
              //   user!['fullName'].toString(),
              //   user['UserName'].toString(),
              //   user['uid'].toString(),
              // );
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
                        child: FutureBuilder(
                            future: FirebaseFirestore.instance
                                .collection('TaousUser')
                                .doc(
                                  widget.chat.members.firstWhere((element) =>
                                      element != Ncontroller.getUid()),
                                )
                                .get(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                user = snapshot?.data?.data();
                              }

                              if (user != null) {
                                return Text(
                                  user!["fullName"].toString(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: theme.textTheme.titleSmall,
                                );
                              }
                              return SizedBox();
                            }),
                      ),
                      //Spacer(),
                      Padding(
                        padding: EdgeInsets.only(top: 2.v),
                        child: Text(
                          timeago.format(
                            DateTime.fromMillisecondsSinceEpoch(
                              int.parse(widget.chat.timestamp),
                            ),
                          ),
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
                                .doc(widget.chat.id.toString())
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<DocumentSnapshot> snapshot) {
                              final data = snapshot.data;

                              final messageType =
                                  widget.chat.message?['type'] ?? 0;

                              final typingList = data?['typing'] ?? [];
                              final isPeerUserTyping =
                                  List.from(typingList ?? []).any((element) =>
                                      element !=
                                      Ncontroller.getUid().toString());
                              return isPeerUserTyping
                                  ? const Text(
                                      'typing...',
                                      style: TextStyle(color: Colors.green),
                                    )
                                  : Text(
                                      messageType == 1
                                          ? 'Photo'
                                          : widget.chat.message?['content']
                                                  .toString() ??
                                              '',
                                      style: theme.textTheme.bodyMedium,
                                      overflow: TextOverflow.ellipsis,
                                    );
                            }),
                      ),
                      Spacer(),
                      widget.chat.unReadMsgCount == null ||
                              ((widget.chat.unReadMsgCount ?? 0) < 1)
                          ? const SizedBox()
                          : Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 6.h,
                                vertical: 1.v,
                              ),
                              decoration: AppDecoration.fillPrimary.copyWith(
                                borderRadius: BorderRadiusStyle.roundedBorder8,
                              ),
                              child: Text(
                                widget.chat.unReadMsgCount.toString(),
                                style: CustomTextStyles
                                    .bodySmallPrimaryContainer12,
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
