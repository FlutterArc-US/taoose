import '../controller/frends_controller.dart';
import 'package:get/get.dart';

/// A binding class for the FrendsScreen.
///
/// This class ensures that the FrendsController is created when the
/// FrendsScreen is first loaded.
class FrendsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FrendsController());
  }
}
