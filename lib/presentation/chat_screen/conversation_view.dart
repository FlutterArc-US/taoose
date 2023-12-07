import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taousapp/presentation/chat_screen/controller/messages_provider.dart';
import 'package:taousapp/presentation/chat_screen/domain/usecases/create_message.dart';
import 'package:taousapp/presentation/chat_screen/domain/usecases/get_all_messages.dart';
import 'package:taousapp/presentation/chat_screen/domain/usecases/update_unread_messages_usecase.dart';
import 'package:taousapp/presentation/chat_screen/models/message_model.dart';
import 'package:taousapp/presentation/home_screen/controller/home_controller.dart';
import 'package:taousapp/util/di/di.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:taousapp/common/usecases/pick_camera_image_usecase.dart';
import 'package:taousapp/common/usecases/pick_gallery_image_usecase.dart';
import 'package:taousapp/core/app_export.dart';
import 'package:taousapp/core/utils/show_toast.dart';
import 'package:taousapp/failures/failures.dart';
import 'package:taousapp/infrastructure/usecase_input.dart';
import 'package:taousapp/presentation/chat_screen/controller/show_emoji_provider.dart';
import 'package:taousapp/presentation/chat_screen/models/message_type.dart';
import 'package:taousapp/presentation/chat_screen/widgets/emoji_widget.dart';
import 'package:taousapp/widgets/custom_icon_button.dart';
import 'package:taousapp/widgets/recieve_bubble.dart';
import 'package:taousapp/widgets/recieve_image_bubble.dart';
import 'package:taousapp/widgets/send_bubble.dart';
import 'package:taousapp/widgets/send_image_bubble.dart';

class ConversationView extends ConsumerStatefulWidget {
  ConversationView({
    super.key,
    required this.username,
    required this.peeruid,
    required this.fullname,
  });

  final String username;
  final String peeruid;
  final String fullname;

  @override
  ConsumerState<ConversationView> createState() => _ConversationViewState();
}

class _ConversationViewState extends ConsumerState<ConversationView> {
  RxBool sending = false.obs;

  Duration duration = const Duration(seconds: 1);

  Timer? _typingTimer;

  TextEditingController messageController = TextEditingController();
  StreamSubscription<List<MessageModel>>? messagesStreamSubscription;

  var hController = Get.find<HomeController>();
  final scrollController = ScrollController();

  var userid;

  var groupChatId;

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
  Future<void> onSendMessage(String content, int type,
      {List<File>? images}) async {
    // type: 0 = text, 1 = image, 2 = sticker
    if (content.trim() != '' || images != null) {
      messageController.clear();
      sending.value = true;

      final createMessageUsecase = sl<CreateMessageUsecase>();

      if (images != null && images.isNotEmpty) {
        final input = CreateImageMessageUsecaseInput(
            userid: userid,
            peeruid: widget.peeruid,
            type: 1,
            chatId: groupChatId,
            status: 1,
            timestamp: DateTime.now().millisecondsSinceEpoch,
            images: images);

        await createMessageUsecase(input);
      }

      if (content.isNotEmpty) {
        final input = CreateTextMessageUsecaseInput(
          userid: userid,
          peeruid: widget.peeruid,
          type: type,
          chatId: groupChatId,
          status: 1,
          timestamp: DateTime.now().millisecondsSinceEpoch,
          content: content,
        );

        await createMessageUsecase(input);
      }

      sending.value = false;
    } else {
      Get.snackbar('Empty message', 'Nothing to send');
    }
  }

  Future<void> getAllMessages() async {
    final chatId = groupChatId;
    final messagesUsecase = sl<GetAllMessagesUsecase>();
    final updateUnreadMessagesUsecase = sl<MarkReadMessagesUsecase>();

    final output = await messagesUsecase(
      GetAllMessagesUsecaseInput(
        chatId: chatId,
        userId: userid,
      ),
    );

    messagesStreamSubscription = output.messages.listen((messages) {
      ref.read(messagesProvider.notifier).updateMessages(messages);
      updateUnreadMessagesUsecase(
        MarkReadMessagesUsecaseInput(
          userId: userid,
          chatId: chatId,
        ),
      );
      // WidgetsBinding.instance.addPostFrameCallback(
      //   (_) =>
      //       scrollController.jumpTo(scrollController.position.maxScrollExtent),
      // );
    });
  }

  @override
  void initState() {
    userid = hController.getUid();
    if (userid.hashCode <= widget.peeruid.hashCode) {
      groupChatId = '$userid-${widget.peeruid}';
    } else {
      groupChatId = '${widget.peeruid}-$userid';
    }
    super.initState();

    scheduleMicrotask(() {
      getAllMessages();
    });
  }

  @override
  void dispose() {
    messagesStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(messagesProvider);
    return Container(
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
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
                child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(Icons.arrow_drop_down))),

