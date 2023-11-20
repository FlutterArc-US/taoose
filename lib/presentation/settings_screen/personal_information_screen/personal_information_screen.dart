import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:taousapp/presentation/home_screen/controller/home_controller.dart';
import 'package:taousapp/presentation/settings_screen/controller/settings_controller.dart';

import 'controller/personal_information_controller.dart';
import 'package:flutter/material.dart';
import 'package:taousapp/core/app_export.dart';
import 'package:taousapp/widgets/app_bar/appbar_image_1.dart';
import 'package:taousapp/widgets/app_bar/appbar_subtitle.dart';
import 'package:taousapp/widgets/app_bar/custom_app_bar.dart';

// ignore_for_file: must_be_immutable
class PersonalInformationScreen
    extends GetWidget<PersonalInformationController> {
  PersonalInformationScreen({Key? key})
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
                      text: "lbl_personal_information".tr,
                      margin: EdgeInsets.only(left: 40.h),
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
          padding: EdgeInsets.only(top: 8.v),
          child: Padding(
            padding: EdgeInsets.only(left: 23.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.only(right: 25.h),
                    child: Container(
                      child: Expanded(
                        child: Text(
                          "lbl_personal_information_msg".tr,
                          style: CustomTextStyles.bodyMediumGray900,
                        ),
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.only(
                    top: 32.v,
                    right: 25.h,
                  ),
                  child: InkWell(
                    child: Row(
                      children: [
                        Icon(
                          LineIcons.birthdayCake,
                          color: appTheme.gray500,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 16.h,
                            top: 2.v,
                          ),
                          child: Text(
                            "lbl_birthday".tr,
                            style:
                                CustomTextStyles.bodyMediumOnPrimaryContainer,
                          ),
                        ),
                        const Spacer(
                          flex: 3,
                        ),
                        // Obx(() {
                        //   if (controller.hController.gender.value != null) {
                        //     return Text(
                        //       DateFormat('MMM dd, yyyy')
                        //           .format(controller.selectedDate.value!),
                        //       style:
                        //           CustomTextStyles.bodyMediumOnPrimaryContainer,
                        //     );
                        //   } else {
                        //     return const SizedBox
                        //         .shrink(); // Or show default text/message
                        //   }
                        // }),
                        Obx(() => Text(
                              controller.hController.birthday.value,
                              style:
                                  CustomTextStyles.bodyMediumOnPrimaryContainer,
                            )),
                        const Spacer(),
                        CustomImageView(
                          svgPath: ImageConstant.imgArrowright,
                          height: 20.adaptSize,
                          width: 20.adaptSize,
                        ),
                      ],
                    ),
                    onTap: () => Get.toNamed(AppRoutes.birthdayScreen),
                  ),
                ),
                InkWell(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 32.v,
                      right: 25.h,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          LineIcons.genderless,
                          color: appTheme.gray500,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 16.h,
                            top: 3.v,
                          ),
                          child: Text(
                            "lbl_gender".tr,
                            style:
                                CustomTextStyles.bodyMediumOnPrimaryContainer,
                          ),
                        ),
                        const Spacer(
                          flex: 3,
                        ),
                        Obx(() => Text(
                              controller.hController.gender.value,
                              style:
                                  CustomTextStyles.bodyMediumOnPrimaryContainer,
                            )),
                        const Spacer(),
                        CustomImageView(
                          svgPath: ImageConstant.imgArrowright,
                          height: 20.adaptSize,
                          width: 20.adaptSize,
                        ),
                      ],
                    ),
                  ),
                  onTap: () => Get.toNamed(AppRoutes.genderScreen),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 32.v,
                    right: 25.h,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        LineIcons.mapMarked,
                        color: appTheme.gray500,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 16.h,
                          top: 2.v,
                        ),
                        child: Text(
                          "lbl_location".tr,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
