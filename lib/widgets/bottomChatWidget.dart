import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:taousapp/common/usecases/pick_camera_image_usecase.dart';
import 'package:taousapp/core/app_export.dart';
import 'package:taousapp/infrastructure/usecase_input.dart';
import 'package:taousapp/presentation/chat_screen/domain/usecases/create_message.dart';
import 'package:taousapp/presentation/chat_screen/models/message_type.dart';
import 'package:taousapp/presentation/home_screen/controller/home_controller.dart';
import 'package:taousapp/util/di/di.dart';
import 'package:taousapp/widgets/custom_icon_button.dart';
import 'package:taousapp/widgets/recieve_bubble.dart';
import 'package:taousapp/widgets/recieve_image_bubble.dart';
import 'package:taousapp/widgets/send_bubble.dart';
import 'package:taousapp/widgets/send_image_bubble.dart';

// ignore: camel_case_types
class BottomChatWidget {
  RxString chatContent = ''.obs;
  RxBool sending = false.obs;

  Duration duration = const Duration(seconds: 1);

  Timer? _typingTimer;

  void chatModalBottomSheet(context, fullname, username, peeruid) {
    TextEditingController messageController = TextEditingController();
    var hController = Get.find<HomeController>();
    var listMessage;
    var userid = hController.getUid();
    var groupChatId;
    if (userid.hashCode <= peeruid.hashCode) {
      groupChatId = '$userid-$peeruid';
    } else {
      groupChatId = '$peeruid-$userid';
    }

    /// [on typing]
    Future<void> updateTypingStatus({required bool isTyping}) async {
      var userid = hController.getUid();

      if (!isTyping) {
        await FirebaseFirestore.instance
            .collection('messages')
            .doc(groupChatId)
            .set({
          'typing': FieldValue.arrayRemove([userid])
        }, SetOptions(merge: true)).catchError((_) {});
      } else {
        await FirebaseFirestore.instance
            .collection('messages')
            .doc(groupChatId)
            .set({
          'typing': FieldValue.arrayUnion([userid])
        }, SetOptions(merge: true)).catchError((_) {});
      }
    }

    /// [start timer]
    void startTimer() {
      _typingTimer = Timer.periodic(duration, (timer) {
        if (timer.tick == 2) {
          updateTypingStatus(isTyping: false);
          timer.cancel(); // Cancels the timer after 5 ticks
        }
      });
    }

    /// [send message]
    Future<void> onSendMessage(String content, int type, {File? image}) async {
      chatContent.value = messageController.text;
      FirebaseFirestore.instance
          .collection('messages')
          .doc(groupChatId)
          .collection(groupChatId)
          .doc('counter')
          .get()
          .then((doc) {
        if (!doc.exists) {
          FirebaseFirestore.instance
              .collection('messages')
              .doc(groupChatId)
              .collection(groupChatId)
              .doc('counter')
              .set({'unread': 1}).catchError((_) {
            print("not successful!");
          });
        } else {
          FirebaseFirestore.instance
              .collection('messages')
              .doc(groupChatId)
              .collection(groupChatId)
              .doc('counter')
              .update({'unread': FieldValue.increment(1)});
        }
      });
      // type: 0 = text, 1 = image, 2 = sticker
      if (content.trim() != '' || image != null) {
        messageController.clear();
        var ref =
            FirebaseFirestore.instance.collection('messages').doc(groupChatId);
        var documentReference = ref
            .collection(groupChatId)
            .doc(DateTime.now().millisecondsSinceEpoch.toString());
        sending.value = true;
        await FirebaseFirestore.instance
            .collection('TaousUser')
            .doc(userid)
            .update({
          'chats': FieldValue.arrayRemove([groupChatId.toString()]),
        }).then((value) => {
                  FirebaseFirestore.instance
                      .collection('TaousUser')
                      .doc(userid)
                      .update({
                    'chats': FieldValue.arrayUnion([groupChatId.toString()]),
                  })
                });
        await FirebaseFirestore.instance
            .collection('TaousUser')
            .doc(peeruid)
            .update({
          'chats': FieldValue.arrayRemove([groupChatId.toString()]),
        }).then((value) => {
                  FirebaseFirestore.instance
                      .collection('TaousUser')
                      .doc(peeruid)
                      .update({
                    'chats': FieldValue.arrayUnion([groupChatId.toString()]),
                  })
                });

        final createMessageUsecase = sl<CreateMessageUsecase>();

        if (image != null) {
          final input = CreateImageMessageUsecaseInput(
              userid: userid,
              peeruid: peeruid,
              type: 1,
              chatId: groupChatId,
              status: 1,
              timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
              images: [image]);

          await createMessageUsecase(input);
        }

        if (content.isNotEmpty) {
          final input = CreateTextMessageUsecaseInput(
            userid: userid,
            peeruid: peeruid,
            type: type,
            chatId: groupChatId,
            status: 1,
            timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
            content: content,
          );

          await createMessageUsecase(input);
        }

        // FirebaseFirestore.instance.runTransaction((transaction) async {
        //   transaction.set(
        //     documentReference,
        //     {
        //       'idFrom': userid,
        //       'idTo': peeruid,
        //       'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
        //       'content': content,
        //       'type': type,
        //       "status": 1
        //     },
        //   );
        // });
        sending.value =
            false; //listScrollController.animateTo(0.0, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      } else {
        Get.snackbar('Empty message', 'Nothing to send');
      }
    }

    showModalBottomSheet(
      isDismissible: true,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Obx(
          () => Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.85,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35.0),
                  topRight: Radius.circular(35.0),
                ),
              ),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                        child: InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Icon(Icons.arrow_drop_down))),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 10, bottom: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.imgPhoto4,
                            height: 48.adaptSize,
                            width: 48.adaptSize,
                            radius: BorderRadius.circular(
                              24.h,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      fullname,
                                      style: theme.textTheme.headlineSmall,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                  StreamBuilder<
                                          DocumentSnapshot<
                                              Map<String, dynamic>>>(
                                      stream: FirebaseFirestore.instance
                                          .collection('TaousUser')
                                          .doc(peeruid)
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        final online =
                                            snapshot.data?['online'] ?? false;
                                        return !online
                                            ? const SizedBox()
                                            : Row(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomLeft,
                                                    child: Container(
                                                      height: 6.adaptSize,
                                                      width: 6.adaptSize,
                                                      margin: EdgeInsets.only(
                                                          bottom: 2.v,
                                                          left: 2.h),
                                                      decoration: BoxDecoration(
                                                        color: appTheme.red400,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          3.h,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 2.h),
                                                      child: Text(
                                                        "lbl_online".tr,
                                                        style: CustomTextStyles
                                                            .bodySmallBlack900,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                      })
                                ],
                              ),
                            ),
                          ),

                          //Spacer(),
                          CustomIconButton(
                            height: 52.adaptSize,
                            width: 52.adaptSize,
                            margin: EdgeInsets.only(top: 2.v),
                            padding: EdgeInsets.all(14.h),
                            decoration: IconButtonStyleHelper.outlineGray,
                            child: CustomImageView(
                              svgPath: ImageConstant.imgOverflowmenu,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      //height: 100,
                      child: Column(children: [
                        Expanded(
                          //width: MediaQuery.of(context).size.width,
                          //height: 450,
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('messages')
                                .doc(groupChatId)
                                .collection(groupChatId)
                                .orderBy('timestamp', descending: true)
                                //.limit(1)
                                .snapshots(),
                            builder: (context, AsyncSnapshot snapshot) {
                              if (!snapshot.hasData) {
                                //print(snapshot.data!.docs.toString());
                                return Center(
                                  child:
                                      LoadingAnimationWidget.fourRotatingDots(
                                    color: theme.colorScheme.primary,
                                    size: 30,
                                  ),
                                );
                              } else if (snapshot.hasData) {
                                listMessage = snapshot.data.docs;
                                return ListView.builder(
                                  padding: EdgeInsets.all(10.0),
                                  itemBuilder: (context, index) {
                                    if (listMessage[index]['idFrom'] ==
                                        userid) {
                                      if (listMessage[index]['type'] ==
                                          MessageType.text.id) {
                                        return SendBubble(
                                            index, snapshot.data.docs[index]);
                                      } else if (listMessage[index]['type'] ==
                                          MessageType.image.id) {
                                        return SendImageBubble(
                                            index, listMessage[index]);
                                      }
                                      return const SizedBox();
                                    } else {
                                      if (listMessage[index]['type'] ==
                                          MessageType.text.id) {
                                        return RecieveBubble(
                                            index, snapshot.data.docs[index]);
                                      } else if (listMessage[index]['type'] ==
                                          MessageType.image.id) {
                                        return RecieveImageBubble(
                                            index, snapshot.data.docs[index]);
                                      }
                                      return const SizedBox();
                                    }
                                  },
                                  reverse: true,
                                  itemCount: snapshot.data.docs.length,
                                  //controller: listScrollController,
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                        ),
                        sending.value == true
                            ? Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            left: 97.h, top: 10.v, right: 15.h),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 16.h,
                                          vertical: 15.v,
                                        ),
                                        decoration: AppDecoration.fillGray10003
                                            .copyWith(
                                          borderRadius: BorderRadiusStyle
                                              .customBorderTL151,
                                        ),
                                        child: SizedBox(
                                          width: 213.h,
                                          child: Text(
                                            chatContent.value.toString(),
                                            maxLines: 1000,
                                            overflow: TextOverflow.ellipsis,
                                            style: CustomTextStyles.bodyMedium14
                                                .copyWith(
                                              height: 1.50,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 5.v),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 1.v, right: 21),
                                            child: Text(
                                              "Sending...",
                                              style: CustomTextStyles
                                                  .bodySmallSkModernistBlack900,
                                            ),
                                          ),

                                          /*CustomImageView(
                                          svgPath: ImageConstant.imgCheckmarkRed400,
                                          height: 16.adaptSize,
                                          width: 16.adaptSize,
                                          margin: EdgeInsets.only(left: 4.h,right: 15.h),
                                        ),*/
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container()
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 15.h, right: 15, top: 10.v, bottom: 10.v),
                      child: Container(
                        decoration: AppDecoration.outlineGray20001.copyWith(
                          borderRadius: BorderRadiusStyle.roundedBorder17,
                        ),
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: 10, bottom: 10, top: 10),
                                height: 60,
                                width: double.infinity,
                                color: Colors.white,
                                child: Row(
                                  children: <Widget>[
                                    /// [camera button]

                                    GestureDetector(
                                      onTap: () async {
                                        final cameraUsecase =
                                            sl<PickCameraImageUsecase>();

                                        final image =
                                            await cameraUsecase(NoInput());

                                        if (image != null) {
                                          onSendMessage('', 1,
                                              image: File(image));
                                        }
                                      },
                                      child: CustomImageView(
                                        svgPath: ImageConstant.imgInstagram,
                                        height: 24.adaptSize,
                                        width: 24.adaptSize,
                                        margin: EdgeInsets.only(bottom: 2.v),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: TextField(
                                        controller: messageController,
                                        onChanged: (value) {
                                          if (value.isNotEmpty) {
                                            startTimer();
                                            updateTypingStatus(isTyping: true);
                                          } else {
                                            updateTypingStatus(isTyping: false);
                                          }
                                        },
                                        decoration: InputDecoration(
                                          hintText: "Write message...",
                                          hintStyle:
                                              TextStyle(color: Colors.black54),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    FloatingActionButton(
                                      onPressed: () {
                                        onSendMessage(
                                            messageController.text, 0);
                                      },
                                      child: Icon(
                                        Icons.send,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                      backgroundColor: appTheme.indigo900,
                                      elevation: 0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        );
      },
    );
  }

  Future<void> showOptions({
    required VoidCallback onTapCamera,
    required VoidCallback onTapGallery,
  }) async {
    await Get.bottomSheet(
        SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () async {
                    Get.back();
                  }),
              ListTile(
                  leading: const Icon(Icons.browse_gallery),
                  title: const Text('Gallery'),
                  onTap: () async {
                    Get.back();
                  }),
            ],
          ),
        ),
        backgroundColor: Colors.white);
  }
}
