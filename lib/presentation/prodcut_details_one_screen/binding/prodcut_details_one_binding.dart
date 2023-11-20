import '../controller/prodcut_details_one_controller.dart';
import 'package:get/get.dart';

/// A binding class for the ProdcutDetailsOneScreen.
///
/// This class ensures that the ProdcutDetailsOneController is created when the
/// ProdcutDetailsOneScreen is first loaded.
class ProdcutDetailsOneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProdcutDetailsOneController());
  }
}
