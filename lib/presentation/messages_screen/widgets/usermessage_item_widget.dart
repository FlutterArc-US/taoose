import '../controller/messages_controller.dart';
import '../models/usermessage_item_model.dart';
import 'package:flutter/material.dart';
import 'package:taousapp/core/app_export.dart';

// ignore: must_be_immutable
class UsermessageItemWidget extends StatelessWidget {
  UsermessageItemWidget(
    this.usermessageItemModelObj, {
    Key? key,
  }) : super(
          key: key,
        );

  UsermessageItemModel usermessageItemModelObj;

  var controller = Get.find<MessagesController>();

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
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              left: 10.h,
              top: 6.v,
              bottom: 6.v,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(
                      () => Text(
                        usermessageItemModelObj.userName!.value,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleSmall,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 2.v),
                      child: Obx(
                        () => Text(
                          usermessageItemModelObj.messageTime!.value,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 4.v),
                      child: Obx(
                        () => Text(
                          usermessageItemModelObj.messageText!.value,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 2.v),
                      padding: EdgeInsets.symmetric(
                        horizontal: 7.h,
                        vertical: 2.v,
                      ),
                      decoration: AppDecoration.fillPrimary.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder8,
                      ),
                      child: Obx(
                        () => Text(
                          usermessageItemModelObj.messageIndicato!.value,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.labelMedium,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
