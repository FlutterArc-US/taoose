import '../controller/prodcut_details_controller.dart';
import '../models/userprofile2_item_model.dart';
import 'package:flutter/material.dart';
import 'package:taousapp/core/app_export.dart';

// ignore: must_be_immutable
class Userprofile2ItemWidget extends StatelessWidget {
  Userprofile2ItemWidget(
    this.userprofile2ItemModelObj, {
    Key? key,
  }) : super(
          key: key,
        );

  Userprofile2ItemModel userprofile2ItemModelObj;

  var controller = Get.find<ProdcutDetailsController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 9.h,
        vertical: 8.v,
      ),
      decoration: AppDecoration.outlineBlack.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgPhoto5,
            height: 48.adaptSize,
            width: 48.adaptSize,
            radius: BorderRadius.circular(
              24.h,
            ),
            margin: EdgeInsets.only(top: 1.v),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 14.h,
              top: 14.v,
              bottom: 13.v,
            ),
            child: Text(
              "msg_lorem_ipsum_dollar".tr,
              style: theme.textTheme.titleSmall,
            ),
          ),
          CustomImageView(
            svgPath: ImageConstant.imgGgchecko,
            height: 21.adaptSize,
            width: 21.adaptSize,
            margin: EdgeInsets.only(
              left: 9.h,
              top: 14.v,
              bottom: 14.v,
            ),
          ),
          CustomImageView(
            svgPath: ImageConstant.imgRadixiconscrosscircled,
            height: 21.adaptSize,
            width: 21.adaptSize,
            margin: EdgeInsets.only(
              left: 5.h,
              top: 14.v,
              bottom: 14.v,
            ),
          ),
          CustomImageView(
            svgPath: ImageConstant.imgMioptionshorizontal,
            height: 24.adaptSize,
            width: 24.adaptSize,
            margin: EdgeInsets.only(
              left: 43.h,
              top: 13.v,
              bottom: 12.v,
            ),
          ),
        ],
      ),
    );
  }
}
