import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:taousapp/notifications/domain/models/notification/push_notification.dart';
import 'package:taousapp/notifications/domain/usecases/send_notificaiton.dart';
import 'package:taousapp/presentation/chat_screen/data/source/chat_firebase_datasource.dart';
import 'package:taousapp/presentation/chat_screen/domain/usecases/create_message.dart';
import 'package:taousapp/presentation/chat_screen/models/message_type.dart';
import 'package:injectable/injectable.dart';
import 'package:taousapp/util/di/di.dart';

@LazySingleton(as: ChatFirebaseDataSource)
class ChatsFirebaseDataSourceImp extends ChatFirebaseDataSource {
  final firestore = FirebaseFirestore.instance;
  final sendNotificationUsecase = sl<SendNotificationUsecase>();

  @override
  Future<CreateMessageUsecaseOutput> createMessage(
    CreateMessageUsecaseInput input,
  ) async {
    final messageData = <String, dynamic>{
      'idFrom': input.userid,
      'idTo': input.peeruid,
      'timestamp': input.timestamp,
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
        'members': [input.userid, input.peeruid]
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
        userId: peerId,
        notification: PushNotification(
          title: 'New Message',
          description: '$username has sent you message',
          id: DateTime.now().millisecondsSinceEpoch,
        ),
      );

      await sendNotificationUsecase(input);
    }
  }
}
