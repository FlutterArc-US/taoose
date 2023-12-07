import 'package:injectable/injectable.dart';
import 'package:taousapp/infrastructure/usecase.dart';
import 'package:taousapp/infrastructure/usecase_input.dart';
import 'package:taousapp/infrastructure/usecase_output.dart';
import 'package:taousapp/presentation/chat_screen/domain/repository/chat_repository.dart';

class CreateChatUsecaseInput extends Input {
  CreateChatUsecaseInput({
    required this.members,
    required this.time,
    required this.chatId,
  });
  final int time;
  final String chatId;
  final List<String> members;
}

class CreateChatUsecaseOutput extends Output {
  CreateChatUsecaseOutput({required this.chatId});
  final String chatId;
}

@lazySingleton
class CreateChatUsecase
    extends Usecase<CreateChatUsecaseInput, CreateChatUsecaseOutput> {
  CreateChatUsecase({required ChatRepository chatsRepository})
      : _chatsRepository = chatsRepository;
  final ChatRepository _chatsRepository;

  @override
  Future<CreateChatUsecaseOutput> call(CreateChatUsecaseInput input) async {
    return _chatsRepository.createChat(input);
  }
}
