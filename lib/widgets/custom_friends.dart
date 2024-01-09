import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taousapp/core/app_export.dart';
import 'package:taousapp/presentation/home_screen/controller/home_controller.dart';
import 'package:taousapp/presentation/profile_screen_user/controller/profile_controller_user.dart';
import 'package:taousapp/widgets/custom_elevated_button.dart';

// ignore: must_be_immutable
class CustomFriends extends StatelessWidget {
  var pController = Get.put(ProfileControllerUser());
  var hController = Get.find<HomeController>();
  // ignore: prefer_typing_uninitialized_variables
  var data;
  CustomFriends(this.data, {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: 15.h,
          //top: 13.v,
          right: 17.h,
          bottom: 7.v),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          data!.toString().contains('profileUrl')
              ? Padding(
                  padding: const EdgeInsets.only(left: 7.0),
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.all(Radius.circular(48.00)),
                    child: Image.network(
                      data['profileUrl'].toString(),
                      fit: BoxFit.cover,
                      height: 48.adaptSize,
                      width: 48.adaptSize,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            color: theme.colorScheme.primary,
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                )
              : ClipRRect(
                  //borderRadius: BorderRadius.all(Radius.circular(48.00)),
                  child: SvgPicture.asset(
                    //margin: EdgeInsets.only(left: 0),
                    ImageConstant.imgUserPrimary.toString(),

                    color: appTheme.gray500.withOpacity(0.4),
                    height: 60.adaptSize,
                    width: 60.adaptSize,
                  ),
                ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: 10.h,
                top: 7.v,
                bottom: 7.v,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['fullName'].toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: theme.textTheme.titleSmall,
                  ),
                  Text(
                    "@${data['UserName']}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: CustomTextStyles.bodyMediumGray60002,
                  ),
                ],
              ),
            ),
          ),
          (data['followers'].contains(hController.getUid().toString()))
              ? CustomElevatedButton(
                  onTap: () =>
                      print(pController.checkFollowing(data).toString()),
                  //decoration: BoxDecoration(color: Colors.red),
                  height: 24.v,
                  width: 96.h,
                  text: "Following".tr,
                  margin: EdgeInsets.only(
                    // left: 21.h,
                    top: 16.v,
                    bottom: 16.v,
                  ),
                  buttonStyle:
                      // ignore: deprecated_member_use
                      ElevatedButton.styleFrom(primary: appTheme.indigo900),
                  buttonTextStyle: TextStyle(
                    color: appTheme.whiteA700,
                    fontSize: 10.fSize,
                    fontFamily: 'Nunito Sans',
                    fontWeight: FontWeight.w600,
                  ),
                )
              : data?['requests'].contains(hController.getUid().toString())
                  ? CustomElevatedButton(
                      onTap: () => print(pController.checkFollowing(data)),
                      //decoration: BoxDecoration(color: Colors.red),
                      height: 24.v,
                      width: 96.h,
                      text: "Requested".tr,
                      margin: EdgeInsets.only(
                        //left: 21.h,
                        top: 16.v,
                        bottom: 16.v,
                      ),
                      buttonStyle:
                          // ignore: deprecated_member_use
                          ElevatedButton.styleFrom(
                              primary: theme.colorScheme.background),
                      buttonTextStyle: TextStyle(
                        color: appTheme.black900,
                        fontSize: 10.fSize,
                        fontFamily: 'Nunito Sans',
                        fontWeight: FontWeight.w600,
                      ))
                  : CustomElevatedButton(
                      onTap: () => print(pController.checkFollowing(data)),
                      //decoration: BoxDecoration(color: Colors.red),
                      height: 24.v,
                      width: 96.h,
                      text: "Follow".tr,
                      margin: EdgeInsets.only(
                        //left: 21.h,
                        top: 16.v,
                        bottom: 16.v,
                      ),
                      buttonStyle:
                          // ignore: deprecated_member_use
                          ElevatedButton.styleFrom(
                              primary: theme.colorScheme.background),
                      buttonTextStyle: TextStyle(
                        color: appTheme.black900,
                        fontSize: 12.fSize,
                        fontFamily: 'Nunito Sans',
                        fontWeight: FontWeight.w600,
                      )),
        ],
      ),
    );
  }
}