            /// [User info]
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
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              widget.fullname,
                              style: theme.textTheme.headlineSmall,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),

                          /// [Typing]
                          StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('messages')
                                  .doc(groupChatId)
                                  .snapshots(),
                              builder: (context, value) {
                                final typingUserList =
                                    value.data?.data()?['typing'] ?? [];

                                if (typingUserList == null) {
                                  return const SizedBox();
                                } else {
                                  final typingList = typingUserList ?? [];
                                  final isPeerUserTyping =
                                      List.from(typingList ?? [])
                                          .any((element) => element != userid);
                                  if (isPeerUserTyping) {
                                    return const Text(
                                      'typing...',
                                      style: TextStyle(color: Colors.green),
                                    );
                                  }
                                }

                                return StreamBuilder<
                                        DocumentSnapshot<Map<String, dynamic>>>(
                                    stream: FirebaseFirestore.instance
                                        .collection('TaousUser')
                                        .doc(widget.peeruid)
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
                                                        bottom: 2.v, left: 2.h),
                                                    decoration: BoxDecoration(
                                                      color: appTheme.red400,
                                                      borderRadius:
                                                          BorderRadius.circular(
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
                                    });
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
                /// [Messages]
                Expanded(
                  //width: MediaQuery.of(context).size.width,
                  //height: 450,

                  child: ListView.builder(
                    padding: const EdgeInsets.all(10.0),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      if (message.idFrom == userid) {
                        if (message.type == MessageType.text.id) {
                          return SendBubble(index, message);
                        } else if (message.type == MessageType.image.id) {
                          return SendImageBubble(index, message);
                        }
                        return const SizedBox();
                      } else {
                        if (message.type == MessageType.text.id) {
                          return RecieveBubble(index, message);
                        } else if (message.type == MessageType.image.id) {
                          return RecieveImageBubble(index, message);
                        }
                        return const SizedBox();
                      }
                    },
                    reverse: true,
                    //  controller: listScrollController,
                  ),
                ),
                Obx(
                  () => sending.value == true
                      ? Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              // Align(
                              //   alignment: Alignment.centerRight,
                              //   child: Container(
                              //     margin: EdgeInsets.only(
                              //         left: 97.h, top: 10.v, right: 15.h),
                              //     padding: EdgeInsets.symmetric(
                              //       horizontal: 16.h,
                              //       vertical: 15.v,
                              //     ),
                              //     decoration: AppDecoration.fillGray10003
                              //         .copyWith(
                              //       borderRadius: BorderRadiusStyle
                              //           .customBorderTL151,
                              //     ),
                              //     child: SizedBox(
                              //       width: 213.h,
                              //       child: Text(
                              //         chatContent.value.toString(),
                              //         maxLines: 1000,
                              //         overflow: TextOverflow.ellipsis,
                              //         style: CustomTextStyles.bodyMedium14
                              //             .copyWith(
                              //           height: 1.50,
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              // SizedBox(height: 5.v),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 1.v, right: 21),
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
                      : Container(),
                )
              ]),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 15.h, right: 15, top: 10.v, bottom: 10.v),
              child: Consumer(builder: (context, ref, _) {
                final showEmoji = ref.watch(showEmojiProvider);

                return Container(
                  decoration: AppDecoration.outlineGray20001.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorder17,
                  ),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          padding: const EdgeInsets.only(
                            left: 10,
                            bottom: 10,
                            top: 10,
                          ),
                          height: 60,
                          width: double.infinity,
                          color: Colors.white,
                          child: Row(
                            children: <Widget>[
                              /// [camera button]

                              GestureDetector(
                                onTap: () async {
                                  ref.read(showEmojiProvider.notifier).state =
                                      false;

                                  final cameraUsecase =
                                      sl<PickCameraImageUsecase>();

                                  final image = await cameraUsecase(NoInput());

                                  if (image.isNotEmpty) {
                                    onSendMessage('', 1, images: [File(image)]);
                                  }
                                },
                                child: CustomImageView(
                                  svgPath: ImageConstant.imgInstagram,
                                  height: 24.adaptSize,
                                  width: 24.adaptSize,
                                  margin: EdgeInsets.only(bottom: 2.v),
                                ),
                              ),
                              const SizedBox(width: 15),

                              Expanded(
                                child: TextField(
                                  onTap: () {
                                    ref.read(showEmojiProvider.notifier).state =
                                        false;
                                  },
                                  controller: messageController,
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      startTimer();
                                      updateTypingStatus(isTyping: true);
                                    } else {
                                      updateTypingStatus(isTyping: false);
                                    }
                                  },
                                  cursorColor: theme.colorScheme.primary,
                                  decoration: const InputDecoration(
                                    hintText: "Write message...",
                                    hintStyle: TextStyle(color: Colors.black54),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 13),

                              /// [gallery button]
                              InkWell(
                                onTap: () async {
                                  try {
                                    ref.read(showEmojiProvider.notifier).state =
                                        false;

                                    final pickGalleryImageUsecase =
                                        sl<PickGalleryImageUsecase>();

                                    final image = await pickGalleryImageUsecase(
                                        NoInput());

                                    if (image.isNotEmpty) {
                                      onSendMessage('', 1,
                                          images: [File(image)]);
                                    }
                                  } on ImageFileNotSupportedException catch (e) {
                                    showToast(message: "${e.message}");
                                  } catch (_) {}
                                },
                                child: SvgPicture.asset(
                                    ImageConstant.imagePlaceholder),
                              ),
                              const SizedBox(width: 7),

                              /// [emoji]
                              InkWell(
                                onTap: () async {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  ref.read(showEmojiProvider.notifier).state =
                                      !showEmoji;
                                },
                                child: SvgPicture.asset(ImageConstant.sticker),
                              ),

                              const SizedBox(width: 10),
                              FloatingActionButton(
                                onPressed: () {
                                  onSendMessage(messageController.text, 0);
                                },
                                backgroundColor: appTheme.indigo900,
                                elevation: 0,
                                child: const Icon(
                                  Icons.send,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      /// [Custom emoji widget]
                      if (showEmoji)
                        CustomEmojiWidget(
                          controller: messageController,
                          onEmojiSelected: (category, emoji) {},
                        )
                    ],
                  ),
                );
              }),
            ),

            /// [Padding bottom]
            SizedBox(
              height: MediaQuery.of(context).viewInsets.bottom,
            )
          ]),
    );
  }
}
