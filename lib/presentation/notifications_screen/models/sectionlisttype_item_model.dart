import '../../../core/app_export.dart';

/// This class is used in the [sectionlisttype_item_widget] screen.
class SectionlisttypeItemModel {
  SectionlisttypeItemModel({
    this.groupBy,
    this.id,
  }) {
    groupBy = groupBy ?? Rx("");
    id = id ?? Rx("");
  }

  Rx<String>? groupBy;

  Rx<String>? id;
}
