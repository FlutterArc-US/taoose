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
    required this.toUserId,
    required this.notification,
  });

  final String toUserId;
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
    await sendFCMNotification(input.toUserId, input.notification);
    return SendNotificationUsecaseOutput();
  }

  Future<void> sendFCMNotification(
      String toUserId, PushNotification notification) async {
    final document = await FirebaseFirestore.instance
        .collection('TaousUser')
        .doc(toUserId)
        .get();

    if (!document.exists) {
      return;
    }
    final data = document.data();

    final currentUser = FirebaseAuth.instance.currentUser;

    var reference1 =
        FirebaseFirestore.instance.collection('TaousUser').doc(toUserId);

    reference1.update({
      'notifications': FieldValue.arrayUnion(
        [
          {
            'id': channel.id,
            'timestamp': DateTime.now(),
            'type': notification.type,
            'userId': currentUser?.uid.toString(),
            'notification': [
              notification.title,
              notification.description,
            ]
          }
        ],
      )
    });

    final fcmTokens =
        List<String>.from(data?['fcmTokens'] as List<dynamic>? ?? []);

    if (fcmTokens.isEmpty) {
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
        'registration_ids': fcmTokens,
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
