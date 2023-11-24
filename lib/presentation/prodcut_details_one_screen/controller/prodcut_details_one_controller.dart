import 'package:taousapp/core/app_export.dart';
import 'package:taousapp/presentation/home_screen/controller/home_controller.dart';
import 'package:taousapp/presentation/post_screen/controller/post_controller.dart';
import 'package:taousapp/presentation/prodcut_details_one_screen/models/prodcut_details_one_model.dart';

/// A controller class for the ProdcutDetailsOneScreen.
///
/// This class manages the state of the ProdcutDetailsOneScreen, including the
/// current prodcutDetailsOneModelObj
class ProdcutDetailsOneController extends GetxController {
  var hController = Get.find<HomeController>();
  var pController = Get.find<PostController>();
  Rx<ProdcutDetailsOneModel> prodcutDetailsOneModelObj =
      ProdcutDetailsOneModel().obs;

  var type;

  @override
  void onInit() {
    type = Get.arguments;
    super.onInit();
  }
}
