import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taousapp/core/app_export.dart';
import 'package:taousapp/presentation/chat_screen/models/message_model.dart';
import 'package:taousapp/presentation/chat_screen/models/message_type.dart';
import 'package:taousapp/widgets/show_images_dialog.dart';

// ignore: must_be_immutable
class SendImageBubble extends StatefulWidget {
  int indexR;
  final MessageModel message;
  SendImageBubble(this.indexR, this.message, {Key? key}) : super(key: key);

  @override
  State<SendImageBubble> createState() => _SendImageBubbleState();
}

class _SendImageBubbleState extends State<SendImageBubble> {
  void onTapImage(String? image) {
    showDialog<void>(
      context: context,
      builder: (context) =>
          ShowImagesDialog(images: image != null ? [image] : []),
    );
  }

  @override
  Widget build(BuildContext context) {
    var time = DateTime.fromMillisecondsSinceEpoch(
        int.parse(widget.message.timestamp));
    var convertedTime = DateFormat.jm().format(DateTime.parse(time.toString()));

    if (widget.message.type == MessageType.image.id) {
      final images = List<String>.from(widget.message.imageUrls ?? []);
      return Column(
        children: List<String>.from(images ?? [])
            .map(
              (e) => InkWell(
                onTap: () => onTapImage(e),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        margin:
                            EdgeInsets.only(left: 97.h, top: 10.v, right: 15.h),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.h,
                          vertical: 15.v,
                        ),
                        decoration: AppDecoration.fillGray10003.copyWith(
                          borderRadius: BorderRadiusStyle.customBorderTL151,
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
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: e,
                                progressIndicatorBuilder:
                                    (context, value, downloadProgress) {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      value: downloadProgress.progress,
                                    ),
                                  );
                                },
                                errorWidget: (ctx, url, stackTrace) =>
                                    const Icon(Icons.info_outline),
                              ),
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
                              style:
                                  CustomTextStyles.bodySmallSkModernistBlack900,
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
                ),
              ),
            )
            .toList(),
      );
    } else {
      return SizedBox();
    }
  }
}
