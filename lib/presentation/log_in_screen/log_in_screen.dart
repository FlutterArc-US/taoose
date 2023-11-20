import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:taousapp/core/constants/color_constant.dart';

import '../sign_up_tab_container_screen/controller/sign_up_tab_container_controller.dart';
import 'controller/log_in_controller.dart';
import 'package:flutter/material.dart';
import 'package:taousapp/core/app_export.dart';
import 'package:taousapp/widgets/custom_checkbox_button.dart';
import 'package:taousapp/widgets/custom_elevated_button.dart';
import 'package:taousapp/widgets/custom_icon_button.dart';
import 'package:taousapp/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class LogInScreen extends GetWidget<LogInController> {
  LogInScreen({Key? key})
      : super(
          key: key,
        );
  final SignUpTabContainerController signUpTabContainerController =
      Get.put(SignUpTabContainerController());
  FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.only(
                left: 32.h,
                top: 105.v,
                right: 32.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomImageView(
                    svgPath: ImageConstant.imgFrameIndigo900,
                    height: 45.v,
                    width: 160.h,
                    //margin: EdgeInsets.only(left: 68.h),
                  ),
                  CustomTextFormField(
                    focusNode: controller.emailNode,
                    //autofocus: true,
                    controller: controller.lemailController,
                    margin: EdgeInsets.only(
                      left: 1.h,
                      top: 73.v,
                    ),
                    hintText: "lbl_email_address".tr,
                    hintStyle: CustomTextStyles.bodyMediumGray90005,
                    textInputType: TextInputType.emailAddress,
                    prefix: Container(
                      margin: EdgeInsets.only(
                        top: 1.v,
                        right: 8.h,
                        bottom: 10.v,
                      ),
                      child: CustomImageView(
                        svgPath: ImageConstant.imgCheckmark,
                        color: controller.emailNode.hasFocus
                            ? theme.colorScheme.primary
                            : appTheme.gray500,
                      ),
                    ),
                    prefixConstraints: BoxConstraints(
                      maxHeight: 28.v,
                    ),
                    validator: (email) =>
                        signUpTabContainerController.validateEmail(email),
                    contentPadding: EdgeInsets.only(right: 26.h), inputFormatters: [],
                  ),
                  Obx(
                    () => CustomTextFormField(
                      focusNode: controller.passwordNode,
                      controller: controller.lpasswordController,
                      margin: EdgeInsets.only(
                        left: 1.h,
                        top: 39.v,
                      ),
                      hintText: "lbl_password".tr,
                      hintStyle: CustomTextStyles.bodyMediumGray900,
                      textInputAction: TextInputAction.none,
                      textInputType: TextInputType.visiblePassword,
                      prefix: Container(
                        margin: EdgeInsets.only(
                          top: 2.v,
                          right: 8.h,
                          bottom: 11.v,
                        ),
                        child: CustomImageView(
                          svgPath: ImageConstant.imgLock,
                          color: controller.passwordNode.hasFocus
                              ? theme.colorScheme.primary
                              : appTheme.gray500,
                        ),
                      ),
                      prefixConstraints: BoxConstraints(
                        maxHeight: 31.v,
                      ),
                      suffix: InkWell(
                        onTap: () {
                          controller.isShowPassword.value =
                              !controller.isShowPassword.value;
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            left: 30.h,
                            right: 3.h,
                            bottom: 11.v,
                          ),
                          child: CustomImageView(
                            svgPath: controller.isShowPassword.value
                                ? ImageConstant.imgGroup33621
                                : ImageConstant.imgGroup33621,
                          ),
                        ),
                      ),
                      suffixConstraints: BoxConstraints(
                        maxHeight: 31.v,
                      ),
                      obscureText: controller.isShowPassword.value, inputFormatters: [],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 1.h,
                      top: 22.v,
                      right: 6.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(
                          () => CustomCheckboxButton(
                            text: "lbl_remember_me".tr,
                            value: controller.englishName.value,
                            padding: EdgeInsets.symmetric(vertical: 2.v),
                            onChange: (value) {
                              controller.englishName.value = value;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 3.v,
                            bottom: 2.v,
                          ),
                          child: Text(
                            "lbl_forgot_password".tr,
                            style: CustomTextStyles.bodyMediumRedA400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomElevatedButton(
                    onTap: () async {
                      controller.inLoading.value = true;
                      showLoaderDialog(context);
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState?.save();
                        try {
                          UserCredential result =
                              await _auth.signInWithEmailAndPassword(
                                  email: controller.lemailController.text,
                                  password:
                                      controller.lpasswordController.text);
                          // ignore: unnecessary_null_comparison
                          if (result != null) {
                            controller.inLoading.value = false;
                            Navigator.of(context).pop();
                            Get.offNamedUntil(
                                AppRoutes.homeScreen, (route) => false);
                          }
                        } catch (e) {
                          controller.inLoading.value = false;
                          Get.snackbar('Error',
                              'User not registered or please check information entered',
                              backgroundColor: Colors.white,
                              icon: Icon(
                                Icons.error,
                                color: Colors.red,
                              ));
                          Navigator.of(context).pop();
                        }
                      } else {
                        controller.inLoading.value = false;
                        Get.snackbar(
                            'Error', 'Please check information entered',
                            backgroundColor: Colors.white,
                            icon: Icon(
                              Icons.error,
                              color: Colors.red,
                            ));
                        Navigator.of(context).pop();
                      }
                    },
                    text: "lbl_sign_in".tr,
                    margin: EdgeInsets.only(
                      left: 1.h,
                      top: 20.v,
                    ),
                    buttonStyle: CustomButtonStyles.fillPrimary,
                  ),
                  SizedBox(height: 36.v),
                  Align(
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "msg_don_t_have_an_account2".tr,
                            style: CustomTextStyles.bodyMediumBluegray40001,
                          ),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.toNamed(
                                    AppRoutes.signUpTabContainerScreen,
                                  ),
                            text: "lbl_sign_up".tr,
                            style: CustomTextStyles.bodyMediumPrimary,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      //left: 40.h,
                      top: 37.v,
                      //right: 51.h,
                    ),
                    child: Row(
                      children: [
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.v),
                          child: SizedBox(
                            width: 62.h,
                            child: Divider(
                              color: appTheme.gray200,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 12.h),
                          child: Text(
                            "lbl_or_sign_in_with".tr,
                            style: CustomTextStyles.bodyMediumBluegray300,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.v),
                          child: SizedBox(
                            width: 74.h,
                            child: Divider(
                              color: appTheme.gray200,
                              indent: 12.h,
                            ),
                          ),
                        ),
                        Spacer()
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 37.v),
                    child: Row(
                      children: [
                        Spacer(),
                        CustomIconButton(
                          height: 48.v,
                          width: 72.h,
                          padding: EdgeInsets.all(12.h),
                          decoration: IconButtonStyleHelper.fillGray,
                          child: CustomImageView(
                            svgPath: ImageConstant.imgGooglesymbol1,
                          ),
                        ),
                        CustomIconButton(
                          height: 48.v,
                          width: 72.h,
                          margin: EdgeInsets.only(left: 24.h),
                          padding: EdgeInsets.all(12.h),
                          decoration: IconButtonStyleHelper.fillGray,
                          child: CustomImageView(
                            svgPath: ImageConstant.imgIconapple,
                          ),
                        ),
                        CustomIconButton(
                          height: 48.v,
                          width: 72.h,
                          margin: EdgeInsets.only(left: 24.h),
                          padding: EdgeInsets.all(12.h),
                          decoration: IconButtonStyleHelper.fillGray,
                          child: CustomImageView(
                            svgPath: ImageConstant.imgIconfacebook,
                          ),
                        ),
                        Spacer(),
                        /*CustomImageView(
                          svgPath: ImageConstant.imgIconfacebook,
                          height: 24.adaptSize,
                          width: 24.adaptSize,
                        ),*/
                      ],
                    ),
                  ),
                ],
              ),
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
            margin: EdgeInsets.only(left: 20),
            child: Text(
              "Logging in...",
              style: CustomTextStyles.bodyMediumBluegray40001,
            )),
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
