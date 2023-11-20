import '../controller/prodcut_details_controller.dart';
import 'package:get/get.dart';

/// A binding class for the ProdcutDetailsScreen.
///
/// This class ensures that the ProdcutDetailsController is created when the
/// ProdcutDetailsScreen is first loaded.
class ProdcutDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProdcutDetailsController());
  }
}
