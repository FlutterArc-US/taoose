import 'dart:developer';

import 'package:taousapp/infrastructure/usecase.dart';
import 'package:taousapp/infrastructure/usecase_input.dart';
import 'package:taousapp/infrastructure/usecase_output.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';

void onDidReceiveBackgroundNotificationResponse(
    NotificationResponse notificationResponse) {
  log("Listen notification on  background");
}

class InitializeLocalNotificationUsecaseInput extends Input {
  InitializeLocalNotificationUsecaseInput();
}

class InitializeLocalNotificationUsecaseOutput extends Output {
  InitializeLocalNotificationUsecaseOutput();
}

@lazySingleton
class InitializeLocalNotificationUsecase extends Usecase<
    InitializeLocalNotificationUsecaseInput,
    InitializeLocalNotificationUsecaseOutput> {
  ///[FlutterLocalNotificationsPlugin]
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  Future<InitializeLocalNotificationUsecaseOutput> call(
    InitializeLocalNotificationUsecaseInput input,
  ) async {
    await initializeLocalNotification();

    return InitializeLocalNotificationUsecaseOutput();
  }

  Future<void> initializeLocalNotification() async {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');

    /// Note: permissions aren't requested here just to demonstrate that can be
    /// done later
    const initializationSettingsDarwin = DarwinInitializationSettings();

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      macOS: initializationSettingsDarwin,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) {},
        onDidReceiveBackgroundNotificationResponse:
            onDidReceiveBackgroundNotificationResponse);
  }
}
