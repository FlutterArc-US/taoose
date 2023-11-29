import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taousapp/presentation/chat_screen/models/chat_model.dart';

class ChatsNotifier extends StateNotifier<List<ChatModel>> {
  ChatsNotifier() : super([]);

  void updateChats(List<ChatModel> chats) {
    if (state.isEmpty) {
      state = chats;
    } else {
      state = chats.map((chat) {
        if (state.any((stateChat) => stateChat.id == chat.id)) {
          final matchedChat =
              state.firstWhere((stateChat) => stateChat.id == chat.id);
          return chat.copyWith(user: matchedChat.user);
        } else {
          return chat;
        }
      }).toList();
    }
  }

  void removeChat(String chatId) {
    state = state.where((chat) => chat.id != chatId).toList();
  }

  void updateChat(ChatModel chat) {
    state = state.map((e) => e.id == chat.id ? chat : e).toList();
  }

  List<ChatModel> get chats => state;
}

final chatsSearchFormProvider = StateProvider.autoDispose<String>((ref) => '');

final chatsProvider =
    StateNotifierProvider.autoDispose<ChatsNotifier, List<ChatModel>>((ref) {
  return ChatsNotifier();
});

final searchedChatsProvider = Provider.autoDispose<List<ChatModel>>((ref) {
  final chats = ref.watch(chatsProvider);
  final searched = ref.watch(chatsSearchFormProvider);

  if (searched.isEmpty) {
    return chats;
  }

  return chats.where((element) {
    final name = "${element.user?['fullName'] ?? ''}";

    return name.toLowerCase().contains(searched.toLowerCase());
  }).toList();
});
