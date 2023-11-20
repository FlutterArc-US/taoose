import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:taousapp/infrastructure/usecase.dart';
import 'package:taousapp/infrastructure/usecase_input.dart';
import 'package:taousapp/infrastructure/usecase_output.dart';
import 'package:taousapp/presentation/chat_screen/data/source/chat_firebase_datasource.dart';

/// [Input]
abstract class CreateMessageUsecaseInput extends Input {
  CreateMessageUsecaseInput({
    required this.userid,
    required this.peeruid,
    required this.timestamp,
    required this.status,
    required this.type,
    required this.chatId,
  });
  final String userid;
  final String chatId;
  final String peeruid;
  final String timestamp;
  final int type;
  final int status;
}

/// [TextMessage Input]
class CreateTextMessageUsecaseInput extends CreateMessageUsecaseInput {
  CreateTextMessageUsecaseInput({
    required super.userid,
    required super.peeruid,
    required super.type,
    required super.chatId,
    required super.status,
    required super.timestamp,
    required this.content,
  });
  final String content;
}

/// [ImageMessage Input]
class CreateImageMessageUsecaseInput extends CreateMessageUsecaseInput {
  CreateImageMessageUsecaseInput({
    required super.userid,
    required super.peeruid,
    required super.type,
    required super.chatId,
    required super.status,
    required super.timestamp,
    required this.images,
  });
  final List<File> images;
}

class CreateMessageUsecaseOutput extends Output {
  CreateMessageUsecaseOutput();
}

@lazySingleton
class CreateMessageUsecase
    extends Usecase<CreateMessageUsecaseInput, CreateMessageUsecaseOutput> {
  CreateMessageUsecase({required ChatFirebaseDataSource chatFirebaseDataSource})
      : _chatFirebaseDataSource = chatFirebaseDataSource;
  final ChatFirebaseDataSource _chatFirebaseDataSource;

  @override
  Future<CreateMessageUsecaseOutput> call(
      CreateMessageUsecaseInput input) async {
    return _chatFirebaseDataSource.createMessage(input);
  }
}
