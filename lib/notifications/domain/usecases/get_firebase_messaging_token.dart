import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import 'package:taousapp/infrastructure/usecase.dart';
import 'package:taousapp/infrastructure/usecase_input.dart';
import 'package:taousapp/infrastructure/usecase_output.dart';

class GetFCMTokenUsecaseInput extends Input {
  GetFCMTokenUsecaseInput();
}

class GetFirebaseMessagingTokenUsecaseOutput extends Output {
  GetFirebaseMessagingTokenUsecaseOutput({required this.fcmToken});

  final String fcmToken;
}

@lazySingleton
class GetFCMTokenUsecase extends Usecase<GetFCMTokenUsecaseInput,
    GetFirebaseMessagingTokenUsecaseOutput> {
  GetFCMTokenUsecase();

  @override
  Future<GetFirebaseMessagingTokenUsecaseOutput> call(
    GetFCMTokenUsecaseInput input,
  ) async {
    final messaging = FirebaseMessaging.instance;

    final fcmToken = await messaging.getToken();
    if (fcmToken == null) {
      throw 'No FcmToken';
    }
    return GetFirebaseMessagingTokenUsecaseOutput(fcmToken: fcmToken);
  }
}
