import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:taousapp/core/app_export.dart';
import 'package:taousapp/core/constants/color_constant.dart';
import 'package:taousapp/widgets/app_bar/appbar_image_1.dart';
import 'package:taousapp/widgets/app_bar/appbar_subtitle.dart';
import 'package:taousapp/widgets/app_bar/custom_app_bar.dart';
import 'package:taousapp/widgets/cusom_text_form_field1.dart';
import 'package:taousapp/widgets/custom_elevated_button.dart';
import 'package:taousapp/widgets/custom_icon_button.dart';
import 'package:taousapp/widgets/custom_outlined_button.dart';
import 'package:taousapp/widgets/custom_text_form_field.dart';

import 'controller/edit_profile_controller.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class EditprofileScreen extends GetWidget<EditprofileController> {
  EditprofileScreen({Key? key})
      : super(
          key: key,
        );
  // ignore: unused_field
  /*final SignUpTabContainerController signUpTabContainerController =
      Get.put(SignUpTabContainerController());*/
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                    Spacer(),
                    Center(
                      child: AppbarSubtitle(
                        text: "Profile".tr,
                        margin: EdgeInsets.only(right: 50.h),
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
        body: Form(
          //autovalidateMode: AutovalidateMode.always,
          key: _formKey,
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //SizedBox(height: 32.v),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 15.h,
                        right: 15.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 32.v),
                          GetX<EditprofileController>(
                            init: EditprofileController(),
                            builder: (value) => Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                height: 128.adaptSize,
                                width: 128.adaptSize,
                                child: Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    controller.imgUrl.value != 'null'
                                        ? ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(100.00)),
                                            child: Image.network(
                                              controller.imgUrl.value,
                                              fit: BoxFit.fill,
                                              height: 100.adaptSize,
                                              width: 100.adaptSize,
                                            ),
                                          )
                                        : CustomImageView(
                                            svgPath:
                                                ImageConstant.imgUserPrimary,
                                            height: 128.adaptSize,
                                            width: 128.adaptSize,
                                            radius: BorderRadius.circular(
                                              64.h,
                                            ),
                                            alignment: Alignment.center,
                                          ),
                                    CustomIconButton(
                                      height: 37.adaptSize,
                                      width: 37.adaptSize,
                                      margin: EdgeInsets.only(bottom: 4.v),
                                      padding: EdgeInsets.all(9.h),
                                      decoration:
                                          IconButtonStyleHelper.outlineGray,
                                      alignment: Alignment.bottomRight,
                                      child: CustomImageView(
                                        svgPath: ImageConstant.imgCamera,
                                      ),
                                      onTap: () async {
                                        await showOptions();
                                        if (controller.changePic.value ==
                                            true) {
                                          await showPicture(context);
                                          if (controller.uploading.value ==
                                              true)
                                            showLoaderDialog(
                                                context, "Uploading...");
                                        }

                                        //showPicture(context);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 27.v),
                          Builder(builder: (context) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                    left: 33.h,
                                    top: 10.v,
                                    right: 32.h,
                                  ),
                                  child: Text(
                                    'Full Name:',
                                    style: CustomTextStyles
                                        .bodyMediumAirbnbCerealAppGray600,
                                  ),
                                ),
                                CustomTextFormField(
                                  //   readonly: true,
                                  margin: EdgeInsets.only(
                                    left: 33.h,
                                    top: 20.v,
                                    right: 32.h,
                                  ),
                                  controller: controller.newNameController,
                                  autofocus: false,
                                  focusNode: controller.newNameNode,
                                  hintText: controller.hController
                                      .getName()
                                      .toString(),
                                  validator: (fullname) =>
                                      controller.validateFullName(fullname),

                                  hintStyle: CustomTextStyles
                                      .bodyMediumAirbnbCerealAppGray600,
                                  prefix: Container(
                                    margin: EdgeInsets.only(
                                      top: 1.v,
                                      right: 8.h,
                                      bottom: 10.v,
                                    ),
                                    child: CustomImageView(
                                      svgPath: ImageConstant.imgUser,
                                      color: appTheme.gray500,
                                    ),
                                  ),
                                  prefixConstraints: BoxConstraints(
                                    maxHeight: 28.v,
                                  ),
                                  contentPadding: EdgeInsets.only(right: 26.h), inputFormatters: [],
                                ),
                              ],
                            );
                          }),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  left: 33.h,
                                  top: 40.v,
                                  right: 32.h,
                                ),
                                child: Text(
                                  'Username:',
                                  style: CustomTextStyles
                                      .bodyMediumAirbnbCerealAppGray600,
                                ),
                              ),
                              CustomTextFormField1(
                                onChanged: (value) {
                                  controller
                                      .validateUsername(value.toLowerCase());
                                },
                                //   readonly: true,
                                margin: EdgeInsets.only(
                                  left: 33.h,
                                  top: 10.v,
                                  right: 32.h,
                                ),
                                autofocus: false,
                                focusNode: controller.newUsernameNode,
                                //hintText: data['UserName'].toString(),

                                controller: controller.newUsernameController,
                                validator: (username) {
                                  if (controller.usernameAvailable.value ==
                                          false &&
                                      username!.toLowerCase() !=
                                          controller.hController.username.value) {
                                    return 'Username Already Taken.';
                                  }
                                  if (username.toString() == "") {
                                    return 'Username cannot be empty';
                                  }

                                  final RegExp usernamePattern = RegExp(
                                      r'^[a-zA-Z0-9][a-zA-Z0-9_.]+[a-zA-Z0-9]$');
                                  if (!usernamePattern.hasMatch(username!)) {
                                    return 'Invalid username format';
                                  }
                                  return null; // Return null to indicate a valid username
                                },
                                //userNameController: editprofileController,
                                // validator: (username) =>
                                //     SignUpTabContainerController()
                                //         .validateUserName(username),
                                hintStyle: CustomTextStyles
                                    .bodyMediumAirbnbCerealAppGray600,
                                prefix: Container(
                                  margin: EdgeInsets.only(
                                    top: 1.v,
                                    right: 8.h,
                                    bottom: 10.v,
                                  ),
                                  child: CustomImageView(
                                    svgPath: ImageConstant.imgUser,
                                    color: appTheme.gray500,
                                  ),
                                ),
                                prefixConstraints: BoxConstraints(
                                  maxHeight: 28.v,
                                ),
                                contentPadding: EdgeInsets.only(right: 26.h),
                                userNameController: controller,
                              ),
                            ],
                          ),
                          /*
                          CustomTextFormField1(
                            //   readonly: true,
                            margin: EdgeInsets.only(
                              left: 33.h,
                              top: 44.v,
                              right: 32.h,
                            ),
                            autofocus: false,
                            focusNode: controller.newNameNode,
                            hintText: "username",

                            controller:
                                controller.newUsernameController,
                            userNameController: controller,
                            validator: (username) {
                              if (username?.isEmpty ?? true) {
                                return 'Username cannot be empty';
                              }
                              final RegExp usernamePattern = RegExp(
                                  r'^[a-zA-Z0-9][a-zA-Z0-9_.]+[a-zA-Z0-9]$');
                              if (!usernamePattern.hasMatch(username!)) {
                                return 'Invalid username format';
                              }
                              return null; // Return null to indicate a valid username
                            },
                            hintStyle: CustomTextStyles.bodyMediumGray90005,
                            prefix: Container(
                              margin: EdgeInsets.only(
                                top: 1.v,
                                right: 8.h,
                                bottom: 10.v,
                              ),
                              child: CustomImageView(
                                svgPath: ImageConstant.imgUser,
                                color: appTheme.gray500,
                              ),
                            ),
                            prefixConstraints: BoxConstraints(
                              maxHeight: 28.v,
                            ),
                            contentPadding: EdgeInsets.only(right: 26.h),
                          ),*/
                          SizedBox(height: 40.v),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 35.0, right: 35.0),
                            child: CustomElevatedButton(
                                text: "Update",
                                margin: EdgeInsets.only(
                                  left: 1.h,
                                  top: 20.v,
                                ),
                                buttonStyle: CustomButtonStyles.fillPrimary,
                                onTap: () async {
                                  if (_formKey.currentState!.validate()) {
                                    if (controller.newNameController.text
                                            .toLowerCase() !=
                                        controller.hController
                                            .getName()
                                            .toString()) {
                                      //showLoaderDialog1(context);
                                      // print(editprofileController
                                      //     .newNameController.text);
                                      // print(controller.hController
                                      //     .getName()
                                      //     .toString());
                                      controller.updateFirstName(controller
                                          .newNameController.text
                                          .toLowerCase());
                                    }
                                    if (controller.newUsernameController.text
                                            .toLowerCase() !=
                                        controller.hController
                                            .username.value
                                            .toString()) {
                                      //showLoaderDialog1(context);
                                      controller.updateUsername(controller
                                          .newUsernameController.text
                                          .toLowerCase());
                                    }
                                  }
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showOptions() async {
    controller.changePic.value = false;
    await Get.bottomSheet(
        SafeArea(
            child: Wrap(children: <Widget>[
          /*ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () async {
                List<String?> imageList =
                    await _imgFromGallery(maxFileSize, allowedExtensions);
                if (getImages != null) {
                  getImages(imageList);
                }
                Get.back();
              }),
              */
          ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text('Camera'),
              onTap: () async {
                controller.changePic.value = true;
                await controller.getImage(ImageSource.camera);
                /*
                List<String?> imageList =
                    await _imgFromCamera(maxFileSize, allowedExtensions);
                if (getImages != null) {
                  getImages(imageList);
                }
                */
                Get.back();
              }),
          ListTile(
              leading: const Icon(Icons.browse_gallery),
              title: const Text('Gallery'),
              onTap: () async {
                controller.changePic.value = true;
                await controller.getImage(ImageSource.gallery);
                /*
                List<String?> imageList =
                    await _imgFromCamera(maxFileSize, allowedExtensions);
                if (getImages != null) {
                  getImages(imageList);
                }
                */
                Get.back();
              }),
        ])),
        backgroundColor: Colors.white);
  }

  showPicture(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            insetPadding: EdgeInsets.all(20),
            content: Container(
              height: getVerticalSize(350),
              width: getHorizontalSize(400),
              child: Column(
                children: <Widget>[
                  Container(
                    height: getSize(228.00),
                    width: getSize(228.00),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(114),
                        child: controller.image != null
                            ? Image.file(
                                controller.image,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(ImageConstant.imageNotFound)),
                    decoration: AppDecoration.outlineGray300
                        .copyWith(borderRadius: BorderRadius.circular(114)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Do you want to set this as your profile picture?",
                      style: CustomTextStyles.bodySmallGray50003),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomOutlinedButton(
                          width: getSize(100),
                          text: "Yes",
                          onTap: () {
                            controller.uploading.value = true;
                            controller.uploadImage();
                            Get.back();
                          },
                          alignment: Alignment.centerLeft),
                      CustomOutlinedButton(
                          width: getSize(100),
                          text: "No",
                          onTap: () {
                            Get.back();
                          },
                          alignment: Alignment.centerLeft)
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  showLoaderDialog1(BuildContext context) {
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
                "Updating Profile...",
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

  showLoaderDialog(BuildContext context, String s) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 20), child: Text(s)),
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
    controller.uploading.value = false;
  }
}
