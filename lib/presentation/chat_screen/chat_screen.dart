import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taousapp/core/app_export.dart';
import 'package:taousapp/presentation/chat_screen/controller/chats_provider.dart';
import 'package:taousapp/presentation/chat_screen/domain/usecases/get_all_chats.dart';
import 'package:taousapp/presentation/chat_screen/models/chat_model.dart';
import 'package:taousapp/presentation/chat_screen/widgets/chat_search_bar_widget.dart';
import 'package:taousapp/presentation/home_screen/controller/home_controller.dart';
import 'package:taousapp/util/di/di.dart';
import 'package:taousapp/widgets/custom_chat.dart';

// ignore_for_file: must_be_immutable
class ChatScreen extends ConsumerStatefulWidget {
  ChatScreen({Key? key})
      : super(
          key: key,
        );

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  var Ncontroller = Get.find<HomeController>();

  late StreamSubscription<List<ChatModel>> chatStreamSubscription;
  final allChatsUsecase = sl<GetAllChatsUsecase>();

  Future<void> getAllChats() async {
    final output = await allChatsUsecase(
      GetAllChatsUsecaseInput(userId: Ncontroller.getUid()),
    );

    chatStreamSubscription = output.chats.listen((messages) {
      ref
          .read(chatsProvider.notifier)
          .updateChats(messages, Ncontroller.getUid());
    });
  }

  @override
  void dispose() {
    chatStreamSubscription.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    scheduleMicrotask(getAllChats);
  }

  @override
  Widget build(BuildContext context) {
    final chats = ref.watch(searchedChatsProvider);

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: appTheme.whiteA700,
        body: SizedBox(
          width: mediaQueryData.size.width,
          height: mediaQueryData.size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15.h, top: 30.h),
                    child: Text(
                      "lbl_messages".tr,
                      style: theme.textTheme.headlineMedium,
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Container(
                      height: 38.adaptSize,
                      width: 38.adaptSize,
                      margin: EdgeInsets.only(
                        left: 17.h,
                        right: 17.h,
                        bottom: 3.v,
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CustomImageView(
                            svgPath: ImageConstant.imgClose,
                            height: 38.adaptSize,
                            width: 38.adaptSize,
                            alignment: Alignment.center,
                          ),
                          CustomImageView(
                            svgPath: ImageConstant.imgShare,
                            height: 19.adaptSize,
                            width: 19.adaptSize,
                            alignment: Alignment.center,
                            margin: EdgeInsets.fromLTRB(9.h, 8.v, 9.h, 10.v),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(
                    left: 14.0, right: 14.0, top: 14.0, bottom: 18.0),
                child: ChatSearchBarWidget(),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: chats.length,
                  itemBuilder: (context, index) {
                    final chat = chats[index];
                    final otherUserId = chat.members.firstWhere(
                      (element) => element != Ncontroller.getUid(),
                    );
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: CustomChat(
                        chat: chat,
                        otherUserId: otherUserId,
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 31.v),
                child: Divider(
                  indent: 91.h,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
