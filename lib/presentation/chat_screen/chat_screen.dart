import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:taousapp/presentation/home_screen/controller/home_controller.dart';
import 'package:taousapp/widgets/custom_chat.dart';
import 'controller/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:taousapp/core/app_export.dart';

// ignore_for_file: must_be_immutable
class ChatScreen extends GetWidget<ChatController> {
  const ChatScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    var Ncontroller = Get.find<HomeController>();
    var listMessage;
    RxList chats = [].obs;
    return Scaffold(
      backgroundColor: appTheme.whiteA700,
      body: SizedBox(
        width: mediaQueryData.size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
              Padding(
                padding: const EdgeInsets.only(
                    left: 14.0, right: 14.0, top: 14.0, bottom: 18.0),
                child: Container(
                  margin: EdgeInsets.only(left: 2.h),
                  padding: EdgeInsets.symmetric(
                    horizontal: 11.h,
                    vertical: 12.v,
                  ),
                  decoration: AppDecoration.outlineGray.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorder13,
                  ),
                  child: Row(
                    children: [
                      CustomImageView(
                        svgPath: ImageConstant.imgCharmsearch,
                        height: 23.adaptSize,
                        width: 23.adaptSize,
                        margin: EdgeInsets.only(bottom: 1.v),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 4.h,
                          top: 2.v,
                        ),
                        child: Text(
                          "lbl_search".tr,
                          style: CustomTextStyles.bodyMediumBlack900,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('TaousUser')
                      .doc(Ncontroller.getUid())
                      //.limit(1)
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      //print(snapshot.data!.docs.toString());
                      return Center(
                        child: LoadingAnimationWidget.fourRotatingDots(
                          color: theme.colorScheme.primary,
                          size: 30,
                        ),
                      );
                    } else if (snapshot.data == null) {
                      return Text("noting to show");
                    } else {
                      listMessage = snapshot.data;
                      try {
                        chats.value = listMessage['chats'];
                        // ignore: invalid_use_of_protected_member
                        print (chats.value);
                        return ListView.builder(
                          shrinkWrap: true,
                          //padding: EdgeInsets.all(10.0),
                          itemBuilder: (context, index) =>
                              Obx(() => Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: CustomChat(chats[index], controller.unread),
                              )),
                          reverse: true,
                          // ignore: invalid_use_of_protected_member
                          itemCount: chats.value.length,
                          //controller: listScrollController,
                        );
                      } catch (e) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Center(child: Text("No conversations",style: theme.textTheme.bodySmall,)),
                        );
                      }

                      //print(chats[0].toString());
                    }
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

