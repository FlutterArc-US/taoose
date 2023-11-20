import '../controller/sign_up_tab_container_controller.dart';
import 'package:get/get.dart';

/// A binding class for the SignUpTabContainerScreen.
///
/// This class ensures that the SignUpTabContainerController is created when the
/// SignUpTabContainerScreen is first loaded.
class SignUpTabContainerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpTabContainerController());
  }
}
