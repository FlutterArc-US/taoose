import 'package:intl/intl.dart';

import '../controller/notifications_controller.dart';
import 'package:flutter/material.dart';
import 'package:taousapp/core/app_export.dart';
import 'package:timeago/timeago.dart' as timeago;

// ignore: must_be_immutable
class SectionlisttypeItemWidget extends StatelessWidget {
  var data;
  SectionlisttypeItemWidget(this.data);

  var controller = Get.find<NotificationsController>();

  @override
  Widget build(BuildContext context) {
    //print(data['timestamp'].millisecondsSinceEpoch.toString());
    return Container(
      margin: EdgeInsets.only(
          //     left: 15.h,
          //     //top: 13.v,
          //     right: 17.h,
          bottom: 7.v),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgProfile,
              height: 50.adaptSize,
              width: 50.adaptSize,
              radius: BorderRadius.circular(
                25.h,
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
                      data['notification'][0],

                      //overflow: TextOverflow.ellipsis,
                      maxLines: null,
                      textAlign: TextAlign.left,
                      style: CustomTextStyles.titleSmallGray90002,
                    ),
                    Text(
                      data['notification'][1],
                      maxLines: null,
                      textAlign: TextAlign.left,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                timeago.format(data['timestamp'].toDate()),
                maxLines: null,
                textAlign: TextAlign.right,
                style: theme.textTheme.bodySmall,
              ),
            ),
          ]),
    );
  }

  String readTimestamp(int timestamp) {
    var now = DateTime.now();
    var format = DateFormat('HH:mm a');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + 'D';
      } else {
        time = diff.inDays.toString() + 'D';
      }
    } else {
      if (diff.inDays == 7) {
        time = (diff.inDays / 7).floor().toString() + 'W';
      } else {
        time = (diff.inDays / 7).floor().toString() + 'W';
      }
    }

    return time;
  }
}
