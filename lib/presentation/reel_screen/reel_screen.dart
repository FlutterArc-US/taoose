import 'controller/reel_controller.dart';
import 'package:flutter/material.dart';
import 'package:taousapp/core/app_export.dart';
import 'package:taousapp/widgets/app_bar/appbar_image.dart';
import 'package:taousapp/widgets/app_bar/appbar_image_2.dart';
import 'package:taousapp/widgets/app_bar/custom_app_bar.dart';
import 'package:taousapp/widgets/custom_bottom_bar.dart';

// ignore_for_file: must_be_immutable
class ReelScreen extends GetWidget<ReelController> {
  const ReelScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.gray10004,
        appBar: CustomAppBar(
          leadingWidth: 32.h,
          leading: AppbarImage2(
            svgPath: ImageConstant.imgBackarrowPrimarycontainer,
            margin: EdgeInsets.only(
              left: 23.h,
              top: 20.v,
              bottom: 20.v,
            ),
          ),
          actions: [
            AppbarImage(
              svgPath: ImageConstant.imgPlusPrimarycontainer,
              margin: EdgeInsets.symmetric(
                horizontal: 18.h,
                vertical: 15.v,
              ),
            ),
          ],
        ),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(vertical: 25.v),
          child: Column(
            children: [
              Spacer(),
              Container(
                height: 228.v,
                width: 374.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      ImageConstant.imgGroup131,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                foregroundDecoration: AppDecoration.gradientBlackToBlack900,
                child: Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 212.v,
                        width: 374.h,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(0.5, 0),
                            end: Alignment(0.5, 1),
                            colors: [
                              appTheme.black900.withOpacity(0),
                              appTheme.black900,
                            ],
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 9.h),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "lbl_whatnina".tr,
                              style: CustomTextStyles
                                  .titleSmallProximaNova2PrimaryContainer,
                            ),
                            SizedBox(height: 9.v),
                            SizedBox(
                              width: 252.h,
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "msg_dont_know_how_to2".tr,
                                      style: CustomTextStyles
                                          .bodyMediumProximaNova2PrimaryContainer_1,
                                    ),
                                    TextSpan(
                                      text: "msg_hashtag_second".tr,
                                      style: CustomTextStyles
                                          .labelLargeProximaNova2PrimaryContainer,
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            SizedBox(height: 28.v),
                            SizedBox(
                              height: 19.v,
                              width: 253.h,
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  CustomImageView(
                                    svgPath:
                                        ImageConstant.imgMusicPrimarycontainer,
                                    height: 12.v,
                                    width: 11.h,
                                    alignment: Alignment.topLeft,
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      "msg_somemone_original".tr,
                                      style: CustomTextStyles
                                          .bodyMediumProximaNova2PrimaryContainer,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    CustomImageView(
                      svgPath: ImageConstant.imgBookmark,
                      height: 24.adaptSize,
                      width: 24.adaptSize,
                      alignment: Alignment.topRight,
                      margin: EdgeInsets.only(right: 48.h),
                    ),
                    CustomImageView(
                      svgPath: ImageConstant.imgCiloptions,
                      height: 24.adaptSize,
                      width: 24.adaptSize,
                      alignment: Alignment.topRight,
                      margin: EdgeInsets.only(right: 14.h),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomBar(
          onChanged: (BottomBarEnum type) {},
        ),
      ),
    );
  }
}
