import 'package:taousapp/core/app_export.dart';
import 'package:taousapp/presentation/sign_up_page/models/sign_up_model.dart';

/// A controller class for the SignUpPage.
///
/// This class manages the state of the SignUpPage, including the
/// current signUpModelObj
class SignUpController extends GetxController {
  SignUpController(this.signUpModelObj);

  Rx<SignUpModel> signUpModelObj;
}
