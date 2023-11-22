import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taousapp/notifications/domain/usecases/get_firebase_messaging_token.dart';
import 'package:taousapp/util/di/di.dart';

final getFCMTokenProvider = FutureProvider.autoDispose((ref) async {
  final getFCMTokenUsecase = sl<GetFCMTokenUsecase>();
  final output = await getFCMTokenUsecase(GetFCMTokenUsecaseInput());
  return output.fcmToken;
});
