import 'controller/account_management_controller.dart';
import 'package:flutter/material.dart';
import 'package:taousapp/core/app_export.dart';
import 'package:taousapp/widgets/app_bar/appbar_image_1.dart';
import 'package:taousapp/widgets/app_bar/appbar_subtitle.dart';
import 'package:taousapp/widgets/app_bar/custom_app_bar.dart';

// ignore_for_file: must_be_immutable
class AccountManagementScreen extends GetWidget<AccountManagementController> {
  AccountManagementScreen({Key? key})
      : super(
          key: key,
        );

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
                      svgPath: ImageConstant.imgBackarrow,
                      margin: EdgeInsets.only(
                        top: 6.v,
                        bottom: 5.v,
                      ),
                    ),
                  ),
                  Center(
                    child: AppbarSubtitle(
                      text: "Account Management", //.re
                      margin: EdgeInsets.only(left: 50.h),
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
                InkWell(
                  child: Padding(
                    padding: EdgeInsets.only(right: 25.h),
                    child: Row(
                      children: [
                        CustomImageView(
                          svgPath: ImageConstant.imgUserBlueGray400,
                          height: 22.adaptSize,
                          width: 22.adaptSize,
                          color: appTheme.gray500,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16.h),
                          child: Text(
                            "Personal Information",
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
                  ),
                  onTap: () => Get.toNamed(AppRoutes.personalInformationScreen),
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
                          svgPath: ImageConstant.imgMail,
                          height: 24.adaptSize,
                          width: 24.adaptSize,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 16.h,
                            top: 2.v,
                          ),
                          child: Text(
                            "Email",
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
                    //       onTap: ,
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
                          "Password",
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
                          "Deactivate Account".tr,
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
                          "Delete Account",
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
                          "Security",
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
        CircularProgressIndicator(),
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
