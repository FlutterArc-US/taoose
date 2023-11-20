import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
class BirthdayScreen extends GetWidget<PersonalInformationController> {
  BirthdayScreen({Key? key})
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
                      text: "lbl_birthday".tr,
                      margin: EdgeInsets.only(left: 40.h),
                    ),
                  ),
                  const Spacer(),
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
        child: Padding(
          padding: EdgeInsets.only(left: 23.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 25.h),
                child: Expanded(
                  child: Text(
                    "lbl_birthday_msg".tr,
                    style: CustomTextStyles.bodyMediumGray900,
                  ),
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    controller.pickDate(context);
                  },
                  child: Obx(() {
                    return Text(
                      controller.selectedDate.value != null
                          ? 'Selected Date: ${controller.selectedDate.value!.toLocal().format('MMM dd, yyy')}'
                          : 'Tap to Select Birthday',
                      style: const TextStyle(fontSize: 18),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
