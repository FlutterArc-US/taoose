import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taousapp/core/app_export.dart';

import '../controller/chats_provider.dart';

class ChatSearchBarWidget extends ConsumerStatefulWidget {
  const ChatSearchBarWidget({super.key});

  @override
  ConsumerState<ChatSearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends ConsumerState<ChatSearchBarWidget> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        style: TextStyle(
          fontSize: 16,
        ),
        onChanged: (value) {
          ref.read(chatsSearchFormProvider.notifier).state = value;
        },
        controller: searchController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 11),
          focusedErrorBorder: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: appTheme.gray20001,
            ),
            borderRadius: BorderRadius.circular(13),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: BorderSide(
              color: appTheme.gray20001,
            ),
          ),
          hintText: "lbl_search".tr,
          hintStyle: TextStyle(
            fontSize: 16,
            height: 1.7.h,
          ),
          prefixIcon: Row(
            children: [
              SizedBox(width: 5),
              CustomImageView(
                svgPath: ImageConstant.imgCharmsearch,
                height: 23.adaptSize,
                width: 23.adaptSize,
                margin: EdgeInsets.only(bottom: 1.v),
              ),
            ],
          ),
          prefixIconConstraints: BoxConstraints(maxWidth: 30, maxHeight: 20),
          suffixIconConstraints: BoxConstraints(maxWidth: 30, maxHeight: 20),
        ),
      ),
    );
  }
}
