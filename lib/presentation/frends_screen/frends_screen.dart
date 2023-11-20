import 'package:taousapp/widgets/custom_friends.dart';
import 'controller/frends_controller.dart';
import 'package:flutter/material.dart';
import 'package:taousapp/core/app_export.dart';
import 'package:taousapp/widgets/custom_search_view.dart';

// ignore_for_file: must_be_immutable
class FrendsScreen extends GetWidget<FrendsController> {
  const FrendsScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    controller.getFollowFollowings();
    if (controller.following.isNotEmpty) {
      controller.getFollowing();
    }
    if (controller.followers.isNotEmpty) {
      controller.getFollowers();
    }
    mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: appTheme.whiteA700,
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.maxFinite,
        //padding: EdgeInsets.symmetric(vertical: 240.v),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                controller: controller.scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 17.h, top: 10.h),
                      child: Obx(
                        () => Text(
                          controller.hController.username.value,
                          style: theme.textTheme.headlineMedium,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Obx(
                      () => Container(
                        
                        margin: EdgeInsets.only(left: 17, right: 17, top: 10, bottom:10),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () async {
                                controller.activeWidget.value = 0;
                              },
                              child: Container(
                                //margin: EdgeInsets.all(10),
                                //width: MediaQuery.of(context).size.width * 0.5,
                                padding: const EdgeInsets.all(10),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  color: controller.activeWidget.value == 0
                                      ? appTheme.indigo900
                                      : theme.colorScheme.background,
                                  border: Border.all(
                                      color:
                                          appTheme.gray20001, // Set border color
                                      width: 0.5),
                                ),
                                child: Text(
                                  "Followers",
                                  style: controller.activeWidget.value == 0
                                      ? theme.textTheme.labelLarge
                                      : TextStyle(
                                          color: appTheme.black900,
                                          fontSize: 12.fSize,
                                          fontFamily: 'Nunito Sans',
                                          fontWeight: FontWeight.w600,
                                        ),
                                ),
                              ),
                            ),
                            SizedBox(width: 15,),
                            InkWell(
                              onTap: () async {
                                controller.activeWidget.value = 1;
                              },
                              child: Container(
                                //margin: EdgeInsets.all(10),
                                //width: MediaQuery.of(context).size.width * 0.5,
                                padding: EdgeInsets.all(10),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  color: controller.activeWidget.value == 0
                                      ? theme.colorScheme.background
                                      : appTheme.indigo900,
                                  border: Border.all(
                                      color:
                                          appTheme.gray20001, // Set border color
                                      width: 0.5), // Set border width
                                ),
                                child: Text(
                                  "Following",
                                  style: controller.activeWidget.value == 0
                                      ? TextStyle(
                                          color: appTheme.black900,
                                          fontSize: 12.fSize,
                                          fontFamily: 'Nunito Sans',
                                          fontWeight: FontWeight.w600,
                                        )
                                      : theme.textTheme.labelLarge,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    /*
                    Obx(
                      () => Row(
                        children: [
                          InkWell(
                            onTap: () async {
                              controller.activeWidget.value = 0;
                            },
                            child: Container(
                              //margin: EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width * 0.5,
                              padding: const EdgeInsets.all(10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: controller.activeWidget.value == 0
                                    ? appTheme.indigo900
                                    : theme.colorScheme.background,
                                border: Border.all(
                                    color:
                                        appTheme.gray20001, // Set border color
                                    width: 0.5),
                              ),
                              child: Text(
                                "Followers",
                                style: controller.activeWidget.value == 0
                                    ? theme.textTheme.labelLarge
                                    : TextStyle(
                                        color: appTheme.black900,
                                        fontSize: 12.fSize,
                                        fontFamily: 'Nunito Sans',
                                        fontWeight: FontWeight.w600,
                                      ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              controller.activeWidget.value = 1;
                            },
                            child: Container(
                              //margin: EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width * 0.5,
                              padding: EdgeInsets.all(10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: controller.activeWidget.value == 0
                                    ? theme.colorScheme.background
                                    : appTheme.indigo900,
                                border: Border.all(
                                    color:
                                        appTheme.gray20001, // Set border color
                                    width: 0.5), // Set border width
                              ),
                              child: Text(
                                "Following",
                                style: controller.activeWidget.value == 0
                                    ? TextStyle(
                                        color: appTheme.black900,
                                        fontSize: 12.fSize,
                                        fontFamily: 'Nunito Sans',
                                        fontWeight: FontWeight.w600,
                                      )
                                    : theme.textTheme.labelLarge,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),*/
                    Obx(
                      () => controller.activeWidget.value == 0
                          ? Align(
                              alignment: Alignment.center,
                              child: CustomSearchView(
                                onChanged: (value) async {
                                  print(value);
                                  if (value == '') {
                                    controller.searchLength.value = 0;
                                    //controller.searchFollowers(value);
                                    /*await controller.getFollowFollowings();
                              controller.getFriends();
                              controller.update();*/
                                  } else {
                                    controller.searchLength.value =
                                        value.length;
                                    controller.searchFollowers(value);
                                  }
                                  //controller.searchFollowers(value.toString().toLowerCase());
                                  /*await controller.getFollowFollowings();
                            controller.getFriends();
                            controller.update();
                            print(value);*/
                                },
                                autofocus: false,
                                margin: EdgeInsets.only(
                                  left: 15.h,
                                  top: 13.v,
                                  right: 15.h,
                                ),
                                controller: controller.searchController,
                                hintText: "lbl_search".tr,
                                alignment: Alignment.center,
                                prefix: Container(
                                  margin: EdgeInsets.fromLTRB(
                                      11.h, 12.v, 4.h, 13.v),
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
                                      //controller.getFriends();
                                      controller.update();
                                      controller.searchLength.value=0;
                                      controller.searchController.clear();
                                    },
                                    icon: Icon(
                                      Icons.clear,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                    ),
                    SizedBox(height: 10.v),
                    Obx(
                      () => controller.activeWidget.value == 0
                          ? controller.searchLength.value == 0
                              ? GetX<FrendsController>(builder: (context) {
                                  controller.update();
                                  if (controller.followersList.isNotEmpty) {
                                    return ListView.builder(
                                      itemCount:
                                          controller.followersList.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          child: CustomFriends(controller
                                              .followersList[index]
                                              .data() as dynamic),
                                          onTap: () => Get.toNamed(
                                              AppRoutes.profileScreenUser,
                                              arguments: controller
                                                  .followersList[index]
                                                  .data()),
                                        );
                                      },
                                    );
                                  } else {
                                    print("Empty");
                                    return Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, top: 50.0, right: 10.0),
                                        child: Container(
                                          child: Text(
                                              "You Currently Don't Have Any Followers."),
                                        ),
                                      ),
                                    );
                                  }
                                })
                              : GetX<FrendsController>(builder: (context) {
                                  controller.update();
                                  if (controller
                                      .followersQueryFinal.isNotEmpty) {
                                    print('sssssssssssssssssssssssssss');
                                    return ListView.builder(
                                      itemCount:
                                          controller.followersQueryFinal.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        print(controller
                                            .followersQueryFinal.length);
                                        return InkWell(
                                          //child: Container(width: 50, height: 50, color: Colors.red,)
                                          child: CustomFriends(controller
                                                  .followersQueryFinal[index]
                                              as dynamic),
                                          onTap: () => Get.toNamed(
                                              AppRoutes.profileScreenUser,
                                              arguments: controller
                                                  .followersQueryFinal[index]),
                                        );
                                      },
                                    );
                                  } else {
                                    print("Empty");
                                    return Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, top: 50.0, right: 10.0),
                                        child: Container(
                                          child: Text("No results."),
                                        ),
                                      ),
                                    );
                                  }
                                })
                          : GetX<FrendsController>(builder: (context) {
                              controller.update();
                              if (controller.followingList.isNotEmpty) {
                                return ListView.builder(
                                  itemCount: controller.followingList.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      child: CustomFriends(
                                          controller.followingList[index].data()
                                              as dynamic),
                                      onTap: () => Get.toNamed(
                                          AppRoutes.profileScreenUser,
                                          arguments: controller
                                              .followingList[index]
                                              .data()),
                                    );
                                  },
                                );
                              } else {
                                print("Empty");
                                return Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, top: 50.0, right: 10.0),
                                    child: Container(
                                      child: Text(
                                          "You Currently Don't Follow Anyone."),
                                    ),
                                  ),
                                );
                              }
                            }),
                    ),
                    /*
                    controller.isLoading.value == true
                        ? Center(
                            child: LoadingAnimationWidget.fourRotatingDots(
                              color: theme.colorScheme.primary,
                              size: 30,
                            ),
                          )
                        : controller.friends.length == 0
                            ? Center(
                                child: Text("nothing"),
                              )
                            : GetBuilder<FrendsController>(builder: (context) {
                                return ListView.builder(
                                  itemCount: controller.friends.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      child: CustomFriends(
                                          controller.friends[index].data()
                                              as dynamic),
                                      onTap: () => Get.toNamed(
                                          AppRoutes.profileScreenUser,
                                          arguments:
                                              controller.friends[index].data()),
                                    );
                                  },
                                );
                              }),*/
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
    );
  }
}
