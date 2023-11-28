import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:taousapp/presentation/chat_screen/models/chat_model.dart';
import 'package:taousapp/presentation/home_screen/controller/home_controller.dart';
import 'package:taousapp/widgets/custom_chat.dart';
import 'controller/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:taousapp/core/app_export.dart';

// ignore_for_file: must_be_immutable
class ChatScreen extends GetWidget<ChatController> {
  ChatScreen({Key? key})
      : super(
          key: key,
        );
  var Ncontroller = Get.find<HomeController>();
  var listMessage;
  List chats = [].obs;

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    print(Ncontroller.getUid());
    return Scaffold(
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
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('messages')
                  .where('members', arrayContains: Ncontroller.getUid())
                  .orderBy(
                    'timestamp',
                    descending: true,
                  )
                  .snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: LoadingAnimationWidget.fourRotatingDots(
                      color: theme.colorScheme.primary,
                      size: 30,
                    ),
                  );
                } else if (snapshot.data == null ||
                    snapshot.data!.docs.isEmpty) {
                  return const Text("Nothing to show");
                } else {
                  final data = snapshot.data!.docs.map((doc) {
                    final count =
                        doc.data()['unReadMsgCountFor${Ncontroller.getUid()}'];

                    return ChatModel.fromJson(doc.data())
                        .copyWith(id: doc.id, unReadMsgCount: count);
                  }).toList();

                  try {
                    // Print the list of ChatModel instances
                    print(data);

                    return Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          var chat = data[index];

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: CustomChat(chat: chat),
                          );
                        },
                        itemCount: data.length,
                      ),
                    );
                  } catch (e) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Center(
                        child: Text(
                          "No conversations",
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                    );
                  }
                }
              },
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
    );
  }
}
