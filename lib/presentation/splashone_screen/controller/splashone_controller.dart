import 'package:firebase_auth/firebase_auth.dart';
import 'package:taousapp/core/app_export.dart';
import 'package:taousapp/presentation/splashone_screen/models/splashone_model.dart';

/// A controller class for the SplashoneScreen.
///
/// This class manages the state of the SplashoneScreen, including the
/// current splashoneModelObj
class SplashoneController extends GetxController {
  Rx<SplashoneModel> splashoneModelObj = SplashoneModel().obs;
  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(milliseconds: 3000), () async {
      print("going");
      if(FirebaseAuth.instance.currentUser != null)
      {
        Get.offNamedUntil(AppRoutes.homeScreen, (route) => false);  
      }
      else
      {
        Get.offNamedUntil(AppRoutes.logInScreen, (route) => false);
      }
    
    });
  }
   @override
  void onClose() {
    super.onClose();
  }
}

