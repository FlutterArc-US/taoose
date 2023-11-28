import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:taousapp/core/constants/constants.dart';
import 'package:taousapp/infrastructure/usecase.dart';
import 'package:taousapp/infrastructure/usecase_input.dart';
import 'package:taousapp/infrastructure/usecase_output.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:taousapp/main.dart';
import 'package:taousapp/notifications/domain/models/notification/push_notification.dart';

class SendNotificationUsecaseInput extends Input {
  SendNotificationUsecaseInput({
    required this.userId,
    required this.notification,
  });

  final String userId;
  final PushNotification notification;
}

class SendNotificationUsecaseOutput extends Output {
  SendNotificationUsecaseOutput();
}

@lazySingleton
class SendNotificationUsecase extends Usecase<SendNotificationUsecaseInput,
    SendNotificationUsecaseOutput> {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  Future<SendNotificationUsecaseOutput> call(
    SendNotificationUsecaseInput input,
  ) async {
    await sendFCMNotification(input.userId, input.notification);
    return SendNotificationUsecaseOutput();
  }

  Future<void> sendFCMNotification(
      String userId, PushNotification notification) async {
    final document = await FirebaseFirestore.instance
        .collection('TaousUser')
        .doc(userId)
        .get();

    if (!document.exists) {
      return;
    }
    final data = document.data();

    var reference1 =
        FirebaseFirestore.instance.collection('TaousUser').doc(userId);

    reference1.update({
      'notifications': FieldValue.arrayUnion(
        [
          {
            'id': channel.id,
            'timestamp': DateTime.now(),
            'notification': [notification.title, notification.description]
          }
        ],
      )
    });

    final fcmToken = data?['fcmToken'];

    if (fcmToken == null) {
      return;
    }

    var url = Uri.parse('https://fcm.googleapis.com/fcm/send');

    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $firebaseAuthorizationKey',
      },
      body: jsonEncode({
        'to': fcmToken,
        'notification': {
          'title': notification.title,
          'body': notification.description,
          'sound': 'default',
          'badge': 1,
        },
        'data': {
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'id': notification.id,
          'status': 'done',
          'type': notification.type
        },
        'priority': 'high',
      }),
    );

    if (response.statusCode == 200) {
      print('Notification sent successfully');
    } else {
      print('Failed to send notification. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }
}
