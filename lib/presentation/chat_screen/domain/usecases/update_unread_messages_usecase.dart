import 'package:injectable/injectable.dart';
import 'package:taousapp/infrastructure/usecase.dart';
import 'package:taousapp/infrastructure/usecase_input.dart';
import 'package:taousapp/infrastructure/usecase_output.dart';
import 'package:taousapp/presentation/chat_screen/domain/repository/chat_repository.dart';

class MarkReadMessagesUsecaseInput extends Input {
  MarkReadMessagesUsecaseInput({
    required this.userId,
    required this.chatId,
  });
  final String chatId;
  final String userId;
}

class MarkReadMessagesUsecaseOutput extends Output {
  MarkReadMessagesUsecaseOutput();
}

@lazySingleton
class MarkReadMessagesUsecase extends Usecase<MarkReadMessagesUsecaseInput,
    MarkReadMessagesUsecaseOutput> {
  MarkReadMessagesUsecase({required ChatRepository chatsRepository})
      : _chatsRepository = chatsRepository;
  final ChatRepository _chatsRepository;

  @override
  Future<MarkReadMessagesUsecaseOutput> call(
    MarkReadMessagesUsecaseInput input,
  ) async {
    return _chatsRepository.updateUnReadMessages(input);
  }
}
