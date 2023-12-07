import 'package:injectable/injectable.dart';
import 'package:taousapp/infrastructure/usecase.dart';
import 'package:taousapp/infrastructure/usecase_input.dart';
import 'package:taousapp/infrastructure/usecase_output.dart';
import 'package:taousapp/presentation/chat_screen/domain/repository/chat_repository.dart';
import 'package:taousapp/presentation/chat_screen/models/message_model.dart';
import 'package:taousapp/presentation/messages_screen/models/messages_model.dart';

class GetAllMessagesUsecaseInput extends Input {
  GetAllMessagesUsecaseInput({
    required this.userId,
    required this.chatId,
  });
  final String chatId;
  final String userId;
}

class GetAllMessagesUsecaseOutput extends Output {
  GetAllMessagesUsecaseOutput({required this.messages});

  final Stream<List<MessageModel>> messages;
}

@lazySingleton
class GetAllMessagesUsecase
    extends Usecase<GetAllMessagesUsecaseInput, GetAllMessagesUsecaseOutput> {
  GetAllMessagesUsecase({required ChatRepository chatsRepository})
      : _chatsRepository = chatsRepository;
  final ChatRepository _chatsRepository;

  @override
  Future<GetAllMessagesUsecaseOutput> call(
    GetAllMessagesUsecaseInput input,
  ) async {
    return _chatsRepository.getAllMessages(input);
  }
}
