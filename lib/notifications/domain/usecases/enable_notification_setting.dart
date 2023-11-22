import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import 'package:taousapp/infrastructure/usecase.dart';
import 'package:taousapp/infrastructure/usecase_input.dart';
import 'package:taousapp/infrastructure/usecase_output.dart';

class EnableNotificationSettingUsecaseInput extends Input {
  EnableNotificationSettingUsecaseInput();
}

class EnableNotificationSettingUsecaseOutput extends Output {
  EnableNotificationSettingUsecaseOutput();
}

@lazySingleton
class EnableNotificationSettingUsecase extends Usecase<
    EnableNotificationSettingUsecaseInput,
    EnableNotificationSettingUsecaseOutput> {
  @override
  Future<EnableNotificationSettingUsecaseOutput> call(
    EnableNotificationSettingUsecaseInput input,
  ) async {
    final messaging = FirebaseMessaging.instance;
    await messaging.requestPermission();

    return EnableNotificationSettingUsecaseOutput();
  }
}
