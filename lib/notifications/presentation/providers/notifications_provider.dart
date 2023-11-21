import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taousapp/notifications/domain/models/notification/model.dart';
import 'package:taousapp/notifications/domain/usecases/get_notifications.dart';
import 'package:taousapp/util/di/di.dart';

final notificationsProvider =
    FutureProvider.autoDispose<List<NotificationModel>>((ref) async {
  final getNotificationsUsecase = sl<GetNotificationsUsecase>();
  final input = GetNotificationsUsecaseInput(
    authToken: '',
  );
  final output = await getNotificationsUsecase(input);
  return output.notifications;
});
