import 'package:taousapp/infrastructure/usecase.dart';
import 'package:taousapp/infrastructure/usecase_input.dart';
import 'package:taousapp/infrastructure/usecase_output.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';

class ShowLocalNotificationUsecaseInput extends Input {
  ShowLocalNotificationUsecaseInput({
    required this.title,
    required this.body,
    required this.id,
  });

  final String title;
  final String body;
  final int id;
}

class ShowLocalNotificationUsecaseOutput extends Output {
  ShowLocalNotificationUsecaseOutput();
}

@lazySingleton
class ShowLocalNotificationUsecase extends Usecase<
    ShowLocalNotificationUsecaseInput, ShowLocalNotificationUsecaseOutput> {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  Future<ShowLocalNotificationUsecaseOutput> call(
    ShowLocalNotificationUsecaseInput input,
  ) async {
    await showLocalNotification(input);
    return ShowLocalNotificationUsecaseOutput();
  }

  Future<void> showLocalNotification(
    ShowLocalNotificationUsecaseInput input,
  ) async {
    const androidNotificationDetails = AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
    );

    const iosNotificationDetails = DarwinNotificationDetails();
    const notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      input.id,
      input.title,
      input.body,
      notificationDetails,
    );
  }
}
