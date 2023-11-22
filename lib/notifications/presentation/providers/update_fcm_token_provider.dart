import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taousapp/notifications/domain/usecases/update_fcm_token.dart';
import 'package:taousapp/notifications/presentation/providers/get_fcm_token_provider.dart';
import 'package:taousapp/util/di/di.dart';

final updateFCMTokenProvider = FutureProvider.autoDispose((ref) async {
  final fcmToken = await ref.read(getFCMTokenProvider.future);
  final updateFcmTokenUsecase = sl<UpdateFcmTokenUsecase>();
  final input = UpdateFcmTokenUsecaseInput(
    fcmToken: fcmToken,
    token: '',
  );
  await updateFcmTokenUsecase(input);
});
