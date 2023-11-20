import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shimmer/shimmer.dart';
import 'package:taousapp/presentation/notifications_screen/notifications_screen.dart';
import 'package:taousapp/widgets/custom_post.dart';
import 'package:taousapp/widgets/custom_search.dart';
import 'controller/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:taousapp/core/app_export.dart';
import 'package:taousapp/widgets/app_bar/appbar_iconbutton.dart';
import 'package:taousapp/widgets/app_bar/appbar_image_1.dart';
import 'package:taousapp/widgets/app_bar/custom_app_bar.dart';

// ignore_for_file: must_be_immutable
class PostScreen extends GetWidget<PostController> {
  const PostScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    //controller.updateFollowings();
    //controller.checkNewPosts();
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    mediaQueryData = MediaQuery.of(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: appTheme.whiteA700,
      appBar: CustomAppBar(
        title: AppbarImage1(
          svgPath: ImageConstant.imgFrameIndigo900,
          margin: EdgeInsets.only(left: 23.h),
        ),
        actions: [
          AppbarIconbutton(
            svgPath: ImageConstant.imgCharmsearch,
            /*margin: EdgeInsets.symmetric(
              horizontal: 2.h,
              vertical: 2.v,
            ),*/
            onTap: () => CustomSearch().chatModalBottomSheet(context),
          ),
          AppbarIconbutton(
            svgPath: ImageConstant.imgIconslight,
            margin: EdgeInsets.only(
              //horizontal: 11.5.h,
              right: 4.v,
            ),
            onTap: () => _scaffoldKey.currentState?.openEndDrawer(),
          ),
        ],
      ),
      endDrawer: Container(
          width: MediaQuery.of(context).size.width,
          child: Drawer(child: NotificationsScreen())),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.loading.value = true;
          await controller.getFollowings();
          await controller.getFollowingPosts();
        },
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(vertical: 0.v),
          child: Column(
            children: [
              //SizedBox(height: 11.v),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 70.v),
                      SizedBox(
                        //height: 765.v,
                        width: double.maxFinite,
                        child: Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 22.h),
                            child: Obx(() => controller.posts.length == 0
                                ? controller.loading.value == true
                                    ? Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        enabled: true,
                                        child: Column(
                                          children: [
                                            CustomImageView(
                                              //onTap: () => Get.toNamed(
                                              //    AppRoutes.prodcutDetailsOneScreen,

                                              imagePath:
                                                  ImageConstant.logoImage,
                                              alignment: Alignment.center,
                                            ),
                                          ],
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 15),
                                        child: Column(
                                          children: [
                                            CustomImageView(
                                              //onTap: () => Get.toNamed(
                                              //    AppRoutes.prodcutDetailsOneScreen,

                                              imagePath:
                                                  ImageConstant.logoImage,
                                              alignment: Alignment.center,
                                            ),
                                            Text(
                                                "Start Following People To Explore Fashion")
                                          ],
                                        ),
                                      )
                                : GetBuilder<PostController>(
                                    builder: (context) {
                                      return ListView.builder(
                                        itemCount: controller.posts.length,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        reverse: true,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              FutureBuilder<DocumentSnapshot>(
                                                  future: controller
                                                      .getUserDetails(controller
                                                              .posts[index]
                                                          ['owner']),
                                                  builder: (BuildContext
                                                          context,
                                                      AsyncSnapshot<
                                                              DocumentSnapshot>
                                                          snapshot) {
                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState.done) {
                                                      var data = snapshot.data;
                                                      return CustomPost(
                                                          data, index);
                                                    }
                                                    return Text("");
                                                  }),
                                              SizedBox(height: 15.v),
                                              /*Container(
                                  padding:
                                      EdgeInsets.symmetric(vertical: 14.v),
                                  decoration: AppDecoration
                                      .fillPrimaryContainer
                                      .copyWith(
                                    borderRadius:
                                        BorderRadiusStyle.circleBorder20,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        offset: Offset(0,
                                            2), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 16.h,
                                          right: 13.h,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CustomImageView(
                                              imagePath: ImageConstant
                                                  .imgAvatar41x41,
                                              height: 41.adaptSize,
                                              width: 41.adaptSize,
                                              radius: BorderRadius.circular(
                                                20.h,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 12.h),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "lbl_anna_smith".tr,
                                                    style: CustomTextStyles
                                                        .titleSmallSemiBold,
                                                  ),
                                                  SizedBox(height: 3.v),
                                                  Text(
                                                    "lbl_annas45".tr,
                                                    style: CustomTextStyles
                                                        .bodySmallGray50003,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Spacer(),
                                            CustomImageView(
                                              svgPath: ImageConstant
                                                  .imgMioptionshorizontal,
                                              height: 24.adaptSize,
                                              width: 24.adaptSize,
                                              margin: EdgeInsets.only(
                                                top: 5.v,
                                                bottom: 12.v,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 13.v),
                                      CustomImageView(
                                        imagePath:
                                            ImageConstant.imgImg173x330,
                                        height: 173.v,
                                        width: 330.h,
                                      ),
                                      Container(
                                        width: 296.h,
                                        margin: EdgeInsets.only(
                                          left: 16.h,
                                          top: 12.v,
                                          right: 16.h,
                                        ),
                                        child: Text(
                                          "msg_contrary_to_popular".tr,
                                          maxLines: null,
                                          overflow: TextOverflow.ellipsis,
                                          style: CustomTextStyles
                                              .bodySmallGray700,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 12.v),
                                        child: Divider(
                                          color: appTheme.gray10005,
                                          indent: 16.h,
                                          endIndent: 16.h,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 16.h,
                                          top: 15.v,
                                          right: 16.h,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CustomIconButton(
                                              height: 41.adaptSize,
                                              width: 41.adaptSize,
                                              padding: EdgeInsets.all(11.h),
                                              decoration:
                                                  IconButtonStyleHelper
                                                      .fillPrimary,
                                              child: CustomImageView(
                                                  svgPath:
                                                      ImageConstant.imgMusic,
                                                  color: theme.colorScheme
                                                      .background),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: 8.h,
                                                top: 12.v,
                                                bottom: 11.v,
                                              ),
                                              child: Text(
                                                "lbl_124".tr,
                                                style: CustomTextStyles
                                                    .bodySmallPrimary,
                                              ),
                                            ),
                                            CustomIconButton(
                                              decoration:
                                                  IconButtonStyleHelper
                                                      .fillGrayProfile,
                                              height: 41.adaptSize,
                                              width: 41.adaptSize,
                                              margin:
                                                  EdgeInsets.only(left: 25.h),
                                              padding: EdgeInsets.all(12.h),
                                              child: CustomImageView(
                                                svgPath: ImageConstant
                                                    .imgLightbulb,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: 8.h,
                                                top: 12.v,
                                                bottom: 12.v,
                                              ),
                                              child: Text(
                                                "lbl_9".tr,
                                                style: CustomTextStyles
                                                    .bodySmallNetflixSansGray50003,
                                              ),
                                            ),
                                            Spacer(),
                                            CustomIconButton(
                                              decoration:
                                                  IconButtonStyleHelper
                                                      .fillGrayProfile,
                                              height: 41.adaptSize,
                                              width: 41.adaptSize,
                                              padding: EdgeInsets.all(9.h),
                                              child: CustomImageView(
                                                svgPath:
                                                    ImageConstant.imgSharePrimary, color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),*/
                                              SizedBox(
                                                height: 20,
                                              )
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  )),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 80.v,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      /*bottomNavigationBar: CustomBottomBar(
        onChanged: (BottomBarEnum type) {print(type);},
      ),*/
    );
  }
}
