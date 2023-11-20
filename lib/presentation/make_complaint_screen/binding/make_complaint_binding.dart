import '../controller/make_complaint_controller.dart';
import 'package:get/get.dart';

/// A binding class for the MakeComplaintScreen.
///
/// This class ensures that the MakeComplaintController is created when the
/// MakeComplaintScreen is first loaded.
class MakeComplaintBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MakeComplaintController());
  }
}
