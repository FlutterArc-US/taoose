import '../messages_screen/widgets/usermessage_item_widget.dart';
import 'controller/messages_controller.dart';
import 'models/usermessage_item_model.dart';
import 'package:flutter/material.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';
import 'package:taousapp/core/app_export.dart';
import 'package:taousapp/widgets/app_bar/appbar_title.dart';
import 'package:taousapp/widgets/app_bar/custom_app_bar.dart';
import 'package:taousapp/widgets/custom_bottom_bar.dart';
import 'package:taousapp/widgets/custom_search_view.dart';

// ignore_for_file: must_be_immutable
class MessagesScreen extends GetWidget<MessagesController> {
  const MessagesScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        title: AppbarTitle(
          text: "lbl_messages".tr,
          margin: EdgeInsets.only(left: 15.h),
        ),
        actions: [
          Container(
            height: 38.adaptSize,
            width: 38.adaptSize,
            margin: EdgeInsets.fromLTRB(17.h, 7.v, 17.h, 10.v),
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomImageView(
                  svgPath: ImageConstant.imgClose,
                  height: 38.adaptSize,
                  width: 38.adaptSize,
                  alignment: Alignment.center,
                ),
                CustomImageView(
                  svgPath: ImageConstant.imgShare,
                  height: 19.adaptSize,
                  width: 19.adaptSize,
                  alignment: Alignment.center,
                  margin: EdgeInsets.fromLTRB(9.h, 8.v, 9.h, 10.v),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(vertical: 36.v),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 3.v),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomSearchView(
                      margin: EdgeInsets.symmetric(horizontal: 15.h),
                      controller: controller.searchController,
                      hintText: "lbl_search".tr,
                      prefix: Container(
                        margin: EdgeInsets.fromLTRB(11.h, 12.v, 4.h, 13.v),
                        child: CustomImageView(
                          svgPath: ImageConstant.imgCharmsearch,
                        ),
                      ),
                      prefixConstraints: BoxConstraints(
                        maxHeight: 48.v,
                      ),
                      suffix: Padding(
                        padding: EdgeInsets.only(
                          right: 15.h,
                        ),
                        child: IconButton(
                          onPressed: () {
                            controller.searchController.clear();
                          },
                          icon: Icon(
                            Icons.clear,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 13.h,
                        top: 16.v,
                        right: 17.h,
                      ),
                      child: Obx(
                        () => ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          separatorBuilder: (
                            context,
                            index,
                          ) {
                            return SizedBox(
                              height: 16.v,
                            );
                          },
                          itemCount: controller.messagesModelObj.value
                              .usermessageItemList.value.length,
                          itemBuilder: (context, index) {
                            UsermessageItemModel model = controller
                                .messagesModelObj
                                .value
                                .usermessageItemList
                                .value[index];
                            return UsermessageItemWidget(
                              model,
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 396.v,
                      width: double.maxFinite,
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 187.v),
                              child: SizedBox(
                                width: 284.h,
                                child: Divider(),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 107.v),
                              child: SizedBox(
                                width: 284.h,
                                child: Divider(),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 39.v),
                              child: SizedBox(
                                width: 284.h,
                                child: Divider(),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 13.h,
                                right: 17.h,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 4.h,
                                      top: 208.v,
                                      right: 20.h,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomImageView(
                                          imagePath: ImageConstant.imgProfile,
                                          height: 48.adaptSize,
                                          width: 48.adaptSize,
                                        ),
                                        Container(
                                          height: 34.v,
                                          width: 184.h,
                                          margin: EdgeInsets.only(
                                            left: 13.h,
                                            top: 4.v,
                                            bottom: 9.v,
                                          ),
                                          child: Stack(
                                            alignment: Alignment.bottomCenter,
                                            children: [
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  "lbl_penelope2".tr,
                                                  style: theme
                                                      .textTheme.titleSmall,
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Text(
                                                  "msg_you_hey_what_s".tr,
                                                  style: theme
                                                      .textTheme.bodyMedium,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: 40.h,
                                            top: 5.v,
                                            bottom: 26.v,
                                          ),
                                          child: Text(
                                            "lbl_50_min".tr,
                                            style: theme.textTheme.bodySmall,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 4.h,
                                      top: 20.v,
                                      right: 20.h,
                                    ),
                                    child: Row(
                                      children: [
                                        CustomImageView(
                                          imagePath: ImageConstant.imgProfile,
                                          height: 48.adaptSize,
                                          width: 48.adaptSize,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              left: 14.h,
                                              top: 3.v,
                                              bottom: 4.v,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      "lbl_chloe2".tr,
                                                      style: theme
                                                          .textTheme.titleSmall,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 60.h),
                                                      child: Text(
                                                        "lbl_55_min".tr,
                                                        textAlign:
                                                            TextAlign.right,
                                                        style: theme.textTheme
                                                            .bodySmall,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  "msg_you_hello_how_are".tr,
                                                  style: theme
                                                      .textTheme.bodyMedium,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 16.v,
                                      right: 20.h,
                                    ),
                                    child: Row(
                                      children: [
                                        CustomImageView(
                                          imagePath: ImageConstant.imgPhoto4,
                                          height: 48.adaptSize,
                                          width: 48.adaptSize,
                                          radius: BorderRadius.circular(
                                            24.h,
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              left: 10.h,
                                              top: 7.v,
                                              bottom: 7.v,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      "lbl_grace2".tr,
                                                      style: theme
                                                          .textTheme.titleSmall,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 60.h),
                                                      child: Text(
                                                        "lbl_1_hour".tr,
                                                        textAlign:
                                                            TextAlign.right,
                                                        style: theme.textTheme
                                                            .bodySmall,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  "msg_you_great_i_will".tr,
                                                  style: theme
                                                      .textTheme.bodyMedium,
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
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              margin: EdgeInsets.only(top: 124.v),
                              padding: EdgeInsets.symmetric(
                                horizontal: 23.h,
                                vertical: 27.v,
                              ),
                              decoration: AppDecoration
                                  .gradientPrimaryContainerToPrimaryContainer,
                              child: Container(
                                margin: EdgeInsets.only(left: 1.h),
                                decoration: AppDecoration.outline2.copyWith(
                                  borderRadius:
                                      BorderRadiusStyle.circleBorder33,
                                ),
                                child: OutlineGradientButton(
                                  padding: EdgeInsets.only(
                                    left: 2.h,
                                    top: 2.v,
                                    right: 2.h,
                                    bottom: 2.v,
                                  ),
                                  strokeWidth: 2.h,
                                  gradient: LinearGradient(
                                    begin: Alignment(0.5, 0),
                                    end: Alignment(0.5, 1),
                                    colors: [
                                      appTheme.yellowA70049,
                                      appTheme.yellowA70049,
                                    ],
                                  ),
                                  corners: Corners(
                                    topLeft: Radius.circular(31),
                                    topRight: Radius.circular(31),
                                    bottomLeft: Radius.circular(31),
                                    bottomRight: Radius.circular(31),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 35.h,
                                      vertical: 18.v,
                                    ),
                                    child: Row(
                                      children: [
                                        CustomImageView(
                                          svgPath: ImageConstant.imgHome,
                                          height: 24.adaptSize,
                                          width: 24.adaptSize,
                                          margin: EdgeInsets.only(bottom: 2.v),
                                        ),
                                        CustomImageView(
                                          svgPath: ImageConstant.imgCar,
                                          height: 24.adaptSize,
                                          width: 24.adaptSize,
                                          margin: EdgeInsets.only(
                                            left: 46.h,
                                            bottom: 2.v,
                                          ),
                                        ),
                                        Spacer(
                                          flex: 50,
                                        ),
                                        CustomImageView(
                                          svgPath: ImageConstant.imgMap,
                                          height: 24.adaptSize,
                                          width: 24.adaptSize,
                                          margin: EdgeInsets.only(bottom: 2.v),
                                        ),
                                        Spacer(
                                          flex: 50,
                                        ),
                                        CustomImageView(
                                          svgPath: ImageConstant
                                              .imgUserPrimarycontainer,
                                          height: 24.adaptSize,
                                          width: 24.adaptSize,
                                          margin: EdgeInsets.only(right: 8.h),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(top: 31.v),
                        child: Divider(
                          indent: 91.h,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomBar(
        onChanged: (BottomBarEnum type) {},
      ),
    );
  }
}
