import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:taousapp/infrastructure/repository.dart';
import 'package:taousapp/notifications/domain/enums/notification_type_enum.dart';
import 'package:taousapp/presentation/chat_screen/data/source/chat_firebase_datasource.dart';
import 'package:taousapp/presentation/chat_screen/domain/repository/chat_repository.dart';
import 'package:taousapp/presentation/chat_screen/domain/usecases/create_chat.dart';
import 'package:taousapp/presentation/chat_screen/domain/usecases/create_message.dart';
import 'package:taousapp/presentation/chat_screen/domain/usecases/delete_chat.dart';
import 'package:taousapp/presentation/chat_screen/domain/usecases/delete_message.dart';
import 'package:taousapp/presentation/chat_screen/domain/usecases/get_all_chats.dart';
import 'package:taousapp/presentation/chat_screen/domain/usecases/get_all_messages.dart';
import 'package:taousapp/presentation/chat_screen/domain/usecases/get_chat_id_for_users.dart';
import 'package:taousapp/presentation/chat_screen/domain/usecases/update_unread_messages_usecase.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:taousapp/notifications/domain/models/notification/push_notification.dart';
import 'package:taousapp/notifications/domain/usecases/send_notificaiton.dart';
import 'package:taousapp/presentation/chat_screen/data/source/chat_firebase_datasource.dart';
import 'package:taousapp/presentation/chat_screen/domain/usecases/create_message.dart';
import 'package:taousapp/presentation/chat_screen/models/chat_model.dart';
import 'package:taousapp/presentation/chat_screen/models/message_model.dart';
import 'package:taousapp/presentation/chat_screen/models/message_type.dart';
import 'package:injectable/injectable.dart';
import 'package:taousapp/util/di/di.dart';

@LazySingleton(as: ChatFirebaseDataSource)
class ChatsFirebaseDataSourceImp extends ChatFirebaseDataSource {
  final firestore = FirebaseFirestore.instance;
  final sendNotificationUsecase = sl<SendNotificationUsecase>();

  @override
  Future<CreateChatUsecaseOutput> createChat(
      CreateChatUsecaseInput input) async {
    await FirebaseFirestore.instance
        .collection('messages')
        .doc(input.chatId)
        .set(
      {
        'id': input.chatId,
        'members': input.members,
        'timestamp': input.time,
      },
      SetOptions(
        merge: true,
      ),
    );
    return CreateChatUsecaseOutput(chatId: '');
  }

  @override
  Future<CreateMessageUsecaseOutput> createMessage(
    CreateMessageUsecaseInput input,
  ) async {
    await createChat(CreateChatUsecaseInput(
      chatId: input.chatId,
      members: [input.userid, input.peeruid],
      time: DateTime.now().microsecondsSinceEpoch,
    ));

    final messageData = <String, dynamic>{
      'idFrom': input.userid,
      'idTo': input.peeruid,
      'timestamp': input.timestamp.toString(),
      'type': input.type,
      'members': [input.userid, input.peeruid],
      "status": 1
    };

    if (input is CreateTextMessageUsecaseInput) {
      messageData['type'] = input.type;
      messageData['content'] = input.content;
    } else if (input is CreateImageMessageUsecaseInput) {
      final urls = <String>[];
      for (final img in input.images) {
        final uploadTask = FirebaseStorage.instance
            .ref('media')
            .child(input.chatId)
            .child('${DateTime.now().toIso8601String()}.png')
            .putFile(img);

        final task = await uploadTask;
        final url = await task.ref.getDownloadURL();
        urls.add(url);
      }

      messageData['imageUrls'] = urls;
      messageData['content'] = '';
      messageData['type'] = input.type;
    }

    print(input.chatId);
    var documentReference = FirebaseFirestore.instance
        .collection('messages')
        .doc(input.chatId)
        .collection(input.chatId)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());

    /// [Create a batch write]
    /// [Add a new document to the message collection]
    final batch = FirebaseFirestore.instance.batch()
      ..set(
        documentReference,
        messageData,
      );

