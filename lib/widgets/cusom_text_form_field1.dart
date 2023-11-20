import 'package:flutter/material.dart';
import 'package:taousapp/core/app_export.dart';
import 'package:taousapp/presentation/edit_profile_screen/controller/edit_profile_controller.dart';

// ignore: must_be_immutable
class CustomTextFormField1 extends StatelessWidget {
  CustomTextFormField1({
    Key? key,
    this.alignment,
    this.readonly = false,
    this.width,
    this.margin,
    this.controller,
    required this.userNameController,
    this.onChanged,
    this.focusNode,
    this.autofocus = true,
    this.textStyle,
    this.obscureText = false,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.maxLines,
    this.hintText,
    this.hintStyle,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.contentPadding,
    this.borderDecoration,
    this.fillColor,
    this.filled = true,
    this.initialvalue,
    this.validator,
  }) : super(
          key: key,
        );

  final Alignment? alignment;

  final String? initialvalue;

  final bool? readonly;

  final double? width;

  final EdgeInsetsGeometry? margin;

  final TextEditingController? controller;
  final EditprofileController userNameController;
  void Function(String)? onChanged;
  final FocusNode? focusNode;

  final bool? autofocus;

  final TextStyle? textStyle;

  final bool? obscureText;

  final TextInputAction? textInputAction;

  final TextInputType? textInputType;

  final int? maxLines;

  final String? hintText;

  final TextStyle? hintStyle;

  final Widget? prefix;

  final BoxConstraints? prefixConstraints;

  final Widget? suffix;

  final BoxConstraints? suffixConstraints;

  final EdgeInsets? contentPadding;

  final InputBorder? borderDecoration;

  final Color? fillColor;

  final bool? filled;

  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: textFormFieldWidget,
          )
        : textFormFieldWidget;
  }

  Widget get textFormFieldWidget => Container(
        width: width ?? double.maxFinite,
        margin: margin,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TextFormField(
            readOnly: readonly ?? false,
            cursorColor: theme.colorScheme.primary,
            controller: controller,
            onChanged: (newUsername) {
              userNameController.checkUsernameAvailability(newUsername);
            },
            focusNode: focusNode ?? FocusNode(),
            autofocus: autofocus!,
            style: textStyle ?? CustomTextStyles.titleSmallBluegray40001,
            obscureText: obscureText!,
            textInputAction: textInputAction,
            initialValue: initialvalue,
            keyboardType: textInputType,
            maxLines: maxLines ?? 1,
            decoration: decoration,
            validator: validator,
          ),
          /*Obx(() {
            if (userNameController.isUsernameValid.value) {
              return SizedBox.shrink();
            } else {
              return Text(
                'Username already taken',
                style: TextStyle(color: Colors.red),
              );
            }
          }),*/
        ]),
      );
  InputDecoration get decoration => InputDecoration(
        hintText: hintText ?? "",
        hintStyle: hintStyle ?? CustomTextStyles.bodyMediumBlack900,
        prefixIcon: prefix,
        prefixIconConstraints: prefixConstraints,
        suffixIcon: suffix,
        suffixIconConstraints: suffixConstraints,
        isDense: true,
        contentPadding: contentPadding ?? EdgeInsets.symmetric(vertical: 2.v),
        fillColor:
            fillColor ?? theme.colorScheme.primaryContainer.withOpacity(0),
        filled: filled,
        border: borderDecoration,
        enabledBorder: borderDecoration ??
            UnderlineInputBorder(
                borderSide: BorderSide(color: appTheme.gray300)),
        focusedBorder: borderDecoration ??
            UnderlineInputBorder(
                borderSide: BorderSide(color: theme.colorScheme.primary)),
      );
}

/// Extension on [CustomTextFormField] to facilitate inclusion of all types of border style etc
extension TextFormFieldStyleHelper on CustomTextFormField1 {
  static OutlineInputBorder get outlineBlack => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.h),
        borderSide: BorderSide.none,
      );
  static OutlineInputBorder get fillGray => OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.h),
        borderSide: BorderSide.none,
      );
}



// class CustomTextFormField1 extends StatelessWidget {
//   final TextEditingController controller;
//   final EditprofileController userController;

//   CustomTextFormField1(
//       {required this.controller, required this.userController});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         TextFormField(
//           controller: controller,
//           onChanged: (newUsername) {
//             userController.checkUsernameAvailability(newUsername);
//           },
//           decoration: InputDecoration(
//             hintText: 'Username',
//           ),
//         ),
//         Obx(() {
//           if (userController.isUsernameValid.value) {
//             return SizedBox.shrink();
//           } else {
//             return Text(
//               'Username already taken',
//               style: TextStyle(color: Colors.red),
//             );
//           }
//         }),
//       ],
//     );
//   }
// }
