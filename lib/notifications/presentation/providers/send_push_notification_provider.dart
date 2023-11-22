import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taousapp/notifications/domain/models/notification/push_notification.dart';
import 'package:taousapp/notifications/domain/usecases/send_notificaiton.dart';
import 'package:taousapp/util/di/di.dart';

final sendPushNotificationProvider = FutureProvider.family
    .autoDispose<void, PushNotification>((ref, notification) async {
  final sendNotificationUsecase = sl<SendNotificationUsecase>();

  final token = await FirebaseMessaging.instance.getToken();

  if (token != null) {
    final input = SendNotificationUsecaseInput(
      userId: token,
      notification: notification,
    );
    await sendNotificationUsecase(input);
  }
});
