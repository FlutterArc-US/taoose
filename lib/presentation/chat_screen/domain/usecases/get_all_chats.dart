import 'package:injectable/injectable.dart';
import 'package:taousapp/infrastructure/usecase.dart';
import 'package:taousapp/infrastructure/usecase_input.dart';
import 'package:taousapp/infrastructure/usecase_output.dart';
import 'package:taousapp/presentation/chat_screen/domain/repository/chat_repository.dart';
import 'package:taousapp/presentation/chat_screen/models/chat_model.dart';
import 'package:taousapp/presentation/chat_screen/models/message_model.dart';

class GetAllChatsUsecaseInput extends Input {
  GetAllChatsUsecaseInput({required this.userId});
  final String userId;
}

class GetAllChatsUsecaseOutput extends Output {
  GetAllChatsUsecaseOutput({required this.chats});
  final Stream<List<ChatModel>> chats;
}

@lazySingleton
class GetAllChatsUsecase
    extends Usecase<GetAllChatsUsecaseInput, GetAllChatsUsecaseOutput> {
  GetAllChatsUsecase({required ChatRepository chatsRepository})
      : _chatsRepository = chatsRepository;
  final ChatRepository _chatsRepository;

  @override
  Future<GetAllChatsUsecaseOutput> call(GetAllChatsUsecaseInput input) async {
    return _chatsRepository.getAllChats(input);
  }
}
