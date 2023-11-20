import 'controller/make_complaint_controller.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:taousapp/core/app_export.dart';
import 'package:taousapp/widgets/app_bar/appbar_image_1.dart';
import 'package:taousapp/widgets/app_bar/appbar_subtitle.dart';
import 'package:taousapp/widgets/app_bar/custom_app_bar.dart';
import 'package:taousapp/widgets/custom_elevated_button.dart';
import 'package:taousapp/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class MakeComplaintScreen extends GetWidget<MakeComplaintController> {
  const MakeComplaintScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: appTheme.gray10002,
        appBar: CustomAppBar(
          centerTitle: true,
          title: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 22.h,
                  right: 112.h,
                ),
                child: Row(
                  children: [
                    AppbarImage1(
                      svgPath: ImageConstant.imgBackarrow,
                      margin: EdgeInsets.only(
                        top: 4.v,
                        bottom: 7.v,
                      ),
                    ),
                    AppbarSubtitle(
                      text: "lbl_make_complaint".tr,
                      margin: EdgeInsets.only(left: 79.h),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 14.v),
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: 374.h,
                  child: Divider(
                    color: appTheme.gray20002,
                  ),
                ),
              ),
            ],
          ),
          styleType: Style.bgFill_1,
        ),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 23.h,
            vertical: 11.v,
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(right: 2.h),
                padding: EdgeInsets.symmetric(
                  horizontal: 20.h,
                  vertical: 24.v,
                ),
                decoration: AppDecoration.fillWhiteA.copyWith(
                  borderRadius: BorderRadiusStyle.circleBorder20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "lbl_reason".tr,
                      style: CustomTextStyles.bodyMediumGray9000214,
                    ),
                    SizedBox(height: 8.v),
                    CustomTextFormField(
                      controller: controller.enterherreoneController,
                      hintText: "lbl_enter_here".tr,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12.h,
                        vertical: 16.v,
                      ),
                      borderDecoration: TextFormFieldStyleHelper.fillGray,
                      fillColor: appTheme.gray10001, inputFormatters: [],
                    ),
                    SizedBox(height: 18.v),
                    Text(
                      "msg_further_explained".tr,
                      style: CustomTextStyles.bodyMediumGray9000214,
                    ),
                    SizedBox(height: 7.v),
                    CustomTextFormField(
                      controller: controller.enterherreController,
                      hintText: "lbl_enter_herre".tr,
                      textInputAction: TextInputAction.done,
                      maxLines: 10,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20.h,
                        vertical: 21.v,
                      ),
                      borderDecoration: TextFormFieldStyleHelper.fillGray,
                      fillColor: appTheme.gray10001, inputFormatters: [],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 12.v,
                  right: 2.h,
                  bottom: 9.v,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 20.h,
                  vertical: 24.v,
                ),
                decoration: AppDecoration.fillWhiteA.copyWith(
                  borderRadius: BorderRadiusStyle.circleBorder20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 2.v),
                    Text(
                      "lbl_upload".tr,
                      style: CustomTextStyles.bodyMediumGray9000214,
                    ),
                    SizedBox(height: 7.v),
                    DottedBorder(
                      color: appTheme.gray300.withOpacity(0.87),
                      padding: EdgeInsets.only(
                        left: 1.h,
                        top: 1.v,
                        right: 1.h,
                        bottom: 1.v,
                      ),
                      strokeWidth: 1.h,
                      radius: Radius.circular(12),
                      borderType: BorderType.RRect,
                      dashPattern: [
                        2,
                        2,
                      ],
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 113.h,
                          vertical: 25.v,
                        ),
                        decoration: AppDecoration.outlineGray300.copyWith(
                          borderRadius: BorderRadiusStyle.roundedBorder13,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomImageView(
                              svgPath: ImageConstant.imgSharePrimary,
                              height: 39.adaptSize,
                              width: 39.adaptSize,
                            ),
                            SizedBox(height: 1.v),
                            Text(
                              "lbl_upload_file".tr,
                              style: CustomTextStyles.bodySmallOnError,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: CustomElevatedButton(
          text: "lbl_submit".tr,
          margin: EdgeInsets.only(
            left: 33.h,
            right: 32.h,
            bottom: 42.v,
          ),
          buttonStyle: CustomButtonStyles.fillPrimary,
        ),
      ),
    );
  }
}
