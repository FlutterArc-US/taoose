import '../../../core/app_export.dart';
import 'sectionlisttype_item_model.dart';

/// This class defines the variables used in the [notifications_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class NotificationsModel {
  Rx<List<SectionlisttypeItemModel>> sectionlisttypeItemList = Rx([
    SectionlisttypeItemModel(groupBy: "Today".obs),
    SectionlisttypeItemModel(groupBy: "Today".obs),
    SectionlisttypeItemModel(groupBy: "Today".obs),
    SectionlisttypeItemModel(groupBy: "Yesterday".obs),
    SectionlisttypeItemModel(groupBy: "Yesterday".obs),
    SectionlisttypeItemModel(groupBy: "Yesterday".obs)
  ]);
}
