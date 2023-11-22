import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taousapp/notifications/domain/usecases/show_local_notification.dart';
import 'package:taousapp/notifications/presentation/providers/listen_foreground_notifications_provider.dart';
import 'package:taousapp/util/di/di.dart';

final showNotificationProvider = FutureProvider.autoDispose
    .family<void, PayloadNotification>((ref, notification) async {
  final showLocalNotificationUsecase = sl<ShowLocalNotificationUsecase>();

  final input = ShowLocalNotificationUsecaseInput(
    title: notification.title,
    body: notification.description,
    id: notification.id,
  );
  await showLocalNotificationUsecase(input);
});
