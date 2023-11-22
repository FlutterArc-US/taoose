import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taousapp/notifications/domain/models/notification/push_notification.dart';
import 'package:taousapp/notifications/domain/usecases/send_notificaiton.dart';
import 'package:taousapp/presentation/home_screen/controller/home_controller.dart';
import 'package:taousapp/util/di/di.dart';

import 'controller/prodcut_details_one_controller.dart';
import 'package:flutter/material.dart';
import 'package:taousapp/core/app_export.dart';
import 'package:taousapp/widgets/app_bar/appbar_image_1.dart';
import 'package:taousapp/widgets/app_bar/appbar_subtitle.dart';
import 'package:taousapp/widgets/app_bar/custom_app_bar.dart';
import 'package:taousapp/widgets/custom_icon_button.dart';

// ignore_for_file: must_be_immutable
class ProdcutDetailsOneScreen extends GetWidget<ProdcutDetailsOneController> {
  ProdcutDetailsOneScreen({Key? key})
      : super(
          key: key,
        );

  final sendNotificationUsecase = sl<SendNotificationUsecase>();

  Future<void> sendLikeNotification({String? postOwnerId}) async {
    final userId = controller.hController.getUid();

    if (postOwnerId != null && userId != postOwnerId) {
      final document = await FirebaseFirestore.instance
          .collection('TaousUser')
          .doc(userId)
          .get();
      if (!document.exists) {
        return;
      }
      final data = document.data();
      final username = data?['fullName'];

      final input = SendNotificationUsecaseInput(
        userId: postOwnerId,
        notification: PushNotification(
          title: 'New liked',
          description: '$username has liked your post',
          id: DateTime.now().millisecondsSinceEpoch,
        ),
      );

      await sendNotificationUsecase(input);
    }
  }

  @override
  Widget build(BuildContext context) {
    //var hController = Get.find<HomeController>();
    var type = Get.arguments;
    RxInt liked = 0.obs;
    RxInt total = 0.obs;
    total.value = type[1]['likedBy'].length;
    mediaQueryData = MediaQuery.of(context);
    if (type[1]['likedBy']
        .contains(controller.hController.getUid().toString())) {
      print('trueeeee');
      liked.value = 1;
    } else {
      liked.value = 0;
    }

    return Scaffold(
      backgroundColor: appTheme.whiteA700,
      appBar: CustomAppBar(
        centerTitle: true,
        title: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 22.h,
                left: 22.h,
                //right: 22.h,
              ),
              child: Row(
                children: [
                  SizedBox(
                    height: 30.h,
                    width: 30.h,
                    child: AppbarImage1(
                      onTap: () => Get.back(),
                      svgPath: ImageConstant.imgBackarrow,
                      margin: EdgeInsets.only(
                        top: 6.v,
                        bottom: 5.v,
                      ),
                    ),
                  ),
                  Center(
                    child: AppbarSubtitle(
                      text: type[0].toString(),
                      margin: EdgeInsets.only(left: 95.h),
                    ),
                  ),
                  Spacer(),
                  //Container(color: Colors.black,width: 30, height: 30,margin: EdgeInsets.only(right: 22.h,left: 22.h),)
                ],
              ),
            ),
            SizedBox(height: 20.v),
          ],
        ),
        //styleType: Style.bgFill_1,
      ),
      body: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20.00)),
                  child: Image.network(
                    type[1]['photoUrl'],
                    fit: BoxFit.cover,
                    //height: 100.adaptSize,
                    //width: 100.adaptSize,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: SizedBox(
                    child: Text(
                      "cloths",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: CustomTextStyles
                          .titleMediumAirbnbCerealAppOnPrimary
                          .copyWith(
                        height: 1.71,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: SizedBox(
                    child: Text(
                      type[1]['cloths'],
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: CustomTextStyles.bodyMediumGray700.copyWith(
                        height: 1.71,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(
                      () => liked.value == 1
                          ? CustomIconButton(
                              onTap: () async {
                                type[1]['likedBy'].remove(
                                    controller.hController.getUid().toString());
                                await controller.pController.docFetch
                                    .doc(type[1]['owner'].toString())
                                    .collection(
                                        type[1]['description'].toString())
                                    .doc(type[1]['postId'])
                                    .update({
                                  'likedBy': FieldValue.arrayRemove([
                                    controller.hController.getUid().toString()
                                  ])
                                });
                                liked.value = 0;
                                total.value = total.value - 1;
                                controller.pController.posts.refresh();
                              },
                              height: 41.adaptSize,
                              width: 41.adaptSize,
                              padding: EdgeInsets.all(9.h),
                              decoration: IconButtonStyleHelper.fillGrayProfile,
                              child: CustomImageView(
                                svgPath: ImageConstant.imgFavorite,
                                color: Colors.red,
                              ),
                            )
                          : CustomIconButton(
                              onTap: () async {
                                //TODO: NOTIFICATION
                                type[1]['likedBy'].add(
                                    controller.hController.getUid().toString());
                                await controller.pController.docFetch
                                    .doc(type[1]['owner'].toString())
                                    .collection(
                                        type[1]['description'].toString())
                                    .doc(type[1]['postId'])
                                    .update({
                                  'likedBy': FieldValue.arrayUnion([
                                    controller.hController.getUid().toString()
                                  ])
                                });
                                liked.value = 1;
                                total.value = total.value + 1;
                                controller.pController.posts.refresh();
                                sendLikeNotification(
                                    postOwnerId: type[1]['owner']);
                                //controller.posts.refresh();
                              },
                              height: 41.adaptSize,
                              width: 41.adaptSize,
                              padding: EdgeInsets.all(9.h),
                              decoration: IconButtonStyleHelper.fillGrayProfile,
                              child: CustomImageView(
                                svgPath: ImageConstant.imgFavorite,
                                color: Colors.grey,
                              ),
                            ),
                    ),
                    Obx(
                      () => Padding(
                        padding: EdgeInsets.only(
                          left: 11.h,
                          top: 12.v,
                          bottom: 11.v,
                        ),
                        child: Text(
                          total.value.toString().tr,
                          style: CustomTextStyles.bodySmallNetflixSansGray50003,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(AppRoutes.commentsScreen,
                            arguments: type[1]);
                      },
                      child: CustomIconButton(
                        decoration: IconButtonStyleHelper.fillGrayProfile,
                        height: 41.adaptSize,
                        width: 41.adaptSize,
                        margin: EdgeInsets.only(left: 25.h),
                        padding: EdgeInsets.all(12.h),
                        child: CustomImageView(
                          svgPath: ImageConstant.imgLightbulb,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 8.h,
                        top: 13.v,
                        bottom: 11.v,
                      ),
                      child: Text(
                        type[1]['comments'].toString().tr,
                        style: CustomTextStyles.bodySmallNetflixSansGray50003,
                      ),
                    ),
                    Spacer(),
                    CustomIconButton(
                      decoration: IconButtonStyleHelper.fillGrayProfile,
                      height: 41.adaptSize,
                      width: 41.adaptSize,
                      margin: EdgeInsets.only(left: 25.h),
                      padding: EdgeInsets.all(12.h),
                      child: CustomImageView(
                        imagePath: ImageConstant.imgShareicon,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
