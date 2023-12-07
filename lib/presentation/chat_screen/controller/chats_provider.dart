import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taousapp/presentation/chat_screen/models/chat_model.dart';

class ChatsNotifier extends StateNotifier<List<ChatModel>> {
  ChatsNotifier() : super([]);

  void updateChats(List<ChatModel> chats, String userId) async {
    if (state.isEmpty) {
      for (var chat in chats) {
        final otherUserId =
            chat.members.firstWhere((element) => element != userId);
        var data = await getUser(otherUserId);
        chats = chats
            .map((e) => e.id == chat.id ? e.copyWith(user: data) : e)
            .toList();
      }
      state = chats;

      ///
    } else {
      chats = chats.map((chat) {
        if (state.any((stateChat) => stateChat.id == chat.id)) {
          final matchedChat =
              state.firstWhere((stateChat) => stateChat.id == chat.id);
          return chat.copyWith(user: matchedChat.user);
        } else {
          return chat;
        }
      }).toList();

      for (var chat in chats) {
        if (state.any(
            (stateChat) => stateChat.id == chat.id && stateChat.user == null)) {
          final otherUserId =
              chat.members.firstWhere((element) => element != userId);
          var data = await getUser(otherUserId);
          chats = chats
              .map((e) => e.id == chat.id ? e.copyWith(user: data) : e)
              .toList();
        }
      }

      state = chats;
    }
  }

  Future<Map<String, dynamic>?> getUser(String userId) async {
    final document = await FirebaseFirestore.instance
        .collection('TaousUser')
        .doc(userId)
        .get();

    return document.data();
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
