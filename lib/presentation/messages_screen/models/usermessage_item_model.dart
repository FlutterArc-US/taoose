import '../../../core/app_export.dart';

/// This class is used in the [usermessage_item_widget] screen.
class UsermessageItemModel {
  UsermessageItemModel({
    this.userName,
    this.messageTime,
    this.messageText,
    this.messageIndicato,
    this.id,
  }) {
    userName = userName ?? Rx("Emelie");
    messageTime = messageTime ?? Rx("23 min");
    messageText = messageText ?? Rx("Sticker 😍");
    messageIndicato = messageIndicato ?? Rx("1");
    id = id ?? Rx("");
  }

  Rx<String>? userName;

  Rx<String>? messageTime;

  Rx<String>? messageText;

  Rx<String>? messageIndicato;

  Rx<String>? id;
}
