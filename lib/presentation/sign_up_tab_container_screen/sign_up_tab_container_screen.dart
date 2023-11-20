import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:taousapp/main.dart';

import '../../core/constants/color_constant.dart';
import '../../widgets/custom_elevated_button.dart';
import 'controller/sign_up_tab_container_controller.dart';
import 'package:flutter/material.dart';
import 'package:taousapp/core/app_export.dart';
import 'package:taousapp/core/utils/validation_functions.dart';
import 'package:taousapp/widgets/custom_text_form_field.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

// ignore_for_file: must_be_immutable
class SignUpTabContainerScreen extends GetWidget<SignUpTabContainerController> {
  SignUpTabContainerScreen({Key? key})
      : super(
          key: key,
        );

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomImageView(
                  svgPath: ImageConstant.imgBackarrow,
                  height: 16.v,
                  onTap: () => Get.back(),
                  width: 9.h,
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(
                    left: 23.h,
                    top: 40.v,
                  ),
                ),
                CustomImageView(
                  svgPath: ImageConstant.imgFrameIndigo900,
                  height: 45.v,
                  width: 160.h,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                    bottom: 20.v,
                    top: 57.v,
                  ),
                ),
                CustomTextFormField(
                  controller: controller.fullNameController,
                  margin: EdgeInsets.only(
                    left: 33.h,
                    top: 44.v,
                    right: 32.h,
                  ),
                  focusNode: controller.fullNameNode,
                  hintText: "lbl_full_name".tr,
                  hintStyle: CustomTextStyles.bodyMediumGray90005,
                  prefix: Container(
                    margin: EdgeInsets.only(
                      top: 1.v,
                      right: 8.h,
                      bottom: 10.v,
                    ),
                    child: CustomImageView(
                      svgPath: ImageConstant.imgUser,
                      color: controller.fullNameNode.hasFocus
                          ? theme.colorScheme.primary
                          : appTheme.gray500,
                    ),
                  ),
                  prefixConstraints: BoxConstraints(
                    maxHeight: 28.v,
                  ),
                  validator: (fullname) =>
                      controller.validateFullName(fullname),
                  contentPadding: EdgeInsets.only(right: 26.h),
                  inputFormatters: [],
                ),
                CustomTextFormField(
                  controller: controller.userNameController,
                  margin: EdgeInsets.only(
                    left: 33.h,
                    top: 42.v,
                    right: 32.h,
                  ),
                  focusNode: controller.usernameNode,
                  hintText: "lbl_username".tr,
                  hintStyle: CustomTextStyles.bodyMediumGray90005,
                  prefix: Container(
                    margin: EdgeInsets.only(
                      top: 1.v,
                      right: 8.h,
                      bottom: 10.v,
                    ),
                    child: CustomImageView(
                      svgPath: ImageConstant.imgUser,
                      color: controller.usernameNode.hasFocus
                          ? theme.colorScheme.primary
                          : appTheme.gray500,
                    ),
                  ),
                  prefixConstraints: BoxConstraints(
                    maxHeight: 28.v,
                  ),
                  validator: (username) =>
                      controller.validateUserName(username),
                  contentPadding: EdgeInsets.only(right: 26.h),
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r'\s')),
                  ],
                ),
                // CustomTextFormField(
                //   controller: controller.phoneController,
                //   margin: EdgeInsets.only(
                //     left: 31.h,
                //     top: 42.v,
                //     right: 32.h,
                //   ),
                //   hintText: "msg_11_phone_numbe".tr,
                //   hintStyle: CustomTextStyles.bodyMediumGray90005,
                //   textInputType: TextInputType.phone,
                //   validator: (value) {
                //     if (!isValidPhone(value)) {
                //       return "Please enter valid phone number";
                //     }
                //     return null;
                //   },
                // ),
                CustomTextFormField(
                  inputFormatters: [],
                  controller: controller.emailController,
                  margin: EdgeInsets.only(
                    left: 33.h,
                    top: 42.v,
                    right: 32.h,
                  ),
                  focusNode: controller.emailNode,
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
                  validator: (value) {
                    if (value == null ||
                        (!isValidEmail(value, isRequired: true))) {
                      return "Please enter valid email";
                    }
                    return null;
                  },
                  contentPadding: EdgeInsets.only(right: 26.h),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 33, right: 32, top: 42),
                  child: IntlPhoneField(
                    focusNode: controller.phoneNode,
                    controller: controller.phoneController,
                    disableLengthCheck: true,
                    onChanged: (phone) {
                      controller.phoneNo.value =
                          phone.countryCode + phone.number;
                      //print (phone.countryCode  +  phone.number);
                    },
                    decoration: InputDecoration(
                      hintStyle: CustomTextStyles.bodyMediumBlack900,
                      contentPadding: EdgeInsets.symmetric(vertical: 2.v),

                      fillColor:
                          theme.colorScheme.primaryContainer.withOpacity(1),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: theme.colorScheme.primary)),
                      //   labelText: 'Phone Number',
                      labelStyle: CustomTextStyles.titleSmallBluegray40001,

                      prefixIconConstraints: BoxConstraints(maxHeight: 28.v),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: appTheme.gray100)),
                    ),

                    initialCountryCode: 'SA',
                    // validator: (value) {
                    //   if (value == null || value.number.isEmpty) {
                    //     return null;
                    //   }
                    //   return 'Please enter vaild phone number.';
                    // },
                  ),
                ),

                Obx(
                  () => CustomTextFormField(
                    focusNode: controller.passwordNode,
                    controller: controller.passwordController,
                    margin: EdgeInsets.only(
                      left: 33.h,
                      top: 39.v,
                      right: 32.h,
                    ),
                    hintText: "lbl_password".tr,
                    hintStyle: CustomTextStyles.bodyMediumGray900,
                    textInputAction: TextInputAction.done,
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
                    validator: (value) {
                      if (value != controller.passwordController.text) {
                        // password validation
                        return "Password do not match.";
                      }
                      return null;
                    },
                    obscureText: controller.isShowPassword.value,
                    inputFormatters: [],
                  ),
                ),
                Obx(
                  () => CustomTextFormField(
                    focusNode: controller.cpasswordNode,
                    controller: controller.confirmpasswordController,
                    margin: EdgeInsets.only(
                      left: 33.h,
                      top: 39.v,
                      right: 32.h,
                    ),
                    hintText: "msg_confirm_password".tr,
                    hintStyle: CustomTextStyles.bodyMediumGray900,
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.visiblePassword,
                    prefix: Container(
                      margin: EdgeInsets.only(
                        top: 2.v,
                        right: 8.h,
                        bottom: 11.v,
                      ),
                      child: CustomImageView(
                        svgPath: ImageConstant.imgLock,
                        color: controller.cpasswordNode.hasFocus
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
                    validator: (value) {
                      if (value != controller.passwordController.text) {
                        // password validation
                        return "Password do not match.";
                      }
                      return null;
                    },
                    obscureText: controller.isShowPassword.value,
                    inputFormatters: [],
                  ),
                ),

                SizedBox(height: 20.v),
                Center(
                  child: Container(
                    height: 43.v,
                    width: 307.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        10.h,
                      ),
                      border: Border.all(
                        color: appTheme.gray20002,
                        width: 1.h,
                      ),
                    ),
                    child: TabBar(
                      controller: controller.tabviewController,
                      labelPadding: EdgeInsets.zero,
                      labelColor:
                          theme.colorScheme.primaryContainer.withOpacity(1),
                      labelStyle: TextStyle(
                        fontSize: 14.fSize,
                        fontFamily: 'Nunito Sans',
                        fontWeight: FontWeight.w700,
                      ),
                      unselectedLabelColor: appTheme.gray900,
                      unselectedLabelStyle: TextStyle(
                        fontSize: 14.fSize,
                        fontFamily: 'Nunito Sans',
                        fontWeight: FontWeight.w400,
                      ),
                      indicator: BoxDecoration(
                        color: appTheme.black900, //indigo900
                        borderRadius: BorderRadius.circular(
                          10.h,
                        ),
                      ),
                      tabs: [
                        Tab(
                          child: Text(
                            "lbl_male".tr,
                          ),
                        ),
                        Tab(
                          child: Text(
                            "lbl_female".tr,
                          ),
                        ),
                        Tab(
                          child: Text(
                            "lbl_later".tr,
                          ),
                        ),
                      ],
                      onTap: (index) {
                        String selectedGender = index == 0
                            ? 'male'
                            : index == 1
                                ? 'female'
                                : 'other';
                        controller.changeGender(selectedGender);
                        print(selectedGender);
                      },
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(
                    left: 32.h,
                    top: 22.v,
                    right: 32.h,
                  ),
                  child: Column(
                    children: [
                      CustomElevatedButton(
                        onTap: () async {
                          controller.inLoading.value = true;
                          print(controller.tabviewController);
                          showLoaderDialog(context);
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState?.save();
                            try {
                              UserCredential result = await FirebaseAuth
                                  .instance
                                  .createUserWithEmailAndPassword(
                                      email: controller.emailController.text,
                                      password:
                                          controller.passwordController.text)
                                  .then((value) {
                                value.user?.updateDisplayName(controller
                                    .fullNameController.text
                                    .toLowerCase());
                                return value;
                              });

                              await FirebaseFirestore.instance
                                  .collection('TaousUser')
                                  .doc(result.user?.uid)
                                  .set({
                                'notifications': [
                                  {
                                    'id': 0,
                                    'timestamp': DateTime.now(),
                                    'notification': [
                                      'Welcome, ${controller.fullNameController.text.toUpperCase()}!',
                                      'Please activate your account through the link sent on your email.'
                                    ]
                                  }
                                ],
                                'uid': result.user!.uid,
                                'email': controller.emailController.text
                                    .toLowerCase(),
                                'fullName': controller.fullNameController.text
                                    .toLowerCase(),
                                'UserName': controller.userNameController.text
                                    .toLowerCase(),
                                'PhoneNo': controller.phoneNo.value,
                                'Geneder': controller.selectedGender.value,
                                'followers': [],
                                'following': [],
                                'requests': [],
                                'token': "",
                                'accountType': 1
                              });
                              controller.flutterLocalNotificationsPlugin.show(
                                  hashCode,
                                  'Welcome, ${controller.fullNameController.text.toUpperCase()}!',
                                  'Please activate your account through the link sent on your email.',
                                  NotificationDetails(
                                    android: AndroidNotificationDetails(
                                      channel.id,
                                      channel.name,
                                      //channel.description,
                                      color: Colors.white,
                                      // ignore: todo
                                      // TODO add a proper drawable resource to android, for now using
                                      //      one that already exists in example app.
                                      icon: "@mipmap/ic_launcher",
                                      enableVibration: true,
                                    ),
                                  ));
                              controller.inLoading.value = false;
                              Navigator.of(context).pop();
                              Get.back();
                            } catch (e) {
                              controller.inLoading.value = false;
                              print("erooooooooooor" + e.toString());
                              Get.snackbar('Error',
                                  'User might already exist or please check information entered',
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
                        text: "lbl_sign_up2".tr,
                        buttonStyle: CustomButtonStyles.fillPrimary,
                      ),
                      SizedBox(height: 36.v),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "msg_already_have_an2".tr + ' ',
                              style: CustomTextStyles.bodyMediumBluegray40001,
                            ),
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Get.back(),
                              text: "lbl_sign_in".tr,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight:
                                    FontWeight.bold, // Make the text bold
                              ), //CustomTextStyles.bodyMediumPrimary,
                            ),
                          ],
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Container(
                        width: 245.h,
                        margin: EdgeInsets.only(
                            left: 31.h, top: 36.v, right: 33.h, bottom: 30.v),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "msg_by_signing_up_you2".tr,
                                style: CustomTextStyles.labelLargeBluegray40001,
                              ),
                              TextSpan(
                                text: "lbl_terms".tr,
                                style: CustomTextStyles.labelLargeGray90002,
                              ),
                              TextSpan(
                                text: "lbl_and".tr,
                                style: CustomTextStyles.labelLargeBluegray40001,
                              ),
                              TextSpan(
                                text: "msg_conditions_of_use".tr,
                                style: CustomTextStyles.labelLargeGray90002,
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
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
                "Creating your account...",
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
}
