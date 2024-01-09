import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:taousapp/core/app_export.dart';
import 'package:taousapp/core/constants/color_constant.dart';
import 'package:taousapp/data/cloths.dart/cloths.dart';
import 'package:taousapp/widgets/custom_elevated_button.dart';
import 'package:taousapp/widgets/custom_text_form_field.dart';

import 'controller/prodcut_details_controller.dart';

// ignore_for_file: must_be_immutable
class ProdcutDetailsScreen extends GetWidget<ProdcutDetailsController> {
  ProdcutDetailsScreen({Key? key})
      : super(
          key: key,
        );
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: appTheme.gray10004,
          body: SizedBox(
            width: double.maxFinite,
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: AppDecoration.fillIndigo900,
                      //height: 297.v,
                      width: double.maxFinite,
                      child: Column(
                        //alignment: Alignment.bottomCenter,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 11.0, right: 11, top: 20, bottom: 20),
                            child: Container(
                              //decoration: AppDecoration.fillIndigo900,
                              //height: 200,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomImageView(
                                      onTap: () => {Get.back()},
                                      svgPath: ImageConstant
                                          .imgBackarrowPrimarycontainer,
                                      height: 16.v,
                                      width: 9.h,
                                      margin: EdgeInsets.only(
                                        left: 11.h,
                                        top: 11.v,
                                        bottom: 40.v,
                                      ),
                                    ),
                                    Spacer(
                                      flex: 52,
                                    ),
                                    CustomImageView(
                                      svgPath: ImageConstant.imgFrame,
                                      height: 26.v,
                                      width: 93.h,
                                      //margin: EdgeInsets.only(bottom: 84.v),
                                    ),
                                    Spacer(
                                      flex: 47,
                                    ),
                                    controller.hController.getPhotoUrl() !=
                                            'null'
                                        ? ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(38.00)),
                                            child: Image.network(
                                              controller.hController
                                                  .getPhotoUrl(),
                                              fit: BoxFit.fill,
                                              height: 38.adaptSize,
                                              width: 38.adaptSize,
                                            ),
                                          )
                                        : CustomImageView(
                                            svgPath:
                                                ImageConstant.imgUserPrimary,
                                            color: appTheme.gray500
                                                .withOpacity(0.4),
                                            height: 38.adaptSize,
                                            width: 38.adaptSize,
                                            radius: BorderRadius.circular(
                                              19.h,
                                            ),
                                            alignment: Alignment.center,
                                          ),
                                  ]),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 21.h, right: 21.h, bottom: 40.v),
                              padding: EdgeInsets.symmetric(
                                horizontal: 18.h,
                                vertical: 20.v,
                              ),
                              decoration: AppDecoration.outlineBlack.copyWith(
                                borderRadius: BorderRadiusStyle.roundedBorder8,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "cloths",
                                    style: theme.textTheme.titleSmall,
                                  ),
                                  SizedBox(height: 5.v),
                                  SizedBox(
                                    height: 50,
                                    child: DropdownSearch<String>(
                                      popupProps: PopupProps.modalBottomSheet(
                                        isFilterOnline: true,
                                        showSearchBox: true,
                                        searchFieldProps: TextFieldProps(
                                          controller:
                                              controller.userEditTextController,
                                          decoration: InputDecoration(
                                            suffixIcon: IconButton(
                                              icon: Icon(Icons.clear),
                                              onPressed: () {
                                                controller
                                                    .userEditTextController
                                                    .clear();
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      items: cloths,
                                      validator: (value) => value == null
                                          ? 'Please Select cloths.'
                                          : null,
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        baseStyle:
                                            CustomTextStyles.bodyMediumBlack900,
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                          border:
                                              TextFormFieldStyleHelper.fillGray,
                                          fillColor: appTheme.gray10001,
                                          filled: true,
                                          //labelText: "Menu mode",
                                          hintText: "Select cloths",
                                          //labelStyle: CustomTextStyles.bodyMediumBlack900,
                                          hintStyle: CustomTextStyles
                                              .bodyMediumBlack900,
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 9.h,
                                            vertical: 14.v,
                                          ),
                                        ),
                                      ),
                                      onChanged: (change) {
                                        controller.cloths.value =
                                            change.toString();
                                      },
                                      //selectedItem: "Brazil",
                                    ),
                                  ),
                                  SizedBox(height: 20.v),
                                  Text(
                                    "Description",
                                    style: theme.textTheme.titleSmall,
                                  ),
                                  SizedBox(height: 5.v),
                                  SizedBox(
                                    height: 50,
                                    child: DropdownButtonFormField(
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        border:
                                            TextFormFieldStyleHelper.fillGray,
                                        filled: true,
                                        fillColor: appTheme.gray10001,
                                        hintStyle:
                                            CustomTextStyles.bodyMediumBlack900,
                                        hintText: "Select Description",
                                      ),
                                      validator: (value) => value == null
                                          ? 'Please Select Description.'
                                          : null,
                                      items: <String>['one', 'two', 'three']
                                          .map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: CustomTextStyles
                                                .titleSmallBluegray40001,
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (_) {
                                        controller.description.value =
                                            _.toString().toLowerCase();
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 20.v),
                                  Text(
                                    "URL",
                                    style: theme.textTheme.titleSmall,
                                  ),
                                  SizedBox(height: 5.v),
                                  CustomTextFormField(
                                    focusNode: controller.urlNode,
                                    validator: (entry) => entry!.isEmpty
                                        ? "Please Provide URL."
                                        : controller.validateUrl(entry),
                                    autofocus: false,
                                    controller: controller.urlController,
                                    hintText: "Enter url".tr,
                                    borderDecoration:
                                        TextFormFieldStyleHelper.fillGray,
                                    fillColor: appTheme.gray10001,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 9.h,
                                      vertical: 14.v,
                                    ),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.deny(
                                          RegExp(r'\s'))
                                    ],
                                  ),
                                  SizedBox(height: 20.v),
                                  Text(
                                    "Image File",
                                    style: theme.textTheme.titleSmall,
                                  ),
                                  SizedBox(height: 5.v),
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
                                          //horizontal: 113.h,
                                          //vertical: 25.v,
                                          ),
                                      decoration:
                                          AppDecoration.outlineGray300.copyWith(
                                        borderRadius:
                                            BorderRadiusStyle.roundedBorder13,
                                      ),
                                      child: Obx(
                                        () => Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            controller.path.value != ''
                                                ? InkWell(
                                                    onTap: () async {
                                                      print(controller.image
                                                          .toString());
                                                      await showOptions();
                                                    },
                                                    child: InkWell(
                                                      onTap: () async {
                                                        print(controller.image
                                                            .toString());
                                                        await showOptions();
                                                      },
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    13.00)),
                                                        child: Image.file(
                                                          File(controller
                                                              .path.value),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : CustomImageView(
                                                    onTap: () async {
                                                      print(controller.image
                                                          .toString());
                                                      await showOptions();
                                                    },
                                                    svgPath: ImageConstant
                                                        .imgSharePrimary,
                                                    height: 39.adaptSize,
                                                    width: 39.adaptSize,
                                                  ),
                                            SizedBox(height: 1.v),
                                            controller.image != null
                                                ? Container()
                                                : Text(
                                                    "Upload Image".tr,
                                                    style: CustomTextStyles
                                                        .bodySmallOnError,
                                                  ),
                                            controller.uploading.value == true
                                                ? Text(
                                                    "Uploading Image",
                                                    style: CustomTextStyles
                                                        .bodySmallOnError,
                                                  )
                                                : Container()
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10.v),
                                  Obx(() => controller.showMessage.value == true
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Text(
                                            "Please Upload A Picture",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.red),
                                          ),
                                        )
                                      : Container()),
                                  SizedBox(height: 20.v),
                                  Align(
                                    alignment: Alignment.center,
                                    child: CustomElevatedButton(
                                      onTap: () {
                                        if (controller.path.value == '') {
                                          controller.showMessage.value = true;
                                        } else {
                                          controller.showMessage.value = false;
                                        }
                                        if (_formKey.currentState!.validate() &&
                                            controller.path.value != "") {
                                          if (controller.uploading.value ==
                                              false) {
                                            showLoaderDialog(context);
                                            controller.uploadImage();
                                          } else {
                                            Get.back();
                                          }
                                        }
                                      },
                                      height: 42.v,
                                      width: 123.h,
                                      text: "Post".tr,
                                      //margin: EdgeInsets.only(left: 21.h),
                                      buttonStyle:
                                          CustomButtonStyles.fillPrimaryTL21,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 22.v),
                      child: Divider(
                        indent: 91.h,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 70.v),
                      child: Divider(
                        indent: 91.h,
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
              "Uploading Post...",
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
