import '../controller/frends_controller.dart';
import '../models/userprofile_item_model.dart';
import 'package:flutter/material.dart';
import 'package:taousapp/core/app_export.dart';
import 'package:taousapp/widgets/custom_elevated_button.dart';

// ignore: must_be_immutable
class UserprofileItemWidget extends StatelessWidget {
  UserprofileItemWidget(
    this.userprofileItemModelObj, {
    Key? key,
  }) : super(
          key: key,
        );

  UserprofileItemModel userprofileItemModelObj;

  var controller = Get.put(FrendsController());

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 56.adaptSize,
          width: 56.adaptSize,
          padding: EdgeInsets.all(4.h),
          decoration: AppDecoration.outline1.copyWith(
            borderRadius: BorderRadiusStyle.circleBorder29,
          ),
          child: CustomImageView(
            imagePath: ImageConstant.imgPhoto48x48,
            height: 48.adaptSize,
            width: 48.adaptSize,
            radius: BorderRadius.circular(
              24.h,
            ),
            alignment: Alignment.center,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 10.h,
            top: 7.v,
            bottom: 7.v,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Text(
                  userprofileItemModelObj.userName!.value,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleSmall,
                ),
              ),
              SizedBox(height: 2.v),
              Obx(
                () => Text(
                  userprofileItemModelObj.userMessage!.value,
                  overflow: TextOverflow.ellipsis,
                  style: CustomTextStyles.bodyMediumGray60002,
                ),
              ),
            ],
          ),
        ),
        Spacer(),
        CustomElevatedButton(
          height: 24.v,
          width: 69.h,
          text: "lbl_unfollow".tr,
          margin: EdgeInsets.symmetric(vertical: 16.v),
          buttonTextStyle: theme.textTheme.labelLarge!,
        ),
      ],
    );
  }
}
