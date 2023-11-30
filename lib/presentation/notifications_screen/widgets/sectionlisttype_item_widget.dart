import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:taousapp/notifications/domain/enums/notification_type_enum.dart';
import 'package:taousapp/presentation/chat_screen/conversation_view.dart';

import '../controller/notifications_controller.dart';
import 'package:flutter/material.dart';
import 'package:taousapp/core/app_export.dart';
import 'package:timeago/timeago.dart' as timeago;

// ignore: must_be_immutable
class SectionlisttypeItemWidget extends StatefulWidget {
  var data;
  SectionlisttypeItemWidget(this.data, {super.key});

  @override
  State<SectionlisttypeItemWidget> createState() =>
      _SectionlisttypeItemWidgetState();
}

class _SectionlisttypeItemWidgetState extends State<SectionlisttypeItemWidget> {
  var controller = Get.find<NotificationsController>();

  @override
  Widget build(BuildContext context) {
    //print(data['timestamp'].millisecondsSinceEpoch.toString());
    if (widget.data['notification'][1] == null) {
      return const SizedBox();
    } else {
      return InkWell(
        onTap: () async {
          if (widget.data['type'] != null &&
              widget.data['type'] == NotificationType.newMessage.name) {
            final document = await FirebaseFirestore.instance
                .collection('TaousUser')
                .doc(widget.data['userId'])
                .get();

            if (document.exists) {
              final user = document.data();
              if (mounted) {
                showModalBottomSheet(
                    isDismissible: true,
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35.0),
                        topRight: Radius.circular(35.0),
                      ),
                    ),
                    builder: (context) {
                      return ConversationView(
                          username: user!['UserName'].toString(),
                          peeruid: user['uid'].toString(),
                          fullname: user['fullName'].toString());
                    });
              }
            }
          }
        },
        child: Container(
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
                          widget.data['notification'][0] ?? '',

                          //overflow: TextOverflow.ellipsis,
                          maxLines: null,
                          textAlign: TextAlign.left,
                          style: CustomTextStyles.titleSmallGray90002,
                        ),
                        Text(
                          widget.data['notification'][1] ?? '',
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
                    timeago.format(widget.data['timestamp'].toDate()),
                    maxLines: null,
                    textAlign: TextAlign.right,
                    style: theme.textTheme.bodySmall,
                  ),
                ),
              ]),
        ),
      );
    }
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
