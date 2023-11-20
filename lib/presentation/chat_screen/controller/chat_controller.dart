import 'package:taousapp/core/app_export.dart';
import 'package:taousapp/presentation/chat_screen/models/chat_model.dart';

/// A controller class for the ChatScreen.
///
/// This class manages the state of the ChatScreen, including the
/// current chatModelObj
class ChatController extends GetxController {
  RxInt unread = 0.obs;
  Rx<ChatModel> chatModelObj = ChatModel().obs;
}
