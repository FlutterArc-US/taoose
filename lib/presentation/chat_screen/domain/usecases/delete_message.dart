import 'package:injectable/injectable.dart';
import 'package:taousapp/infrastructure/usecase.dart';
import 'package:taousapp/infrastructure/usecase_input.dart';
import 'package:taousapp/infrastructure/usecase_output.dart';
import 'package:taousapp/presentation/chat_screen/domain/repository/chat_repository.dart';

class DeleteMessageUsecaseInput extends Input {
  DeleteMessageUsecaseInput({
    required this.messageId,
    required this.userId,
    required this.chatId,
  });
  final String chatId;
  final String messageId;
  final String userId;
}

class DeleteMessageUsecaseOutput extends Output {
  DeleteMessageUsecaseOutput();
}

@lazySingleton
class DeleteMessageUsecase
    extends Usecase<DeleteMessageUsecaseInput, DeleteMessageUsecaseOutput> {
  DeleteMessageUsecase({required ChatRepository chatsRepository})
      : _chatsRepository = chatsRepository;
  final ChatRepository _chatsRepository;

  @override
  Future<DeleteMessageUsecaseOutput> call(
    DeleteMessageUsecaseInput input,
  ) async {
    return _chatsRepository.deleteMessage(input);
  }
}
