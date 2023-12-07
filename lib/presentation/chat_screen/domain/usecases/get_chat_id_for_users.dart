import 'package:injectable/injectable.dart';
import 'package:taousapp/infrastructure/usecase.dart';
import 'package:taousapp/infrastructure/usecase_input.dart';
import 'package:taousapp/infrastructure/usecase_output.dart';
import 'package:taousapp/presentation/chat_screen/domain/repository/chat_repository.dart';

class GetChatIdForUsersUsecaseInput extends Input {
  GetChatIdForUsersUsecaseInput({required this.members});
  final List<String> members;
}

class GetChatIdForUsersUsecaseOutput extends Output {
  GetChatIdForUsersUsecaseOutput({required this.chatId});
  final String chatId;
}

@lazySingleton
class GetChatIdForUsersUsecase extends Usecase<GetChatIdForUsersUsecaseInput,
    GetChatIdForUsersUsecaseOutput> {
  GetChatIdForUsersUsecase({required ChatRepository chatRepository})
      : _chatRepository = chatRepository;
  final ChatRepository _chatRepository;

  @override
  Future<GetChatIdForUsersUsecaseOutput> call(
    GetChatIdForUsersUsecaseInput input,
  ) async {
    return _chatRepository.getChatIdForUsers(input);
  }
}
