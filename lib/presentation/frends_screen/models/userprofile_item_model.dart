import '../../../core/app_export.dart';

/// This class is used in the [userprofile_item_widget] screen.
class UserprofileItemModel {
  UserprofileItemModel({
    this.userName,
    this.userMessage,
    this.id,
  }) {
    userName = userName ?? Rx("Emelie Williams");
    userMessage = userMessage ?? Rx("@emelie");
    id = id ?? Rx("");
  }

  Rx<String>? userName;

  Rx<String>? userMessage;

  Rx<String>? id;
}
