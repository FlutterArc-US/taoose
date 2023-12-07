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
      child: TextField(
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
        onChanged: (value) {
          ref.read(chatsSearchFormProvider.notifier).state = value;
        },
        controller: searchController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 11),
          enabled: true,
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
            color: Colors.grey,
          ),
          prefixIcon: SizedBox(
            height: 15,
            width: 15,
            child: SvgPicture.asset(
              ImageConstant.imgCharmsearch,
              height: 15,
              width: 15,
            ),
          ),
        ),
      ),
    );
  }
}
