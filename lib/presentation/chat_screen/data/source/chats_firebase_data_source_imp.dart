import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:taousapp/presentation/chat_screen/data/source/chat_firebase_datasource.dart';
import 'package:taousapp/presentation/chat_screen/domain/usecases/create_message.dart';
import 'package:taousapp/presentation/chat_screen/models/message_type.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ChatFirebaseDataSource)
class ChatsFirebaseDataSourceImp extends ChatFirebaseDataSource {
  final firestore = FirebaseFirestore.instance;

  @override
  Future<CreateMessageUsecaseOutput> createMessage(
    CreateMessageUsecaseInput input,
  ) async {
    final messageData = <String, dynamic>{
      'idFrom': input.userid,
      'idTo': input.peeruid,
      'timestamp': input.timestamp,
      'type': input.type,
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

    var ref =
        FirebaseFirestore.instance.collection('messages').doc(input.chatId);
    var documentReference = ref
        .collection(input.chatId)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());

    /// [Create a batch write]
    /// [Add a new document to the message collection]
    final batch = FirebaseFirestore.instance.batch()
      ..set(
        documentReference,
        messageData,
      );

    // Commit the batch write
    await batch.commit();

    return CreateMessageUsecaseOutput();
  }
}
