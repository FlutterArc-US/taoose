import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taousapp/core/app_export.dart';
import 'package:taousapp/presentation/chat_screen/conversation_view.dart';
import 'package:taousapp/presentation/settings_screen/settings_screen.dart';
import 'package:taousapp/widgets/app_bar/appbar_image_1.dart';
import 'package:taousapp/widgets/custom_elevated_button.dart';
import 'package:taousapp/widgets/custom_icon_button.dart';
import 'package:taousapp/widgets/custom_outlined_button.dart';

import 'controller/profile_controller_user.dart';

// ignore_for_file: must_be_immutable

class ProfileScreenUser extends StatefulWidget {
  const ProfileScreenUser({super.key});

  @override
  State<ProfileScreenUser> createState() => _ProfileScreenUserState();
}

class _ProfileScreenUserState extends State<ProfileScreenUser> {
  ProfileControllerUser controller = ProfileControllerUser();
  var data = Get.arguments;
  _onPressed(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          //title: Text('Exit!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Cancel Follow Request?',
                style: CustomTextStyles.titleSmallSemiBold,
              ),
              Container(
                margin: const EdgeInsets.only(top: 15),
                //width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomOutlinedButton(
                        decoration: const BoxDecoration(color: Colors.red),
                        width: 70,
                        text: 'Yes',
                        buttonTextStyle: CustomTextStyles.titleSmallSemiBold,
                        onTap: () {
                          controller.cancelFollow(data);
                          Navigator.of(context).pop(false);
                          //SystemNavigator.pop(); //Will exit the App
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomOutlinedButton(
                        width: 70,
                        text: 'No',
                        buttonTextStyle: CustomTextStyles.titleSmallSemiBold,
                        onTap: () {
                          Navigator.of(context)
                              .pop(false); //Will not exit the App
                        },
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  _onPressed1(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          //title: Text('Exit!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Unfollow User?',
                style: CustomTextStyles.titleSmallSemiBold,
              ),
              Container(
                margin: const EdgeInsets.only(top: 15),
                //width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomOutlinedButton(
                        decoration: const BoxDecoration(color: Colors.red),
                        width: 70,
                        text: 'Yes',
                        buttonTextStyle: CustomTextStyles.titleSmallSemiBold,
                        onTap: () {
                          controller.unfollowUser(data);
                          Navigator.of(context).pop(false);
                          //SystemNavigator.pop(); //Will exit the App
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomOutlinedButton(
                        width: 70,
                        text: 'No',
                        buttonTextStyle: CustomTextStyles.titleSmallSemiBold,
                        onTap: () {
                          Navigator.of(context)
                              .pop(false); //Will not exit the App
                        },
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    scheduleMicrotask(() {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    });
  }

  @override
  Widget build(BuildContext context) {
    controller.setData(data).then((value) => controller.checkFollowing(data));
    mediaQueryData = MediaQuery.of(context);
    // ignore: no_leading_underscores_for_local_identifiers
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
      endDrawer: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Drawer(child: SettingsScreen())),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SizedBox(
          width: mediaQueryData.size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, top: 15),
                        child: SizedBox(
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
                      ),
                    ],
                  ),
                ),
                data!.toString().contains('profileUrl')
                    ? Padding(
                        padding: const EdgeInsets.only(left: 7.0),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(128.00)),
                          child: Image.network(
                            data['profileUrl'].toString(),
                            fit: BoxFit.cover,
                            height: 128.adaptSize,
                            width: 128.adaptSize,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  color: theme.colorScheme.primary,
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                          ),
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
                //SizedBox(height: 11.v),
                SizedBox(height: 11.v),
                Text(
                  data['fullName'].toString(),
                  style: CustomTextStyles.titleLargeOnPrimary21,
                ),

                Text(
                  "@${data["UserName"]}",
                  style: CustomTextStyles.titleSmallBluegray40001,
                ),
                SizedBox(height: 15.v),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 1.v),
                      child: Column(
                        children: [
                          Text(
                            data?['following'].length.toString() ??
                                0.toString(),
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
                            data['followers'].length.toString(),
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
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      controller.following.value == false
                          ? controller.private.value == true
                              ? CustomOutlinedButton(
                                  height: 40.v,
                                  width: 180.h,
                                  margin: EdgeInsets.only(
                                    //left: 21.h,
                                    top: 16.v,
                                    bottom: 16.v,
                                  ),
                                  text: controller.requested.value == false
                                      ? "Follow".tr
                                      : "Request Sent",
                                  onTap: () {
                                    if (controller.requested.value == false) {
                                      controller.follow(data);
                                    } else {
                                      _onPressed(context);
                                    }

                                    //controller.following.value = true;
                                  },
                                )
                              : CustomOutlinedButton(
                                  height: 40.v,
                                  width: 180.h,
                                  margin: EdgeInsets.only(
                                    //left: 21.h,
                                    top: 16.v,
                                    bottom: 16.v,
                                  ),
                                  text: "Follow",
                                  onTap: () async {
                                    await controller.follow(data);
                                    controller.following.value = true;
                                    controller.locked.value = false;
                                    controller.private.value = false;

                                    //controller.following.value = true;
                                  },
                                )
                          : CustomElevatedButton(
                              onTap: () {
                                _onPressed1(context);
                              },
                              //decoration: BoxDecoration(color: Colors.red),
                              height: 40.v,
                              width: 180.h,
                              text: "Following".tr,
                              margin: EdgeInsets.only(
                                //left: 21.h,
                                top: 16.v,
                                bottom: 16.v,
                              ),
                              buttonStyle:
                                  // ignore: deprecated_member_use
                                  ElevatedButton.styleFrom(
                                      // ignore: deprecated_member_use
                                      primary: appTheme.indigo900),
                              buttonTextStyle: theme.textTheme.labelLarge!,
                            ),
                      controller.following.value == true
                          ? CustomIconButton(
                              onTap: () {
                                showModalBottomSheet(
                                    isDismissible: true,
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.white,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(35.0),
                                        topRight: Radius.circular(35.0),
                                      ),
                                    ),
                                    builder: (context) {
                                      return ConversationView(
                                          username: data['UserName'].toString(),
                                          peeruid: data['uid'].toString(),
                                          fullname:
                                              data['fullName'].toString());
                                    });
                                // BottomChatWidget().chatModalBottomSheet(
                                //   context,
                                //   data['fullName'].toString(),
                                //   data['UserName'].toString(),
                                //   data['uid'].toString(),
                                // );
                              },
                              height: 50.v,
                              width: 50.h,
                              padding: EdgeInsets.all(8.h),
                              decoration:
                                  IconButtonStyleHelper.fillGrayUserProfile,
                              child: CustomImageView(
                                svgPath: ImageConstant.imgShare,
                                color: appTheme.indigo900,
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
                Obx(
                  () => controller.locked.value == false &&
                          controller.following.value == true
                      ? Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: 23.h,
                                top: 29.v,
                                right: 23.h,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "One".tr,
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
                              () => controller.posts.length == 0
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 15),
                                      child: Container(
                                          child: CarouselSlider.builder(
                                        itemCount: 1,
                                        options: CarouselOptions(
                                          enableInfiniteScroll: false,
                                          viewportFraction: 0.5,
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
                                                imagePath:
                                                    ImageConstant.logoImage,
                                                alignment: Alignment.center,
                                              ),
                                              Text(
                                                "One Collection Is Empty",
                                                style: CustomTextStyles
                                                    .bodyMediumBlack900,
                                              )
                                            ],
                                          );
                                        },
                                      )),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 15),
                                      child: GetBuilder<ProfileControllerUser>(
                                          builder: (context) {
                                        return Container(
                                            child: CarouselSlider.builder(
                                          itemCount: controller.posts.length,
                                          options: CarouselOptions(
                                            enableInfiniteScroll: false,
                                            viewportFraction: 0.6,
                                            aspectRatio: 1.5,
                                            enlargeCenterPage: true,
                                          ),
                                          itemBuilder:
                                              (context, index, realIdx) {
                                            //print(controller.posts[index]['brand']);
                                            return Container(
                                              child: InkWell(
                                                onTap: () => Get.toNamed(
                                                    AppRoutes
                                                        .prodcutDetailsOneScreen,
                                                    arguments: [
                                                      "One",
                                                      controller.posts[index]
                                                    ]),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              20.00)),
                                                  child: Image.network(
                                                    controller.posts[index]
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
                            /*
                  SizedBox(
                    height: 227.v,
                    width: 280.h,
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            height: 135.v,
                            width: 108.h,
                            decoration: BoxDecoration(
                              color: appTheme.gray100,
                              borderRadius: BorderRadius.circular(
                                9.h,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            height: 174.v,
                            width: 135.h,
                            margin: EdgeInsets.only(left: 19.h),
                            decoration: BoxDecoration(
                              color: appTheme.blueGray10001,
                              borderRadius: BorderRadius.circular(
                                9.h,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            height: 135.v,
                            width: 108.h,
                            decoration: BoxDecoration(
                              color: appTheme.gray100,
                              borderRadius: BorderRadius.circular(
                                9.h,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            height: 174.v,
                            width: 135.h,
                            margin: EdgeInsets.only(right: 19.h),
                            decoration: BoxDecoration(
                              color: appTheme.blueGray10001,
                              borderRadius: BorderRadius.circular(
                                9.h,
                              ),
                            ),
                          ),
                        ),
                        CustomImageView(
                          imagePath: ImageConstant.imgMaskgroup,
                          height: 228.v,
                          width: 180.h,
                          alignment: Alignment.center,
                        ),
                      ],
                    ),
                  ),
                  */
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 15),
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
                                                imagePath:
                                                    ImageConstant.logoImage,
                                                alignment: Alignment.center,
                                              ),
                                              Text(
                                                "Two Collection Is Empty",
                                                style: CustomTextStyles
                                                    .bodyMediumBlack900,
                                              )
                                            ],
                                          );
                                        },
                                      )),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 15),
                                      child: GetBuilder<ProfileControllerUser>(
                                          builder: (context) {
                                        return Container(
                                            child: CarouselSlider.builder(
                                          itemCount:
                                              controller.bottomPosts.length,
                                          options: CarouselOptions(
                                            enableInfiniteScroll: false,
                                            viewportFraction: 0.5,
                                            aspectRatio: 1.5,
                                            enlargeCenterPage: true,
                                          ),
                                          itemBuilder:
                                              (context, index, realIdx) {
                                            //print(controller.posts[index]['brand']);
                                            return Container(
                                              child: InkWell(
                                                onTap: () => Get.toNamed(
                                                    AppRoutes
                                                        .prodcutDetailsOneScreen,
                                                    arguments: [
                                                      "Two",
                                                      controller
                                                          .bottomPosts[index]
                                                    ]),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              20.00)),
                                                  child: Image.network(
                                                    controller
                                                            .bottomPosts[index]
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 15),
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
                                                imagePath:
                                                    ImageConstant.logoImage,
                                                alignment: Alignment.center,
                                              ),
                                              Text(
                                                "Three Collection Is Empty",
                                                style: CustomTextStyles
                                                    .bodyMediumBlack900,
                                              )
                                            ],
                                          );
                                        },
                                      )),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 15),
                                      child: GetBuilder<ProfileControllerUser>(
                                          builder: (context) {
                                        return Container(
                                            child: CarouselSlider.builder(
                                          itemCount:
                                              controller.shoePosts.length,
                                          options: CarouselOptions(
                                            enableInfiniteScroll: false,
                                            viewportFraction: 0.5,
                                            aspectRatio: 1.5,
                                            enlargeCenterPage: true,
                                          ),
                                          itemBuilder:
                                              (context, index, realIdx) {
                                            //print(controller.posts[index]['brand']);
                                            return Container(
                                              child: InkWell(
                                                onTap: () => Get.toNamed(
                                                    AppRoutes
                                                        .prodcutDetailsOneScreen,
                                                    arguments: [
                                                      "Three",
                                                      controller
                                                          .shoePosts[index]
                                                    ]),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              20.00)),
                                                  child: Image.network(
                                                    controller.shoePosts[index]
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
                            SizedBox(height: 90.v),
                          ],
                        )
                      : Center(
                          child: Padding(
                          padding: const EdgeInsets.only(
                              top: 80.0, right: 10, left: 10),
                          child: Column(
                            children: [
                              // ignore: avoid_unnecessary_containers
                              Container(
                                child: const Icon(Icons.lock, size: 50),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                  "This Account Is Private. Follow To View Content.")
                            ],
                          ),
                        )),
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
