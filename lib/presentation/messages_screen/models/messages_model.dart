import '../../../core/app_export.dart';
import 'usermessage_item_model.dart';

/// This class defines the variables used in the [messages_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class MessagesModel {
  Rx<List<UsermessageItemModel>> usermessageItemList =
      Rx(List.generate(8, (index) => UsermessageItemModel()));
}
