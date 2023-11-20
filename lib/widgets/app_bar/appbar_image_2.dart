import 'package:flutter/material.dart';
import 'package:taousapp/core/app_export.dart';

// ignore: must_be_immutable
class AppbarImage2 extends StatelessWidget {
  AppbarImage2({
    Key? key,
    this.imagePath,
    this.svgPath,
    this.margin,
    this.onTap,
  }) : super(
          key: key,
        );

  String? imagePath;

  String? svgPath;

  EdgeInsetsGeometry? margin;

  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: CustomImageView(
          svgPath: svgPath,
          imagePath: imagePath,
          height: 16.v,
          width: 9.h,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
