import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taousapp/core/app_export.dart';

// ignore: must_be_immutable
class CustomSearchWidget extends StatelessWidget {
  var data;
  CustomSearchWidget(this.data);
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
                    borderRadius: BorderRadius.all(Radius.circular(48.00)),
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
                    "@" + data['UserName'].toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: CustomTextStyles.bodyMediumGray60002,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
