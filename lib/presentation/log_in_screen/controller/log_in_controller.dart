import 'package:taousapp/core/app_export.dart';
import 'package:taousapp/presentation/log_in_screen/models/log_in_model.dart';
import 'package:flutter/material.dart';

/// A controller class for the LogInScreen.
///
/// This class manages the state of the LogInScreen, including the
/// current logInModelObj
class LogInController extends GetxController {
  TextEditingController lemailController = TextEditingController();
  TextEditingController lpasswordController = TextEditingController();

  Rx<LogInModel> logInModelObj = LogInModel().obs;
  Rx<bool> isShowPassword = true.obs;
  Rx<bool> englishName = false.obs;
  late FocusNode emailNode;
  late FocusNode passwordNode;
  RxBool inLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    emailNode = FocusNode();
    passwordNode = FocusNode();
  }

  @override
  void onClose() {
    super.onClose();
    emailNode.dispose();
    passwordNode.dispose();
    lemailController.dispose();
    lpasswordController.dispose();
  }
}
