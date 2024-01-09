import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taousapp/core/app_export.dart';
import 'package:taousapp/main.dart';
import 'package:taousapp/widgets/app_bar/appbar_image_1.dart';
import 'package:taousapp/widgets/app_bar/appbar_subtitle.dart';
import 'package:taousapp/widgets/app_bar/custom_app_bar.dart';

import '../notifications_screen/widgets/sectionlisttype_item_widget.dart';
import 'controller/notifications_controller.dart';

// ignore_for_file: must_be_immutable
class NotificationsScreen extends GetWidget<NotificationsController> {
  NotificationsScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    controller.getFollowRequests();
    if (controller.requests.isNotEmpty) controller.getRequests();
    return ValueListenableBuilder(
        valueListenable: newNotificationNotifier,
        builder: (context, value, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: CustomAppBar(
              centerTitle: true,
              title: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 22.h,
                      left: 22.h,
                      //right: 22.h,
                    ),
                    child: Row(
                      children: [
                        SizedBox(
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
                        Center(
                          child: AppbarSubtitle(
                            text: "lbl_notifications".tr,
                            margin: EdgeInsets.only(left: 95.h),
                          ),
                        ),
                        Spacer(),
                        //Container(color: Colors.black,width: 30, height: 30,margin: EdgeInsets.only(right: 22.h,left: 22.h),)
                      ],
                    ),
                  ),
                  SizedBox(height: 20.v),
                ],
              ),
              //styleType: Style.bgFill_1,
            ),
            body: SizedBox(
              width: mediaQueryData.size.width,
              child: SingleChildScrollView(
                //padding: EdgeInsets.only(top: 16.v),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 24.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                      ),
                      Obx(
                        () => controller.requests.length == 0
                            ? Container()
                            : Obx(
                                () => Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 24.0),
                                      child: InkWell(
                                          onTap: () {
                                            if (controller.show.value == true)
                                              controller.show.value = false;
                                            else
                                              controller.show.value = true;
                                          },
                                          child: Text(
                                            controller.show.value == false
                                                ? "Follow Requests" +
                                                    " (" +
                                                    controller.requests.length
                                                        .toString() +
                                                    ")"
                                                : "Hide Requests",
                                            style: TextStyle(
                                                color: Colors.blueAccent),
                                          )),
                                    )),
                              ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Obx(
                        () => controller.show.value == true
                            ? GetX<NotificationsController>(
                                builder: (context) => ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: controller.requestList.length,
                                      itemBuilder: (context, index) {
                                        print(controller.requestList[index]
                                            .data());
                                        return InkWell(
                                          onTap: () => Get.toNamed(
                                              AppRoutes.profileScreenUser,
                                              arguments: controller
                                                  .requestList[index]
                                                  .data()),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0),
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  color: theme
                                                      .colorScheme.background,
                                                  border: Border.all(
                                                      color: theme.colorScheme
                                                          .background, // Set border color
                                                      width: 3.0), // Set border width
                                                  borderRadius: BorderRadius.all(Radius.circular(10.0)), // Set rounded corner radius
                                                  boxShadow: [
                                                    BoxShadow(
                                                        blurRadius: 2,
                                                        color: Colors.black,
                                                        offset: Offset(1, 1))
                                                  ] // Make rounded corner of border
                                                  ),
                                              margin: EdgeInsets.only(
                                                //     left: 15.h,
                                                //     //top: 13.v,
                                                right: 20.h,
                                                //bottom: 7.v
                                              ),
                                              child: Column(
                                                children: [
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        /*
                                              ClipRRect(
                                                      //borderRadius: BorderRadius.all(Radius.circular(48.00)),
                                                      child: SvgPicture.asset(
                                                        //margin: EdgeInsets.only(left: 0),
                                                        ImageConstant.imgUserPrimary
                                                            .toString(),

                                                        color: appTheme.gray500
                                                            .withOpacity(0.4),
                                                        height: 60.adaptSize,
                                                        width: 60.adaptSize,
                                                      ),
                                                    ),*/

                                                        controller.requestList[
                                                                    index]
                                                                .data()
                                                                .containsKey(
                                                                    'photoUrl')
                                                            ? Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            7.0),
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              48.00)),
                                                                  child: Image
                                                                      .network(
                                                                    controller
                                                                        .requestList[
                                                                            index]
                                                                            [
                                                                            'profileUrl']
                                                                        .toString(),
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    height: 48
                                                                        .adaptSize,
                                                                    width: 48
                                                                        .adaptSize,
                                                                    loadingBuilder: (BuildContext
                                                                            context,
                                                                        Widget
                                                                            child,
                                                                        ImageChunkEvent?
                                                                            loadingProgress) {
                                                                      if (loadingProgress ==
                                                                          null)
                                                                        return child;
                                                                      return Center(
                                                                        child:
                                                                            CircularProgressIndicator(
                                                                          color: theme
                                                                              .colorScheme
                                                                              .primary,
                                                                          value: loadingProgress.expectedTotalBytes != null
                                                                              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                                                              : null,
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                              )
                                                            : ClipRRect(
                                                                //borderRadius: BorderRadius.all(Radius.circular(48.00)),
                                                                child:
                                                                    SvgPicture
                                                                        .asset(
                                                                  //margin: EdgeInsets.only(left: 0),
                                                                  ImageConstant
                                                                      .imgUserPrimary
                                                                      .toString(),

                                                                  color: appTheme
                                                                      .gray500
                                                                      .withOpacity(
                                                                          0.4),
                                                                  height: 60
                                                                      .adaptSize,
                                                                  width: 60
                                                                      .adaptSize,
                                                                ),
                                                              ),
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                              left: 10.h,
                                                              top: 7.v,
                                                              bottom: 7.v,
                                                            ),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  controller.requestList[
                                                                              index]
                                                                          [
                                                                          'fullName']
                                                                      as dynamic,

                                                                  //overflow: TextOverflow.ellipsis,
                                                                  maxLines:
                                                                      null,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: CustomTextStyles
                                                                      .titleSmallGray90002,
                                                                ),
                                                                Text(
                                                                  "has requested to follow you",
                                                                  maxLines:
                                                                      null,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: theme
                                                                      .textTheme
                                                                      .bodyMedium,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ]),
                                                  Row(
                                                    children: [
                                                      InkWell(
                                                        onTap: () => {
                                                          controller.acceptFollow(
                                                              controller
                                                                  .requestList[
                                                                      index]
                                                                  .data())
                                                        },
                                                        child: Container(
                                                          //margin: EdgeInsets.all(10),
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          alignment:
                                                              Alignment.center,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: theme
                                                                .colorScheme
                                                                .background,
                                                            border: Border.all(
                                                                //color: Colors.pink[800], // Set border color
                                                                width:
                                                                    0.5), // Set border width
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        10.0)), // Set rounded corner radius
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons.check,
                                                                color: Colors
                                                                    .green,
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                "Accept",
                                                                style: theme
                                                                    .textTheme
                                                                    .bodyMedium,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin:
                                                            EdgeInsets.all(10),
                                                        padding:
                                                            EdgeInsets.all(10),
                                                        alignment:
                                                            Alignment.center,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: theme
                                                              .colorScheme
                                                              .background,
                                                          border: Border.all(
                                                              //color: Colors.pink[800], // Set border color
                                                              width:
                                                                  0.5), // Set border width
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      10.0)), // Set rounded corner radius
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .not_interested,
                                                              color: Colors.red,
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(
                                                              "Reject",
                                                              style: theme
                                                                  .textTheme
                                                                  .bodyMedium,
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ))
                            : Container(),
                      ),
                      controller.notifications.length == 0
                          ? Center(
                              child: Text('No notifications'),
                            )
                          : Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(right: 25.h),
                                child: GetBuilder<NotificationsController>(
                                    builder: (context) {
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      reverse: true,
                                      itemCount:
                                          controller.notifications.length,
                                      itemBuilder: (context, index) {
                                        return (SectionlisttypeItemWidget(
                                            controller.notifications[index]));
                                      });
                                }),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
