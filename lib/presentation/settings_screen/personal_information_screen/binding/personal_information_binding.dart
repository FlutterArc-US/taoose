import '../controller/personal_information_controller.dart';
import 'package:get/get.dart';

/// A binding class for the SettingsScreen.
///
/// This class ensures that the SettingsController is created when the
/// SettingsScreen is first loaded.
class PersonalInformationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PersonalInformationController());
  }
}
