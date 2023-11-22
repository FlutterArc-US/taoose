import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taousapp/core/app_export.dart';
import 'package:taousapp/notifications/domain/models/notification/push_notification.dart';
import 'package:taousapp/notifications/domain/usecases/send_notificaiton.dart';
import 'package:taousapp/presentation/post_screen/controller/post_controller.dart';
import 'package:taousapp/theme/app_decoration.dart';
import 'package:taousapp/util/di/di.dart';

// ignore: must_be_immutable
class CustomPost extends StatelessWidget {
  int index;
  var data;

  CustomPost(this.data, this.index, {super.key});

  var controller = Get.find<PostController>();

  final sendNotificationUsecase = sl<SendNotificationUsecase>();

  Future<void> sendLikeNotification({String? postOwnerId}) async {
    final userId = controller.hController.getUid();

    if (postOwnerId != null && userId != postOwnerId) {
      final document = await FirebaseFirestore.instance
          .collection('TaousUser')
          .doc(userId)
          .get();
      if (!document.exists) {
        return;
      }
      final data = document.data();
      final username = data?['fullName'];

      final input = SendNotificationUsecaseInput(
        userId: postOwnerId,
        notification: PushNotification(
          title: 'New liked',
          description: '$username has liked your post',
          id: DateTime.now().millisecondsSinceEpoch,
        ),
      );

      await sendNotificationUsecase(input);
    }
  }

