import 'package:taousapp/infrastructure/usecase.dart';
import 'package:taousapp/infrastructure/usecase_input.dart';
import 'package:taousapp/infrastructure/usecase_output.dart';

import 'package:injectable/injectable.dart';
import 'package:taousapp/notifications/data/entities/notification_entity/notification_entity.dart';
import 'package:taousapp/notifications/domain/models/notification/model.dart';
import 'package:taousapp/notifications/domain/repository/notifications_repository.dart';

class GetNotificationsUsecaseInput extends Input {
  GetNotificationsUsecaseInput({
    required this.authToken,
  });

  final String authToken;
}

class GetNotificationsUsecaseOutput extends Output {
  GetNotificationsUsecaseOutput({
    required List<RestNotificationEntity> notifications,
  }) : _notifications =
            notifications.map(NotificationModel.fromEntity).toList();
  final List<NotificationModel> _notifications;

  List<NotificationModel> get notifications => _notifications;
}

@lazySingleton
class GetNotificationsUsecase extends Usecase<GetNotificationsUsecaseInput,
    GetNotificationsUsecaseOutput> {
  GetNotificationsUsecase({
    required NotificationsRepository firebaseMessagingRepository,
  }) : _firebaseMessagingRepository = firebaseMessagingRepository;
  final NotificationsRepository _firebaseMessagingRepository;

  @override
  Future<GetNotificationsUsecaseOutput> call(
    GetNotificationsUsecaseInput input,
  ) async {
    return _firebaseMessagingRepository.getNotifications(input);
  }
}
