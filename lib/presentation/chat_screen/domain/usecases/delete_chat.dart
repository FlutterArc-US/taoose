import 'package:injectable/injectable.dart';
import 'package:taousapp/infrastructure/usecase.dart';
import 'package:taousapp/infrastructure/usecase_input.dart';
import 'package:taousapp/infrastructure/usecase_output.dart';
import 'package:taousapp/presentation/chat_screen/domain/repository/chat_repository.dart';

class DeleteChatUsecaseInput extends Input {
  DeleteChatUsecaseInput({
    required this.chatId,
    required this.userId,
  });
  final String chatId;
  final String userId;
}

class DeleteChatUsecaseOutput extends Output {
  DeleteChatUsecaseOutput();
}

@lazySingleton
class DeleteChatUsecase
    extends Usecase<DeleteChatUsecaseInput, DeleteChatUsecaseOutput> {
  DeleteChatUsecase({required ChatRepository chatsRepository})
      : _chatsRepository = chatsRepository;
  final ChatRepository _chatsRepository;

  @override
  Future<DeleteChatUsecaseOutput> call(DeleteChatUsecaseInput input) async {
    return _chatsRepository.deleteChat(input);
  }
}
