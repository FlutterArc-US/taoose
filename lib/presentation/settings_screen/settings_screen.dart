import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:taousapp/core/constants/color_constant.dart';
import 'package:taousapp/presentation/home_screen/controller/home_controller.dart';

import 'controller/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:taousapp/core/app_export.dart';
import 'package:taousapp/widgets/app_bar/appbar_image_1.dart';
import 'package:taousapp/widgets/app_bar/appbar_subtitle.dart';
import 'package:taousapp/widgets/app_bar/custom_app_bar.dart';
import 'package:taousapp/widgets/custom_checkbox_button.dart';

// ignore_for_file: must_be_immutable
class SettingsScreen extends GetWidget<SettingsController> {
  SettingsScreen({Key? key})
      : super(
          key: key,
        );
  final HomeController searchcontroller = Get.put(HomeController());
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> removeFcmToken() async {
    var user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final fcmToken = await FirebaseMessaging.instance.getToken();

      await FirebaseFirestore.instance
          .collection('TaousUser')
          .doc(user.uid.toString())
          .set(
        {
          'fcmTokens': FieldValue.arrayRemove([fcmToken])
        },
        SetOptions(merge: true),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: true,
        title: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 22.h,
                left: 22.h,
              ),
              child: Row(
                children: [
                  SizedBox(
                    height: 30.h,
                    width: 30.h,
                    child: AppbarImage1(
                      onTap: () => Get.back(),
                      svgPath: ImageConstant.imgCloseX,
                      margin: EdgeInsets.only(
                        top: 6.v,
                        bottom: 5.v,
                      ),
                    ),
                  ),
                  Center(
                    child: AppbarSubtitle(
                      text: "lbl_settings".tr,
                      margin: EdgeInsets.only(left: 95.h),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            SizedBox(height: 20.v),
          ],
        ),
        //styleType: Style.bgFill_1,
      ),
      body: SizedBox(
        width: mediaQueryData.size.width,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 19.v),
          child: Padding(
            padding: EdgeInsets.only(left: 23.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 25.h),
                  child: Row(
                    children: [
                      CustomImageView(
                        svgPath: ImageConstant.imgSettingsBlueGray400,
                        height: 22.adaptSize,
                        width: 22.adaptSize,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16.h),
                        child: Text(
                          "lbl_general".tr,
                          style: CustomTextStyles.bodyMediumOnPrimaryContainer,
                        ),
                      ),
                      Spacer(),
                      CustomImageView(
                        svgPath: ImageConstant.imgArrowright,
                        height: 20.adaptSize,
                        width: 20.adaptSize,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 32.v,
                    right: 25.h,
                  ),
                  child: InkWell(
                    child: Row(
                      children: [
                        CustomImageView(
                          svgPath: ImageConstant.imgUserBlueGray400,
                          height: 24.adaptSize,
                          width: 24.adaptSize,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 16.h,
                            top: 2.v,
                          ),
                          child: Text(
                            //  "lbl_account_details".tr,
                            "Account Management",
                            style:
                                CustomTextStyles.bodyMediumOnPrimaryContainer,
                          ),
                        ),
                        Spacer(),
                        CustomImageView(
                          svgPath: ImageConstant.imgArrowright,
                          height: 20.adaptSize,
                          width: 20.adaptSize,
                        ),
                      ],
                    ),
                    onTap: () => Get.toNamed(AppRoutes.accountManagementScreen),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 32.v,
                    right: 25.h,
                  ),
                  child: Row(
                    children: [
                      CustomImageView(
                        svgPath: ImageConstant.imgIconsglobeline,
                        height: 24.adaptSize,
                        width: 24.adaptSize,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 16.h,
                          top: 3.v,
                        ),
                        child: Text(
                          "lbl_language".tr,
                          style: CustomTextStyles.bodyMediumOnPrimaryContainer,
                        ),
                      ),
                      Spacer(),
                      CustomImageView(
                        svgPath: ImageConstant.imgArrowright,
                        height: 20.adaptSize,
                        width: 20.adaptSize,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 32.v,
                    right: 25.h,
                  ),
                  child: Row(
                    children: [
                      CustomImageView(
                        svgPath: ImageConstant.imgNotification,
                        height: 24.adaptSize,
                        width: 24.adaptSize,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 16.h,
                          top: 2.v,
                        ),
                        child: Text(
                          "lbl_notification".tr,
                          style: CustomTextStyles.bodyMediumOnPrimaryContainer,
                        ),
                      ),
                      Spacer(),
                      CustomImageView(
                        svgPath: ImageConstant.imgArrowright,
                        height: 20.adaptSize,
                        width: 20.adaptSize,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 32.v,
                    right: 25.h,
                  ),
                  child: Row(
                    children: [
                      CustomImageView(
                        svgPath: ImageConstant.imgIconsmedicalchartline,
                        height: 24.adaptSize,
                        width: 24.adaptSize,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 16.h,
                          top: 2.v,
                        ),
                        child: Text(
                          "lbl_terms_of_use".tr,
                          style: CustomTextStyles.bodyMediumOnPrimaryContainer,
                        ),
                      ),
                      Spacer(),
                      CustomImageView(
                        svgPath: ImageConstant.imgArrowright,
                        height: 20.adaptSize,
                        width: 20.adaptSize,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 32.v,
                    right: 25.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => CustomCheckboxButton(
                          text: "lbl_pricavy_policy".tr,
                          value: controller.privacyPolicy.value,
                          padding: EdgeInsets.symmetric(vertical: 1.v),
                          textStyle:
                              CustomTextStyles.bodyMediumOnPrimaryContainer,
                          onChange: (value) {
                            controller.privacyPolicy.value = value;
                          },
                        ),
                      ),
                      CustomImageView(
                        svgPath: ImageConstant.imgArrowright,
                        height: 20.adaptSize,
                        width: 20.adaptSize,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 32.v,
                    right: 25.h,
                  ),
                  child: Row(
                    children: [
                      CustomImageView(
                        svgPath: ImageConstant.imgMail,
                        height: 24.adaptSize,
                        width: 24.adaptSize,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 16.h,
                          top: 3.v,
                        ),
                        child: Text(
                          "lbl_help".tr,
                          style: CustomTextStyles.bodyMediumOnPrimaryContainer,
                        ),
                      ),
                      Spacer(),
                      CustomImageView(
                        svgPath: ImageConstant.imgArrowright,
                        height: 20.adaptSize,
                        width: 20.adaptSize,
                        margin: EdgeInsets.only(bottom: 3.v),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 32.v,
                    right: 25.h,
                  ),
                  child: Row(
                    children: [
                      CustomImageView(
                        svgPath: ImageConstant.imgIconsinfocircleline,
                        height: 24.adaptSize,
                        width: 24.adaptSize,
                        onTap: () async {
                          await SettingsController().signOut();
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 16.h,
                          top: 2.v,
                        ),
                        child: Text(
                          "lbl_about".tr,
                          style: CustomTextStyles.bodyMediumOnPrimaryContainer,
                        ),
                      ),
                      Spacer(),
                      CustomImageView(
                        svgPath: ImageConstant.imgArrowright,
                        height: 20.adaptSize,
                        width: 20.adaptSize,
                        margin: EdgeInsets.only(bottom: 3.v),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: getPadding(
                      left: 5,
                      top: 159,
                      right: 10,
                    ),
                    child: InkWell(
                      child: Text(
                        "lbl_logout".tr,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        //   style: AppStyle.txtMontserratMedium18,
                      ),
                      onTap: () async {
                        try {
                          await removeFcmToken();
                          await _auth.signOut();
                          Get.offNamedUntil(
                              AppRoutes.logInScreen, (route) => false);
                          print("logout");
                        } catch (e) {}
                      },
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: new Row(
      children: [
        LoadingAnimationWidget.flickr(
          leftDotColor: ColorConstant.taous1,
          rightDotColor: ColorConstant.taous2,
          size: 30,
        ),
        Container(
            margin: EdgeInsets.only(left: 20), child: Text("Signing out...")),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
