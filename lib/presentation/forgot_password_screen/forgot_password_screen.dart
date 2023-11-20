import 'controller/forgot_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:taousapp/core/app_export.dart';
import 'package:taousapp/core/utils/validation_functions.dart';
import 'package:taousapp/widgets/custom_elevated_button.dart';
import 'package:taousapp/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class ForgotPasswordScreen extends GetWidget<ForgotPasswordController> {
  ForgotPasswordScreen({Key? key})
      : super(
          key: key,
        );

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(bottom: 105.v),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        height: 215.v,
                        width: 260.h,
                        child: Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: SizedBox(
                                height: 173.v,
                                width: 135.h,
                                child: Stack(
                                  alignment: Alignment.topLeft,
                                  children: [
                                    Opacity(
                                      opacity: 0.5,
                                      child: CustomImageView(
                                        imagePath: ImageConstant.imgEllipse66,
                                        height: 173.v,
                                        width: 135.h,
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                    CustomImageView(
                                      svgPath: ImageConstant.imgBackarrow,
                                      height: 16.v,
                                      width: 9.h,
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.only(
                                        left: 23.h,
                                        top: 66.v,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: 32.h,
                                  bottom: 10.v,
                                ),
                                child: Row(
                                  children: [
                                    CustomImageView(
                                      svgPath: ImageConstant.imgG430,
                                      height: 1.adaptSize,
                                      width: 1.adaptSize,
                                    ),
                                    CustomImageView(
                                      svgPath: ImageConstant.imgPath534,
                                      height: 1.adaptSize,
                                      width: 1.adaptSize,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            CustomImageView(
                              svgPath: ImageConstant.imgFrameIndigo900,
                              height: 45.v,
                              width: 160.h,
                              alignment: Alignment.bottomRight,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 33.v),
                    Text(
                      "lbl_forgot_password".tr,
                      style: CustomTextStyles.titleLargeOnPrimary,
                    ),
                    Container(
                      width: 292.h,
                      margin: EdgeInsets.only(
                        left: 41.h,
                        top: 10.v,
                        right: 40.h,
                      ),
                      child: Text(
                        "msg_please_enter_your".tr,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style:
                            CustomTextStyles.bodyMediumGray60002Light.copyWith(
                          height: 1.67,
                        ),
                      ),
                    ),
                    CustomTextFormField(
                      controller: controller.emailController,
                      margin: EdgeInsets.only(
                        left: 33.h,
                        top: 35.v,
                        right: 32.h,
                      ),
                      hintText: "lbl_email_address".tr,
                      hintStyle: CustomTextStyles.bodyMediumGray90005,
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.emailAddress,
                      prefix: Container(
                        margin: EdgeInsets.only(
                          top: 1.v,
                          right: 8.h,
                          bottom: 10.v,
                        ),
                        child: CustomImageView(
                          svgPath: ImageConstant.imgCheckmark,
                        ),
                      ),
                      prefixConstraints: BoxConstraints(
                        maxHeight: 28.v,
                      ),
                      validator: (value) {
                        if (value == null ||
                            (!isValidEmail(value, isRequired: true))) {
                          return "Please enter valid email";
                        }
                        return null;
                      },
                      contentPadding: EdgeInsets.only(right: 26.h), inputFormatters: [],
                    ),
                    CustomElevatedButton(
                      text: "lbl_sign_in".tr,
                      margin: EdgeInsets.only(
                        left: 33.h,
                        top: 23.v,
                        right: 32.h,
                      ),
                      buttonStyle: CustomButtonStyles.fillPrimary,
                    ),
                    SizedBox(height: 272.v),
                    Opacity(
                      opacity: 0.4,
                      child: CustomImageView(
                        imagePath: ImageConstant.imgEllipse71,
                        height: 173.v,
                        width: 82.h,
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
