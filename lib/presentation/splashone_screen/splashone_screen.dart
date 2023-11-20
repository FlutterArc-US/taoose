import 'controller/splashone_controller.dart';
import 'package:flutter/material.dart';
import 'package:taousapp/core/app_export.dart';

// ignore_for_file: must_be_immutable
class SplashoneScreen extends GetWidget<SplashoneController> {
  const SplashoneScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: mediaQueryData.size.height,
          width: double.maxFinite,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 9.h,
                    vertical: 29.v,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(left: 1.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 114.adaptSize,
                                    width: 114.adaptSize,
                                    decoration: BoxDecoration(
                                      color: appTheme.yellow90001,
                                      borderRadius: BorderRadius.circular(
                                        57.h,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 53.v),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      height: 169.adaptSize,
                                      width: 169.adaptSize,
                                      decoration: BoxDecoration(
                                        color: appTheme.greenA700,
                                        borderRadius: BorderRadius.circular(
                                          84.h,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 147.adaptSize,
                                width: 147.adaptSize,
                                margin: EdgeInsets.only(
                                  left: 1.h,
                                  top: 41.v,
                                  bottom: 148.v,
                                ),
                                decoration: BoxDecoration(
                                  color: appTheme.cyanA200,
                                  borderRadius: BorderRadius.circular(
                                    73.h,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 37.h,
                          right: 20.h,
                          bottom: 19.v,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 114.adaptSize,
                              width: 114.adaptSize,
                              margin: EdgeInsets.only(bottom: 144.v),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary,
                                borderRadius: BorderRadius.circular(
                                  57.h,
                                ),
                              ),
                            ),
                            Container(
                              height: 169.adaptSize,
                              width: 169.adaptSize,
                              margin: EdgeInsets.only(
                                left: 17.h,
                                top: 89.v,
                              ),
                              decoration: BoxDecoration(
                                color: appTheme.indigoA700,
                                borderRadius: BorderRadius.circular(
                                  84.h,
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
              /*
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: mediaQueryData.size.height,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer.withOpacity(0.6),
                  ),
                ),
              ),
              */
              /*CustomImageView(
                imagePath: ImageConstant.imgImage45,
                height: 812.v,
                width: 375.h,
                alignment: Alignment.center,
              ),
              CustomImageView(
                imagePath: ImageConstant.imgImage90,
                height: 812.v,
                width: 375.h,
                alignment: Alignment.center,
              ),*/
              Align(
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 82.h,
                    vertical: 376.v,
                  ),
                  //decoration: AppDecoration.fillSplash,
                  child: CustomImageView(
                    svgPath: ImageConstant.imgFrameIndigo900,
                    height: 60.v,
                    width: 210.h,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
