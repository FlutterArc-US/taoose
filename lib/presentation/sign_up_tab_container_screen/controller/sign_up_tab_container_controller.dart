import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:taousapp/core/app_export.dart';
import 'package:taousapp/presentation/sign_up_tab_container_screen/models/sign_up_tab_container_model.dart';
import 'package:flutter/material.dart';

/// A controller class for the SignUpTabContainerScreen.
///
/// This class manages the state of the SignUpTabContainerScreen, including the
/// current signUpTabContainerModelObj
class SignUpTabContainerController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  RxString phoneNo = "".obs;

  TextEditingController fullNameController = TextEditingController();

  TextEditingController userNameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmpasswordController = TextEditingController();

  Rx<SignUpTabContainerModel> signUpTabContainerModelObj =
      SignUpTabContainerModel().obs;

  late TabController tabviewController =
      Get.put(TabController(vsync: this, length: 3));

  Rx<SignUpTabContainerModel> createAccountModelObj =
      SignUpTabContainerModel().obs;

  RxBool inLoading = false.obs;
  Rx<bool> isShowPassword = true.obs;
  RxInt selGender = 0.obs;

  var selectedGender = "male".obs;

  void changeGender(String gender) {
    selectedGender.value = gender;
  }

  final formKey = GlobalKey<FormState>();
  final passwordRegex =
      RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[^\w\d\s]).{8,}$');
  final phoneRegex = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
  RegExp fullNameRegExp = RegExp(r'^[a-zA-Z ]+$');

  validateFullName(String? fullname) {
    if (!fullNameRegExp.hasMatch(fullname!)) {
      return 'Full name is valid.';
    }
    return null;
  }

  validateUserName(String? username) {
    if (!GetUtils.isUsername(username ?? '')) {
      return 'Username is not valid';
    }
    return null;
  }

  validatePhoneNo(String? phoneno) {
    if (phoneno!.isEmpty) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  validateEmail(String? email) {
    if (!GetUtils.isEmail(email ?? '')) {
      return 'Email is not valid';
    }
    return null;
  }

  validatePasswprd(String? pwd) {
    // ignore: unnecessary_null_comparison
    if (!passwordRegex.hasMatch(pwd!)) {
      return 'Password is not valid';
    }
    return null;
  }

  Future onSignup() async {
    if (formKey.currentState!.validate()) {
      Get.snackbar("Success", 'Sign up Successful',
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: Colors.red);
      return;
    }
    Get.snackbar("Error", 'Sign up validation failed',
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.red);
  }

  late FocusNode fullNameNode;
  late FocusNode usernameNode;
  late FocusNode phoneNode;
  late FocusNode emailNode;
  late FocusNode passwordNode;
  late FocusNode cpasswordNode;

  @override
  void onInit() {
    super.onInit();
    fullNameNode = FocusNode();
    usernameNode = FocusNode();
    phoneNode = FocusNode();
    emailNode = FocusNode();
    passwordNode = FocusNode();
    cpasswordNode = FocusNode();
  }

  @override
  void onClose() {
    super.onClose();

    fullNameController.dispose();
    userNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();
  }
}
