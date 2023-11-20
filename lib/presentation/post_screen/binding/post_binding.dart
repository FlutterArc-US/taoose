import '../controller/post_controller.dart';
import 'package:get/get.dart';

/// A binding class for the PostScreen.
///
/// This class ensures that the PostController is created when the
/// PostScreen is first loaded.
class PostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PostController());
  }
}
