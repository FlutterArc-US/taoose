import 'package:taousapp/infrastructure/usecase.dart';
import 'package:taousapp/infrastructure/usecase_input.dart';
import 'package:taousapp/infrastructure/usecase_output.dart';

import 'package:injectable/injectable.dart';
import 'package:taousapp/notifications/domain/repository/notifications_repository.dart';

class UpdateFcmTokenUsecaseInput extends Input {
  UpdateFcmTokenUsecaseInput({
    required this.fcmToken,
    required this.token,
  });

  final String fcmToken;
  final String token;
}

class UpdateFcmTokenUsecaseOutput extends Output {
  UpdateFcmTokenUsecaseOutput();
}

@lazySingleton
class UpdateFcmTokenUsecase
    extends Usecase<UpdateFcmTokenUsecaseInput, UpdateFcmTokenUsecaseOutput> {
  UpdateFcmTokenUsecase({
    required NotificationsRepository firebaseMessagingRepository,
  }) : _firebaseMessagingRepository = firebaseMessagingRepository;
  final NotificationsRepository _firebaseMessagingRepository;

  @override
  Future<UpdateFcmTokenUsecaseOutput> call(
    UpdateFcmTokenUsecaseInput input,
  ) async {
    return _firebaseMessagingRepository.updateFcmToken(input);
  }
}
