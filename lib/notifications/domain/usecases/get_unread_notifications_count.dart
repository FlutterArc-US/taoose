import 'package:taousapp/infrastructure/usecase.dart';
import 'package:taousapp/infrastructure/usecase_input.dart';
import 'package:taousapp/infrastructure/usecase_output.dart';

import 'package:injectable/injectable.dart';
import 'package:taousapp/notifications/domain/repository/notifications_repository.dart';

class GetUnreadNotificationsCountUsecaseInput extends Input {
  GetUnreadNotificationsCountUsecaseInput({
    required this.authToken,
  });

  final String authToken;
}

class GetUnreadNotificationsCountUsecaseOutput extends Output {
  GetUnreadNotificationsCountUsecaseOutput({required this.unreadCount});

  final int unreadCount;
}

@lazySingleton
class GetUnreadNotificationsCountUsecase extends Usecase<
    GetUnreadNotificationsCountUsecaseInput,
    GetUnreadNotificationsCountUsecaseOutput> {
  GetUnreadNotificationsCountUsecase({
    required NotificationsRepository firebaseMessagingRepository,
  }) : _firebaseMessagingRepository = firebaseMessagingRepository;
  final NotificationsRepository _firebaseMessagingRepository;

  @override
  Future<GetUnreadNotificationsCountUsecaseOutput> call(
    GetUnreadNotificationsCountUsecaseInput input,
  ) async {
    return _firebaseMessagingRepository.getUnreadNotificationsCount(input);
  }
}
