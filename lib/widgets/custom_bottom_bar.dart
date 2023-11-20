import 'package:flutter/material.dart';
import 'package:taousapp/core/app_export.dart';
import 'package:taousapp/presentation/home_screen/controller/home_controller.dart';

// ignore: must_be_immutable
class CustomBottomBar extends StatelessWidget {
  var homeController = Get.find<HomeController>();
  CustomBottomBar({
    Key? key,
    this.onChanged,
  }) : super(
          key: key,
        );

  //RxInt selectedIndex = 0.obs;

  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: ImageConstant.imgHome,
      activeIcon: ImageConstant.imgHome,
      type: BottomBarEnum.Home,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgCar,
      activeIcon: ImageConstant.imgCar,
      type: BottomBarEnum.Car,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgCarPrimarycontainer,
      activeIcon: ImageConstant.imgCarPrimarycontainer,
      type: BottomBarEnum.Carprimarycontainer,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgUserPrimary,
      activeIcon: ImageConstant.imgUserPrimary,
      type: BottomBarEnum.Userprimary,
    )
  ];

  Function(BottomBarEnum)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62.v,
      margin: EdgeInsets.only(left: 23.h, right: 23.h, bottom: 10.h),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              blurRadius: 25.0, offset: Offset(0, -10.0), color: Colors.white)
        ],
        color: appTheme.indigo900,
        borderRadius: BorderRadius.circular(
          31.h,
        ),
      ),
      child: Obx(
        () => BottomNavigationBar(
          backgroundColor: Colors.transparent,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedFontSize: 0,
          elevation: 0,
          currentIndex: homeController.selectedIndex.value,
          type: BottomNavigationBarType.fixed,
          items: List.generate(bottomMenuList.length, (index) {
            return BottomNavigationBarItem(
              icon: index == 3
                  ? homeController.getPhotoUrl() != 'null'
                      ? ClipRRect(
                          borderRadius:
                              BorderRadius.all(Radius.circular(26.00)),
                          child: Image.network(
                            homeController.getPhotoUrl(),
                            fit: BoxFit.fill,
                            height: 26.adaptSize,
                            width: 26.adaptSize,
                          ),
                        )
                      : CustomImageView(
                          svgPath: bottomMenuList[index].icon,
                          height: 24.adaptSize,
                          width: 24.adaptSize,
                          color:
                              theme.colorScheme.primaryContainer.withOpacity(1),
                        )
                  : CustomImageView(
                      svgPath: bottomMenuList[index].icon,
                      height: 24.adaptSize,
                      width: 24.adaptSize,
                      color: theme.colorScheme.primaryContainer.withOpacity(1),
                    ),
              activeIcon: 
              index == 3?
              homeController.getPhotoUrl() != 'null'?
              Container(
                height: 27,
                width: 27,
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)),color:theme.colorScheme.primary),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: ClipRRect(
                    
                              borderRadius:
                                  BorderRadius.all(Radius.circular(26.00)),
                              child: Image.network(
                                homeController.getPhotoUrl(),
                                fit: BoxFit.fill,
                                height: 26.adaptSize,
                                width: 26.adaptSize,
                              ),
                            ),
                ),
              ):
              CustomImageView(
                svgPath: bottomMenuList[index].activeIcon,
                height: 24.adaptSize,
                width: 24.adaptSize,
                color: theme.colorScheme.primary,
              ):CustomImageView(
                svgPath: bottomMenuList[index].activeIcon,
                height: 24.adaptSize,
                width: 24.adaptSize,
                color: theme.colorScheme.primary,
              ),
              label: '',
            );
          }),
          onTap: (index) {
            homeController.selectedIndex.value = index;
            print(index);
            homeController.pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOut,
            );
            onChanged?.call(bottomMenuList[index].type);
          },
        ),
      ),
    );
  }
}

enum BottomBarEnum {
  Home,
  Car,
  Carprimarycontainer,
  Userprimary,
}

class BottomMenuModel {
  BottomMenuModel({
    required this.icon,
    required this.activeIcon,
    required this.type,
  });

  String icon;

  String activeIcon;

  BottomBarEnum type;
}

class DefaultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please replace the respective Widget here',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