  @override
  Widget build(BuildContext context) {
    RxInt liked = 0.obs;
    RxInt total = 0.obs;
    total.value = controller.posts[index]['likedBy'].length;
    if (controller.posts[index]['likedBy']
        .contains(controller.hController.getUid().toString())) {
      print('trueeeee');
      liked.value = 1;
    } else {
      liked.value = 0;
    }
    return Container(
      decoration: AppDecoration.fillPrimaryContainer.copyWith(
        borderRadius: BorderRadiusStyle.circleBorder20,

        //for the box shadow

        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 16.h,
              top: 16.v,
              right: 13.h,
            ),
            child: InkWell(
              onTap: () {
                print(controller.posts[index]['owner'].toString());
                if (data['uid'] != controller.hController.getUid()) {
                  Get.toNamed(AppRoutes.profileScreenUser, arguments: data);
                } else {
                  controller.hController.pageController.animateToPage(
                    3,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  data!.data().toString().contains('profileUrl')
                      ? ClipRRect(
                          borderRadius:
                              BorderRadius.all(Radius.circular(40.00)),
                          child: Image.network(
                            data['profileUrl'].toString(),
                            fit: BoxFit.cover,
                            height: 40.adaptSize,
                            width: 40.adaptSize,
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
                        )
                      : CustomImageView(
                          color: appTheme.gray500.withOpacity(0.4),
                          svgPath: ImageConstant.imgUserPrimary,
                          height: 40.adaptSize,
                          width: 40.adaptSize,
                          radius: BorderRadius.circular(
                            40.h,
                          ),
                        ),
                  Padding(
                    padding: EdgeInsets.only(left: 12.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data["fullName"].toString(),
                          style: CustomTextStyles.titleSmallSemiBold,
                        ),
                        SizedBox(height: 3.v),
                        Text(
                          "@" + data["UserName"].toString(),
                          style: CustomTextStyles.bodySmallGray50003,
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  CustomImageView(
                    svgPath: ImageConstant.imgMioptionshorizontal,
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
          ),
          SizedBox(height: 13.v),
          SizedBox(
            //height: 303.v,
            //width: 330.h,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                InkWell(
                  onDoubleTap: () async {
                    if (liked.value == 0) {
                      controller.posts[index]['likedBy']
                          .add(controller.hController.getUid().toString());
                      print(controller.posts[index]['likedBy']);
                      await controller.docFetch
                          .doc(controller.posts[index]['owner'].toString())
                          .collection(controller.posts[index]['description'])
                          .doc(controller.posts[index]['postId'])
                          .update({
                        'likedBy': FieldValue.arrayUnion(
                            [controller.hController.getUid().toString()])
                      });
                      //print(controller.docFetch.doc(controller.posts[index]['owner'].toString()));
                      liked.value = 1;
                      total.value = total.value + 1;
                      //controller.posts.refresh();
                    } else {
                      print('Liked already');
                    }
                  },
                  onTap: () {
                    Get.toNamed(AppRoutes.prodcutDetailsOneScreen, arguments: [
                      controller.posts[index]['description']
                          .toString()
                          .capitalizeFirst,
                      controller.posts[index]
                    ]);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.00),
                        bottomRight: Radius.circular(20.00)),
                    child: Image.network(
                      controller.posts[index]['photoUrl'],
                      fit: BoxFit.fitWidth,
                      //height: 100.adaptSize,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 16.h),
                        child: Column(
                          children: [
                            Obx(
                              () => liked.value == 1
                                  ? InkWell(
                                      onTap: () async {
                                        //TODO: NOTIFICATION
                                        controller.posts[index]['likedBy']
                                            .remove(controller.hController
                                                .getUid()
                                                .toString());
                                        print(
                                            controller.posts[index]['likedBy']);
                                        await controller.docFetch
                                            .doc(controller.posts[index]
                                                    ['owner']
                                                .toString())
                                            .collection(controller.posts[index]
                                                ['description'])
                                            .doc(controller.posts[index]
                                                ['postId'])
                                            .update({
                                          'likedBy': FieldValue.arrayRemove([
                                            controller.hController
                                                .getUid()
                                                .toString()
                                          ])
                                        });
                                        liked.value = 0;
                                        total.value = total.value - 1;
                                        //controller.posts.refresh();
                                      },
                                      child: CustomImageView(
                                        svgPath: ImageConstant.imgLikeicon,
                                        color: Colors.red,
                                        height: 26.adaptSize,
                                        width: 26.adaptSize,
                                      ),
                                    )
                                  : InkWell(
                                      onTap: () async {
                                        //await controller.docFetch.doc(controller.hController.getUid().toString()).update({'posts'[index]: });
                                        controller.posts[index]['likedBy'].add(
                                            controller.hController
                                                .getUid()
                                                .toString());
                                        print(
                                            controller.posts[index]['likedBy']);
                                        await controller.docFetch
                                            .doc(controller.posts[index]
                                                    ['owner']
                                                .toString())
                                            .collection(controller.posts[index]
                                                ['description'])
                                            .doc(controller.posts[index]
                                                ['postId'])
                                            .update({
                                          'likedBy': FieldValue.arrayUnion([
                                            controller.hController
                                                .getUid()
                                                .toString()
                                          ])
                                        });
                                        //print(controller.docFetch.doc(controller.posts[index]['owner'].toString()));
                                        liked.value = 1;
                                        total.value = total.value + 1;

                                        sendLikeNotification(
                                            postOwnerId: controller.posts[index]
                                                ['owner']);
                                        //controller.posts.refresh();
                                      },
                                      child: CustomImageView(
                                        svgPath: ImageConstant.imgLikeicon,
                                        height: 26.adaptSize,
                                        width: 26.adaptSize,
                                      ),
                                    ),
                            ),
                            SizedBox(height: 1.v),
                            /*
                                                                            controller.posts[index]['likedBy'].contains(controller.hController.getUid().toString())?
                                                                            Container(width: 50, height: 50, child: Text("Contains"), color: Colors.green,):
                                                                            Container(width: 50, height: 50, child: Text("No"), color: Colors.red,),
                                                                            */
                            Obx(
                              () => Text(
                                total.value.toString(),
                                style:
                                    CustomTextStyles.bodySmallPrimaryContainer,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 17.v),
                      SizedBox(
                        height: 125.v,
                        width: 330.h,
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                //height: 300,
                                margin: EdgeInsets.only(top: 27.v),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.h,
                                  vertical: 15.v,
                                ),
                                decoration:
                                    AppDecoration.gradientBlackToBlack.copyWith(
                                  borderRadius:
                                      BorderRadiusStyle.customBorderBL20,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 6.h,
                                        top: 3.v,
                                      ),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 5.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              controller.posts[index]['cloths'],
                                              //style: TextStyle(color: appTheme.indigo900),
                                              style: CustomTextStyles
                                                  .titleMediumPrimaryContainer,
                                            ),
                                            SizedBox(height: 1.v),
                                            SizedBox(
                                              width: 214.h,
                                              child: Text(
                                                controller.posts[index]
                                                    ['description'],
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: CustomTextStyles
                                                    .bodyMediumPrimaryContainer
                                                    .copyWith(
                                                  height: 1.38,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 14.v),
                                      child: Column(
                                        children: [
                                          CustomImageView(
                                            imagePath:
                                                ImageConstant.imgShareicon,
                                            height: 24.adaptSize,
                                            width: 24.adaptSize,
                                          ),
                                          SizedBox(height: 1.v),
                                          Text(
                                            "0".tr,
                                            style: CustomTextStyles
                                                .bodySmallPrimaryContainer,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: InkWell(
                                onTap: () {
                                  Get.toNamed(AppRoutes.commentsScreen,
                                      arguments: controller.posts[index]);
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(right: 16.h),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomImageView(
                                        imagePath: ImageConstant.imgCommenticon,
                                        height: 25.adaptSize,
                                        width: 25.adaptSize,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 5.h,
                                          top: 1.v,
                                        ),
                                        child: Text(
                                          controller.posts[index]['comments']
                                              .toString(),
                                          style: CustomTextStyles
                                              .bodySmallPrimaryContainer,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
