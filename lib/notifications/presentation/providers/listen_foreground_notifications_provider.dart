import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final listenForegroundNotificationsProvider =
    StreamProvider.autoDispose<PayloadNotification>((ref) {
  final subscription = StreamController<PayloadNotification>();

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {
      final title = message.notification?.title ?? '';
      final description = message.notification?.body ?? '';
      final id = int.parse(message.data['id'] as String);

      final notification = PayloadNotification(
        title: title,
        id: id,
        type: '',
        description: description,
      );

      subscription.add(notification);
    }
  });

  return subscription.stream;
});

class PayloadNotification {
  PayloadNotification({
    required this.id,
    required this.title,
    required this.type,
    required this.description,
  });

  final String title;
  final String description;
  final String type;
  final int id;
}

final notificationsListenerProvider =
    Provider.autoDispose<PayloadNotification?>((ref) {
  final notifications = ref.watch(listenForegroundNotificationsProvider);
  return notifications.valueOrNull;
});