    await FirebaseFirestore.instance
        .collection('messages')
        .doc(input.chatId)
        .set(
      {
        'timestamp': input.timestamp,
        'message': {
          'content':
              input is CreateTextMessageUsecaseInput ? input.content : "",
          'type': input.type,
        },
        'unReadMsgCountFor${input.userid}': FieldValue.increment(1),
        'unReadMsgCountFor${input.peeruid}': FieldValue.increment(1),
      },
      SetOptions(merge: true),
    );

    // Commit the batch write
    await batch.commit().then((value) {
      sendMessageNotification(
        peerId: input.peeruid,
        currentUserId: input.userid,
      );
    });

    return CreateMessageUsecaseOutput();
  }

  /// [Send Message notification]
  Future<void> sendMessageNotification({
    String? peerId,
    String? currentUserId,
  }) async {
    if (currentUserId != null && peerId != null) {
      final document = await FirebaseFirestore.instance
          .collection('TaousUser')
          .doc(currentUserId)
          .get();
      if (!document.exists) {
        return;
      }
      final data = document.data();
      final username = data?['fullName'];

      final input = SendNotificationUsecaseInput(
        toUserId: peerId,
        notification: PushNotification(
          title: 'New Message',
          type: NotificationType.newMessage.name,
          description: '$username has sent you message',
          id: DateTime.now().millisecondsSinceEpoch,
        ),
      );

      await sendNotificationUsecase(input);
    }
  }

  @override
  Future<DeleteChatUsecaseOutput> deleteChat(
    DeleteChatUsecaseInput input,
  ) async {
    throw UnimplementedError();
    // final data = {
    //   'availableFor': FieldValue.arrayRemove([input.userId]),
    // };
    //
    // await firestore.collection(_chats).doc(input.chatId).update(data);
    // return DeleteChatUsecaseOutput();
  }

  @override
  Future<GetAllChatsUsecaseOutput> getAllChats(
    GetAllChatsUsecaseInput input,
  ) async {
    final chats = FirebaseFirestore.instance
        .collection('messages')
        .where('members', arrayContains: input.userId)
        .orderBy('timestamp', descending: true)
        .withConverter(
          fromFirestore: (snapshot, _) {
            final data = snapshot.data();

            final unReadMessageCount =
                data!['unReadMsgCountFor${input.userId}'];

            return ChatModel.fromJson(snapshot.data()!)
                .copyWith(unReadMsgCount: unReadMessageCount);
          },
          toFirestore: (chat, _) => {},
        );

    final snapshots = chats.snapshots().map(
          (querySnapshot) =>
              querySnapshot.docs.map((doc) => doc.data()).toList(),
        );
    return GetAllChatsUsecaseOutput(chats: snapshots);
  }

  @override
  Future<GetAllMessagesUsecaseOutput> getAllMessages(
    GetAllMessagesUsecaseInput input,
  ) async {
    final messages = FirebaseFirestore.instance
        .collection('messages')
        .doc(input.chatId)
        .collection(input.chatId)
        .orderBy('timestamp', descending: true)
        .withConverter(
          fromFirestore: (snapshot, _) {
            final data = snapshot.data()!;
            data.putIfAbsent('id', () => snapshot.id);
            return MessageModel.fromJson(data);
          },
          toFirestore: (message, _) => {},
        );

    final snapshots = messages.snapshots().map(
          (querySnapshot) =>
              querySnapshot.docs.map((doc) => doc.data()).toList(),
        );

    return GetAllMessagesUsecaseOutput(messages: snapshots);
  }

  @override
  Future<GetChatIdForUsersUsecaseOutput> getChatIdForUsers(
    GetChatIdForUsersUsecaseInput input,
  ) async {
    // final id = getChatId(input.members);

    return GetChatIdForUsersUsecaseOutput(chatId: '');
  }

  @override
  Future<MarkReadMessagesUsecaseOutput> updateUnReadMessages(
    MarkReadMessagesUsecaseInput input,
  ) async {
    FirebaseFirestore.instance.collection('messages').doc(input.chatId).update({
      'unReadMsgCountFor${input.userId}': 0,
    });

    return MarkReadMessagesUsecaseOutput();
  }

  @override
  Future<DeleteMessageUsecaseOutput> deleteMessage(
      DeleteMessageUsecaseInput input) {
    // TODO: implement deleteMessage
    throw UnimplementedError();
  }
}
