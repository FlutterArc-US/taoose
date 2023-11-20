import 'package:taousapp/widgets/custom_elevated_button.dart';

import 'controller/personal_information_controller.dart';
import 'package:flutter/material.dart';
import 'package:taousapp/core/app_export.dart';
import 'package:taousapp/widgets/app_bar/appbar_image_1.dart';
import 'package:taousapp/widgets/app_bar/appbar_subtitle.dart';
import 'package:taousapp/widgets/app_bar/custom_app_bar.dart';

// ignore_for_file: must_be_immutable
class GenderScreen extends GetWidget<PersonalInformationController> {
  GenderScreen({Key? key})
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
                      text: "lbl_gender".tr,
                      margin: EdgeInsets.only(left: 100.h),
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
            children: <Widget>[
              Obx(()=>
                Column(
                  children: <Widget>[
                    ListTile(
                      title: const Text('Male'),
                      trailing: Radio<GenderOption>(
                        value: GenderOption.male,
                        groupValue: controller.selectedGender.value,
                        onChanged: (value) {controller.setGender(value!);print(value.toString());}, 
                        activeColor: Colors.black,
                      ),
                    ),
                    ListTile(
                      title: const Text('Female'),
                      trailing: Radio<GenderOption>(
                        value: GenderOption.female,
                        groupValue: controller.selectedGender.value,
                        onChanged: (value) {controller.setGender(value!);print(value.toString());},
                        activeColor: Colors.black,
                      ),
                    ),
                    ListTile(
                      title: const Text('Custom'),
                      trailing: Radio<GenderOption>(
                        value: GenderOption.custom,
                        groupValue: controller.selectedGender.value,
                        onChanged: (value) {controller.setGender(value!);print(value.toString());},
                        activeColor: Colors.black,
                      ),
                    ),
                    Obx(() {
                      if (controller.selectedGender.value ==
                          GenderOption.custom) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            onChanged: controller.setCustomGenderText,
                            decoration: const InputDecoration(
                              hintText: 'How do you identify?',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    }),
                    // Add other widgets like a submit button here
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 35.0, right: 35.0),
                child: CustomElevatedButton(
                    text: "Update",
                    margin: EdgeInsets.only(
                      left: 1.h,
                      top: 20.v,
                    ),
                    buttonStyle: CustomButtonStyles.fillPrimary,
                    onTap: () async {
                      String gender =
                          controller.selectedGender.value == GenderOption.custom
                              ? controller.customGenderText.value
                              : controller.selectedGender.value
                                  .toString()
                                  .split('.')
                                  .last;
                      print("Selected Gender: $gender"); //
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
