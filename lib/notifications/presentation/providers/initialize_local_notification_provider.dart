import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taousapp/notifications/domain/usecases/initialize_local_notification.dart';
import 'package:taousapp/util/di/di.dart';

final initializeLocalNotificationProvider =
    FutureProvider.autoDispose((ref) async {
  final initializeLocalNotificationUsecase =
      sl<InitializeLocalNotificationUsecase>();

  await initializeLocalNotificationUsecase(
    InitializeLocalNotificationUsecaseInput(),
  );
});
