import '../../../core/app_export.dart';

/// This class is used in the [userprofile1_item_widget] screen.
class Userprofile1ItemModel {
  Userprofile1ItemModel({this.id}) {
    id = id ?? Rx("");
  }

  Rx<String>? id;
}
