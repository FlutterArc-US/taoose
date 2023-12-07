import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taousapp/core/app_export.dart';
import 'package:taousapp/presentation/chat_screen/models/message_model.dart';

// ignore: must_be_immutable
class SendBubble extends StatelessWidget {
  int indexR;
  final MessageModel message;
  SendBubble(this.indexR, this.message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var time =
        DateTime.fromMillisecondsSinceEpoch(int.parse(message.timestamp));
    var convertedTime = DateFormat.jm().format(DateTime.parse(time.toString()));
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            margin: EdgeInsets.only(left: 97.h, top: 10.v, right: 15.h),
            padding: EdgeInsets.symmetric(
              horizontal: 16.h,
              vertical: 15.v,
            ),
            decoration: AppDecoration.fillGray10003.copyWith(
              borderRadius: BorderRadiusStyle.customBorderTL151,
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
        ),
        SizedBox(height: 5.v),
        Align(
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 1.v),
                child: Text(
                  convertedTime,
                  style: CustomTextStyles.bodySmallSkModernistBlack900,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15, left: 4),
                child: Icon(
                  Icons.circle,
                  color: theme.colorScheme.primary,
                  size: 10,
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
