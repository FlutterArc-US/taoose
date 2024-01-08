import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:taousapp/core/app_export.dart';
import 'package:taousapp/presentation/settings_screen/settings_screen.dart';
import 'package:taousapp/widgets/custom_outlined_button.dart';

import 'controller/profile_controller.dart';

// ignore_for_file: must_be_immutable
class ProfileScreen extends GetWidget<ProfileController> {
  const ProfileScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    //controller.checkNewPosts();
    mediaQueryData = MediaQuery.of(context);
    final _pScaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _pScaffoldKey,
      backgroundColor: appTheme.whiteA700,
      /*appBar: CustomAppBar(
        actions: [
          AppbarImage(
            svgPath: ImageConstant.imgPlus,
            margin: EdgeInsets.only(
              left: 22.h,
              top: 15.v,
              right: 15.h,
            ),
          ),
          AppbarImage(
            svgPath: ImageConstant.imgMenu,
            margin: EdgeInsets.fromLTRB(19.h, 19.v, 37.h, 5.v),
          ),
        ],
      ),*/
      endDrawer: Container(
          width: MediaQuery.of(context).size.width,
          child: Drawer(child: SettingsScreen())),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.checkNewPosts();
        },
        child: SizedBox(
          width: mediaQueryData.size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      //Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: CustomImageView(
                          onTap: () =>
                              Get.toNamed(AppRoutes.prodcutDetailsScreen),
                          svgPath: ImageConstant.imgPlus,
                          height: 23.adaptSize,
                          width: 23.adaptSize,
                          alignment: Alignment.center,
                          margin: EdgeInsets.fromLTRB(9.h, 8.v, 9.h, 10.v),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: CustomImageView(
                          onTap: () =>
                              _pScaffoldKey.currentState?.openEndDrawer(),
                          svgPath: ImageConstant.imgMenu,
                          height: 23.adaptSize,
                          width: 23.adaptSize,
                          alignment: Alignment.center,
                          margin: EdgeInsets.fromLTRB(9.h, 8.v, 9.h, 10.v),
                        ),
                      ),
                    ],
                  ),
                ),
                controller.hController.getPhotoUrl() != 'null'
                    ? ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(100.00)),
                        child: Image.network(
                          controller.hController.getPhotoUrl(),
                          fit: BoxFit.cover,
                          height: 100.adaptSize,
                          width: 100.adaptSize,
                        ),
                      )
                    : CustomImageView(
                        svgPath: ImageConstant.imgUserPrimary,
                        color: appTheme.gray500.withOpacity(0.4),
                        height: 128.adaptSize,
                        width: 128.adaptSize,
                        radius: BorderRadius.circular(
                          64.h,
                        ),
                        alignment: Alignment.center,
                      ),
                SizedBox(height: 11.v),
                Text(
                  controller.hController.getName().capitalizeFirst.toString(),
                  style: CustomTextStyles.titleLargeOnPrimary21,
                ),
                Text(
                  "@${controller.hController.username.value}",
                  style: CustomTextStyles.titleSmallBluegray40001,
                ),
                /*
                //SizedBox(height: 11.v),
                FutureBuilder<DocumentSnapshot>(
                  future: controller.hController.getUserName(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      print("error");
                    }
      
                    if (snapshot.hasData && !snapshot.data!.exists) {
                      print("error");
                    }
      
                    if (snapshot.connectionState == ConnectionState.done) {
                      var data = snapshot.data;
                      controller.followers.value = data?['followers'].length;
                      controller.following.value = data?['following'].length;
                      print(data?['followers'].length);
                      return Text(
                        "@" + data!["UserName"].toString(),
                        style: CustomTextStyles.titleSmallBluegray40001,
                      );
                    }
      
                    return Text("");
                  },
                ),
                */
                SizedBox(height: 15.v),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 1.v),
                      child: Column(
                        children: [
                          Text(
                            controller.fController.following.length.toString(),
                            style: CustomTextStyles
                                .titleMediumAirbnbCerealAppOnPrimary,
                          ),
                          SizedBox(height: 6.v),
                          Text(
                            "lbl_following".tr,
                            style: CustomTextStyles
                                .bodyMediumAirbnbCerealAppGray600,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 23.h),
                      child: SizedBox(
                        height: 47.v,
                        child: VerticalDivider(
                          width: 1.h,
                          thickness: 1.v,
                          color: appTheme.gray300,
                          indent: 8.h,
                          endIndent: 7.h,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 24.h,
                        bottom: 2.v,
                      ),
                      child: Column(
                        children: [
                          Text(
                            controller.fController.followers.length.toString(),
                            style: CustomTextStyles
                                .titleMediumAirbnbCerealAppOnPrimary,
                          ),
                          SizedBox(height: 5.v),
                          Text(
                            "lbl_followers".tr,
                            style: CustomTextStyles
                                .bodyMediumAirbnbCerealAppGray600,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15.v),
                CustomOutlinedButton(
                  width: 253.h,
                  text: "lbl_edit_profile".tr,
                  onTap: () => Get.toNamed(AppRoutes.editProfileScreen),
                ),
                SizedBox(height: 16.v),
                Obx(
                  () => controller.posts.length == 0
                      ? Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Container(
                              child: CarouselSlider.builder(
                            itemCount: 1,
                            options: CarouselOptions(
                              enableInfiniteScroll: false,
                              viewportFraction: 0.6,
                              aspectRatio: 1.5,
                              enlargeCenterPage: true,
                            ),
                            itemBuilder: (context, index, realIdx) {
                              return Column(
                                children: [
                                  CustomImageView(
                                    //onTap: () => Get.toNamed(
                                    //    AppRoutes.prodcutDetailsOneScreen,
                                    //    arguments: "Top Wears"),
                                    imagePath: ImageConstant.logoImage,
                                    alignment: Alignment.center,
                                  ),
                                  Text(
                                    "Your One Collection Is Empty",
                                    style: CustomTextStyles.bodyMediumBlack900,
                                  )
                                ],
                              );
                            },
                          )),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child:
                              GetBuilder<ProfileController>(builder: (context) {
                            return Container(
                                child: CarouselSlider.builder(
                              itemCount: controller.posts.length,
                              options: CarouselOptions(
                                enableInfiniteScroll: false,
                                viewportFraction: 0.5,
                                aspectRatio: 1.5,
                                enlargeCenterPage: true,
                              ),
                              itemBuilder: (context, index, realIdx) {
                                //print(controller.posts[index]['brand']);
                                return Container(
                                  child: InkWell(
                                    onTap: () => Get.toNamed(
                                        AppRoutes.prodcutDetailsOneScreen,
                                        arguments: [
                                          "One",
                                          controller.posts[index]
                                        ]),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.00)),
                                      child: Image.network(
                                        controller.posts[index]['photoUrl'],
                                        fit: BoxFit.cover,
                                        //height: 100.adaptSize,
                                        //width: 100.adaptSize,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ));
                          }),
                        ),
                ),
                SizedBox(height: 16.v),
                Opacity(
                  opacity: 0.1,
                  child: Divider(
                    color: appTheme.black900.withOpacity(0.39),
                  ),
                ),
                SizedBox(height: 16.v),
                Padding(
                  padding: EdgeInsets.only(
                    left: 23.h,
                    right: 23.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Two".tr,
                        style: theme.textTheme.titleLarge,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 3.v,
                          bottom: 6.v,
                        ),
                        child: Text(
                          "lbl_show_all".tr,
                          style: CustomTextStyles.bodyMediumGray500,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.v),
                Obx(
                  () => controller.bottomPosts.length == 0
                      ? Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Container(
                              child: CarouselSlider.builder(
                            itemCount: 1,
                            options: CarouselOptions(
                              enableInfiniteScroll: false,
                              viewportFraction: 0.6,
                              aspectRatio: 1.5,
                              enlargeCenterPage: true,
                            ),
                            itemBuilder: (context, index, realIdx) {
                              return Column(
                                children: [
                                  CustomImageView(
                                    //onTap: () => Get.toNamed(
                                    //    AppRoutes.prodcutDetailsOneScreen,
                                    //    arguments: "Top Wears"),
                                    imagePath: ImageConstant.logoImage,
                                    alignment: Alignment.center,
                                  ),
                                  Text(
                                    "Your Two Collection Is Empty",
                                    style: CustomTextStyles.bodyMediumBlack900,
                                  )
                                ],
                              );
                            },
                          )),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child:
                              GetBuilder<ProfileController>(builder: (context) {
                            return Container(
                                child: CarouselSlider.builder(
                              itemCount: controller.bottomPosts.length,
                              options: CarouselOptions(
                                enableInfiniteScroll: false,
                                viewportFraction: 0.5,
                                aspectRatio: 1.5,
                                enlargeCenterPage: true,
                              ),
                              itemBuilder: (context, index, realIdx) {
                                //print(controller.posts[index]['brand']);
                                return Container(
                                  child: InkWell(
                                    onTap: () => Get.toNamed(
                                        AppRoutes.prodcutDetailsOneScreen,
                                        arguments: [
                                          "Two",
                                          controller.bottomPosts[index]
                                        ]),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.00)),
                                      child: Image.network(
                                        controller.bottomPosts[index]
                                            ['photoUrl'],
                                        fit: BoxFit.cover,
                                        //height: 100.adaptSize,
                                        //width: 100.adaptSize,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ));
                          }),
                        ),
                ),
                SizedBox(height: 16.v),
                Opacity(
                  opacity: 0.1,
                  child: Divider(
                    color: appTheme.black900.withOpacity(0.39),
                  ),
                ),
                SizedBox(height: 16.v),
                Padding(
                  padding: EdgeInsets.only(
                    left: 23.h,
                    right: 23.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Three".tr,
                        style: theme.textTheme.titleLarge,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 3.v,
                          bottom: 6.v,
                        ),
                        child: Text(
                          "lbl_show_all".tr,
                          style: CustomTextStyles.bodyMediumGray500,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.v),
                Obx(
                  () => controller.shoePosts.length == 0
                      ? Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Container(
                              child: CarouselSlider.builder(
                            itemCount: 1,
                            options: CarouselOptions(
                              enableInfiniteScroll: false,
                              viewportFraction: 0.6,
                              aspectRatio: 1.5,
                              enlargeCenterPage: true,
                            ),
                            itemBuilder: (context, index, realIdx) {
                              return Column(
                                children: [
                                  CustomImageView(
                                    //onTap: () => Get.toNamed(
                                    //    AppRoutes.prodcutDetailsOneScreen,
                                    //    arguments: "Top Wears"),
                                    imagePath: ImageConstant.logoImage,
                                    alignment: Alignment.center,
                                  ),
                                  Text(
                                    "Your Three Collection Is Empty",
                                    style: CustomTextStyles.bodyMediumBlack900,
                                  )
                                ],
                              );
                            },
                          )),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child:
                              GetBuilder<ProfileController>(builder: (context) {
                            return Container(
                                child: CarouselSlider.builder(
                              itemCount: controller.shoePosts.length,
                              options: CarouselOptions(
                                enableInfiniteScroll: false,
                                viewportFraction: 0.5,
                                aspectRatio: 1.5,
                                enlargeCenterPage: true,
                              ),
                              itemBuilder: (context, index, realIdx) {
                                //print(controller.posts[index]['brand']);
                                return Container(
                                  child: InkWell(
                                    onTap: () => Get.toNamed(
                                        AppRoutes.prodcutDetailsOneScreen,
                                        arguments: [
                                          "Three",
                                          controller.shoePosts[index]
                                        ]),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.00)),
                                      child: Image.network(
                                        controller.shoePosts[index]['photoUrl'],
                                        fit: BoxFit.cover,
                                        //height: 100.adaptSize,
                                        //width: 100.adaptSize,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ));
                          }),
                        ),
                ),
                SizedBox(height: 90.v),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
