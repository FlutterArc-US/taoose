import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taousapp/core/app_export.dart';
import 'package:taousapp/presentation/chat_screen/controller/show_emoji_provider.dart';
import 'package:taousapp/theme/theme_helper.dart';

class CustomEmojiWidget extends ConsumerStatefulWidget {
  const CustomEmojiWidget({
    required this.controller,
    this.onEmojiSelected,
    super.key,
  });

  final TextEditingController controller;

  final void Function(Category?, Emoji)? onEmojiSelected;

  @override
  ConsumerState<CustomEmojiWidget> createState() => _CustomEmojiWidgetState();
}

class _CustomEmojiWidgetState extends ConsumerState<CustomEmojiWidget> {
  @override
  Widget build(BuildContext context) {
    final showEmojis = ref.watch(showEmojiProvider);
    return Offstage(
      offstage: !showEmojis,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.18,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(17),
            bottomRight: Radius.circular(17),
          ),
          child: EmojiPicker(
            onEmojiSelected: widget.onEmojiSelected,
            onBackspacePressed: () {
              // Do something when the user taps the backspace button (optional)
              // Set it to null to hide the Backspace-Button
            },
            textEditingController: widget.controller, // pass here the same
            // [TextEditingController] that is connected to your input field, usually a [TextFormField]
            config: Config(
              columns: 7,
              emojiSizeMax: 20 *
                  (foundation.defaultTargetPlatform == TargetPlatform.iOS
                      ? 1.30
                      : 1.0), // Issue: https://github.com/flutter/flutter/issues/28894
              verticalSpacing: 0,
              horizontalSpacing: 0,
              gridPadding: EdgeInsets.zero,
              initCategory: Category.RECENT,
              bgColor: const Color(0xFFF2F2F2),
              indicatorColor: theme.colorScheme.primary,
              iconColor: Colors.grey,
              iconColorSelected: theme.colorScheme.primary,
              backspaceColor: theme.colorScheme.primary,
              skinToneDialogBgColor: Colors.white,
              skinToneIndicatorColor: Colors.grey,
              enableSkinTones: true,
              recentTabBehavior: RecentTabBehavior.RECENT,
              recentsLimit: 28,
              noRecents: const Text(
                'No Recents',
                style: TextStyle(fontSize: 20, color: Colors.black26),
                textAlign: TextAlign.center,
              ), // Needs to be const Widget
              loadingIndicator:
                  const SizedBox.shrink(), // Needs to be const Widget
              tabIndicatorAnimDuration: kTabScrollDuration,
              categoryIcons: const CategoryIcons(),
              buttonMode: ButtonMode.MATERIAL,
            ),
          ),
        ),
      ),
    );
  }
}
