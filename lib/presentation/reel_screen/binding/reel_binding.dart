import '../controller/reel_controller.dart';
import 'package:get/get.dart';

/// A binding class for the ReelScreen.
///
/// This class ensures that the ReelController is created when the
/// ReelScreen is first loaded.
class ReelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReelController());
  }
}
