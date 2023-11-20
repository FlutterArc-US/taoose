import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taousapp/core/app_export.dart';
import 'package:taousapp/presentation/chat_screen/models/message_type.dart';

// ignore: must_be_immutable
class RecieveImageBubble extends StatelessWidget {
  int indexR;
  var docR;
  RecieveImageBubble(this.indexR, this.docR, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var time =
        DateTime.fromMillisecondsSinceEpoch(int.parse(docR['timestamp']));
    var convertedTime = DateFormat.jm().format(DateTime.parse(time.toString()));
    print(
        DateTime.fromMillisecondsSinceEpoch(int.parse(docR['timestamp'])).hour);

    if (docR['type'] == MessageType.image.id) {
      final images = List<String>.from(docR['imageUrls']);

      return Column(
        children: List<String>.from(images ?? [])
            .map(
              (e) => Column(
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
                      borderRadius: BorderRadiusStyle.customBorderTL15,
                    ),
                    child: SizedBox(
                      height: 140.h,
                      width: 213,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          height: 55.h,
                          width: 55,
                          color: Colors.grey,

                          /// [file image use here]
                          child: Image.network(e, fit: BoxFit.cover),
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
                            style:
                                CustomTextStyles.bodySmallSkModernistBlack900,
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
              ),
            )
            .toList(),
      );
    } else {
      return const SizedBox();
    }
  }
}
