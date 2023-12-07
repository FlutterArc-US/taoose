import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:taousapp/core/app_export.dart';

class ShowImagesDialog extends StatefulWidget {
  const ShowImagesDialog({required this.images, super.key});
  final List<String> images;

  @override
  State<ShowImagesDialog> createState() => _ShowImagesDialogState();
}

class _ShowImagesDialogState extends State<ShowImagesDialog> {
  late int imageCount = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Dialog(
        backgroundColor: Colors.black,
        elevation: 0,
        insetPadding: EdgeInsets.zero,
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Container(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: 36.h,
                    width: 36,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Center(
                      child: Icon(
                        Icons.cancel,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              Expanded(
                child: PageView(
                  onPageChanged: (value) {
                    setState(() {
                      imageCount = value;
                    });
                  },
                  children: widget.images
                      .map(
                        (imageUrl) => Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: imageUrl,
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
                      )
                      .toList(),
                ),
              ),
              SizedBox(height: 21.h),
              Text(
                '${imageCount + 1}/${widget.images.length}',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
