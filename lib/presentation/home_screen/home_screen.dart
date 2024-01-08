import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taousapp/core/app_export.dart';
import 'package:taousapp/main.dart';
import 'package:taousapp/presentation/chat_screen/chat_screen.dart';
import 'package:taousapp/presentation/chat_screen/controller/chat_controller.dart';
import 'package:taousapp/presentation/frends_screen/controller/frends_controller.dart';
import 'package:taousapp/presentation/frends_screen/frends_screen.dart';
import 'package:taousapp/presentation/home_screen/controller/home_controller.dart';
import 'package:taousapp/presentation/notifications_screen/controller/notifications_controller.dart';
import 'package:taousapp/presentation/post_screen/controller/post_controller.dart';
import 'package:taousapp/presentation/post_screen/post_screen.dart';
import 'package:taousapp/presentation/profile_screen/controller/profile_controller.dart';
import 'package:taousapp/presentation/profile_screen/profile_screen.dart';
import 'package:taousapp/presentation/settings_screen/controller/settings_controller.dart';
import 'package:taousapp/widgets/custom_bottom_bar.dart';
import 'package:taousapp/widgets/custom_outlined_button.dart';

class HomeScreen extends GetWidget<HomeController> {
  const HomeScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    Get.put(FrendsController());
    Get.put(ChatController());
    Get.put(NotificationsController());
    Get.put(PostController());
    Get.put(ProfileController());
    Get.put(SettingsController());

    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.transparent,
        /*appBar: CustomAppBar(
          title: AppbarImage1( 
            svgPath: ImageConstant.imgFrameIndigo900,
            margin: EdgeInsets.only(left: 23.h),
          ),
          actions: [
            AppbarIconbutton(
              svgPath: ImageConstant.imgIconslight,
              margin: EdgeInsets.symmetric(
                horizontal: 22.h,
                vertical: 2.v,
              ),
            ),
          ],
        ),*/
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: FloatingActionButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            onPressed: () {
              Get.toNamed(AppRoutes.prodcutDetailsScreen);
            },
            child: Icon(
              Icons.add,
              color: Colors.black,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: WillPopScope(
          onWillPop: () {
            return _onBackPressed(context) as Future<bool>;
          },
          child: Container(
              child: Obx(() => getCurrentWidget(controller.type.value))),
        ),
        bottomNavigationBar: CustomBottomBar(
          onChanged: (BottomBarEnum type) {
            if (type == BottomBarEnum.Carprimarycontainer) {
              chatEnabled = true;
            } else {
              chatEnabled = false;
            }

            controller.type.value = type;
            //print(controller.pageController);
          },
        ),
      ),
    );
  }

  _onBackPressed(BuildContext context) {
    if (controller.selectedIndex.value == 0) {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            //title: Text('Exit!'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Do you want to exit?',
                  style: CustomTextStyles.titleSmallSemiBold,
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  //width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomOutlinedButton(
                          decoration: BoxDecoration(color: Colors.red),
                          width: 75.h,
                          text: 'Yes',
                          buttonTextStyle: CustomTextStyles.titleSmallSemiBold,
                          onTap: () {
                            SystemNavigator.pop(); //Will exit the App
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomOutlinedButton(
                          width: 75.h,
                          text: 'No',
                          buttonTextStyle: CustomTextStyles.titleSmallSemiBold,
                          onTap: () {
                            Navigator.of(context)
                                .pop(false); //Will not exit the App
                          },
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      );
    } else {
      controller.pageController.animateToPage(
        0,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
      return false;
    }
  }

  Widget getCurrentWidget(BottomBarEnum type) {
    return PageView(
      controller: controller.pageController,
      onPageChanged: (value) {
        controller.selectedIndex.value = value;
        print(controller.selectedIndex.value);
        print('rrr' + value.toString());
      },
      children: <Widget>[
        PostScreen(),
        FrendsScreen(),
        ChatScreen(),
        ProfileScreen()
      ],
    );

    /*switch (type) {
      case BottomBarEnum.Home24x24:
        return HomeScreen();
      case BottomBarEnum.Location:
        return FavouritesScreen();
      case BottomBarEnum.Notification:
        return NotificationsScreen();
      case BottomBarEnum.User24x24:
        return ProfileScreen();
      default:
        return getDefaultWidget();
    }*/
  }
}
