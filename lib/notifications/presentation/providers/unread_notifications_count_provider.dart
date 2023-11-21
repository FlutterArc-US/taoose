import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taousapp/notifications/domain/usecases/get_unread_notifications_count.dart';
import 'package:taousapp/util/di/di.dart';

final unreadNotificationsCountProvider =
    FutureProvider.autoDispose<int>((ref) async {
  final getUnreadNotificationsCountUsecase =
      sl<GetUnreadNotificationsCountUsecase>();
  final input = GetUnreadNotificationsCountUsecaseInput(
    authToken: '',
  );
  final output = await getUnreadNotificationsCountUsecase(input);
  return output.unreadCount;
});
