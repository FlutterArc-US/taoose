import 'package:taousapp/core/app_export.dart';
import 'package:taousapp/presentation/home_screen/controller/home_controller.dart';
import 'package:taousapp/presentation/settings_screen/models/settings_model.dart';

/// A controller class for the SettingsScreen.
///
/// This class manages the state of the SettingsScreen, including the
/// current settingsModelObj
class SettingsController extends GetxController {
  Rx<SettingsModel> settingsModelObj = SettingsModel().obs;

  Rx<bool> privacyPolicy = false.obs;

  Future<void> signOut() async {
    try {
      await HomeController().getCurrentUser().signOut();
      Get.offNamedUntil(AppRoutes.logInScreen, (route) => false);
    } catch (e) {}

    //Get.toNamed(AppRoutes.searchContainerScreen);
  }
}
