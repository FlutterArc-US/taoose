import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taousapp/presentation/chat_screen/models/message_model.dart';

class MessagesNotifier extends StateNotifier<List<MessageModel>> {
  MessagesNotifier() : super([]);

  void updateMessages(List<MessageModel> messages) {
    state = messages;
  }

  List<MessageModel> get messages => state;
}

final messagesProvider =
    StateNotifierProvider.autoDispose<MessagesNotifier, List<MessageModel>>(
        (ref) {
  return MessagesNotifier();
});
