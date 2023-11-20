import '../controller/splashone_controller.dart';
import 'package:get/get.dart';

/// A binding class for the SplashoneScreen.
///
/// This class ensures that the SplashoneController is created when the
/// SplashoneScreen is first loaded.
class SplashoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashoneController());
  }
}
