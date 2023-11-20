import '../../../core/app_export.dart';
import 'userprofile1_item_model.dart';
import 'userprofile2_item_model.dart';

/// This class defines the variables used in the [prodcut_details_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class ProdcutDetailsModel {
  Rx<List<Userprofile1ItemModel>> userprofile1ItemList =
      Rx(List.generate(2, (index) => Userprofile1ItemModel()));

  Rx<List<Userprofile2ItemModel>> userprofile2ItemList =
      Rx(List.generate(3, (index) => Userprofile2ItemModel()));
}
