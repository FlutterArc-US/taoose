import 'package:taousapp/core/app_export.dart';

import '../models/account_management_model.dart';

/// A controller class for the SettingsScreen.
///
/// This class manages the state of the SettingsScreen, including the
/// current settingsModelObj
class AccountManagementController extends GetxController {
  Rx<AccountManagementModel> accountManagementModelObj =
      AccountManagementModel().obs;
}
