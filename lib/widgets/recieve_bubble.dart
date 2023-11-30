import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taousapp/core/app_export.dart';
import 'package:taousapp/presentation/chat_screen/models/message_model.dart';

// ignore: must_be_immutable
class RecieveBubble extends StatelessWidget {
  int indexR;
  final MessageModel message;
  RecieveBubble(this.indexR, this.message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var time =
        DateTime.fromMillisecondsSinceEpoch(int.parse(message.timestamp));
    var convertedTime = DateFormat.jm().format(DateTime.parse(time.toString()));
    print(
        DateTime.fromMillisecondsSinceEpoch(int.parse(message.timestamp)).hour);
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            left: 3.h,
            top: 9.v,
            right: 94.h,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 16.h,
            vertical: 17.v,
          ),
          decoration: AppDecoration.fillPrimary.copyWith(
            color: theme.colorScheme.primary.withOpacity(0.07),
            borderRadius: BorderRadiusStyle.customBorderTL15,
          ),
          child: SizedBox(
            width: 213.h,
            child: Text(
              message.content ?? '',
              maxLines: 1000,
              overflow: TextOverflow.ellipsis,
              style: CustomTextStyles.bodyMedium14.copyWith(
                height: 1.50,
              ),
            ),
          ),
        ),
        SizedBox(height: 5.v),
        Align(
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 1.v, left: 10.h),
                child: Text(
                  convertedTime,
                  style: CustomTextStyles.bodySmallSkModernistBlack900,
                ),
              ),

              /*CustomImageView(
                svgPath: ImageConstant.imgCheckmarkRed400,
                height: 16.adaptSize,
                width: 16.adaptSize,
                margin: EdgeInsets.only(left: 4.h,right: 15.h),
              ),*/
            ],
          ),
        ),
      ],
    );
  }
}
