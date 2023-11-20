import '../controller/profile_controller_user.dart';
import 'package:get/get.dart';

/// A binding class for the ProfileScreen.
///
/// This class ensures that the ProfileControllerUser is created when the
/// ProfileScreen is first loaded.
class ProfileBindingUser extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileControllerUser());
  }
}
