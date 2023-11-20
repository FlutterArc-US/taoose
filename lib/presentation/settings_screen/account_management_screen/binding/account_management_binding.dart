import '../controller/account_management_controller.dart';
import 'package:get/get.dart';

/// A binding class for the SettingsScreen.
///
/// This class ensures that the SettingsController is created when the
/// SettingsScreen is first loaded.
class AccountManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AccountManagementController());
  }
}
