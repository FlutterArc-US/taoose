import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taousapp/notifications/domain/usecases/enable_notification_setting.dart';
import 'package:taousapp/util/di/di.dart';

final enableNotificationSettingProvider =
    FutureProvider.autoDispose((ref) async {
  final enableNotificationSettingUsecase =
      sl<EnableNotificationSettingUsecase>();
  await enableNotificationSettingUsecase(
    EnableNotificationSettingUsecaseInput(),
  );
});
