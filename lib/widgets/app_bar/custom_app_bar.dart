import 'package:flutter/material.dart';
import 'package:taousapp/core/app_export.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({
    Key? key,
    this.height,
    this.styleType,
    this.leadingWidth,
    this.leading,
    this.title,
    this.centerTitle,
    this.actions,
  }) : super(
          key: key,
        );

  final double? height;

  final Style? styleType;

  final double? leadingWidth;

  final Widget? leading;

  final Widget? title;

  final bool? centerTitle;

  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      toolbarHeight: height ?? 56.v,
      automaticallyImplyLeading: false,
      backgroundColor: appTheme.whiteA700,
      flexibleSpace: _getStyle(),
      leadingWidth: leadingWidth ?? 0,
      leading: leading,
      title: title,
      titleSpacing: 0,
      centerTitle: centerTitle ?? false,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size(
        mediaQueryData.size.width,
        height ?? 56.v,
      );
  _getStyle() {
    switch (styleType) {
      case Style.bgFill_1:
        return Container(
          height: 1.v,
          width: 374.h,
          margin: EdgeInsets.only(
            left: 1.h,
            top: 48.530003.v,
            bottom: 6.470001.v,
          ),
          decoration: BoxDecoration(
            color: appTheme.gray20002,
          ),
        );
      case Style.bgFill:
        return Container(
          height: 1.v,
          width: 374.h,
          margin: EdgeInsets.only(
            left: 1.h,
            top: 42.050003.v,
          ),
          decoration: BoxDecoration(
            color: appTheme.gray20002,
          ),
        );
      default:
        return null;
    }
  }
}

enum Style {
  bgFill_1,
  bgFill,
}
