import 'package:taousapp/core/app_export.dart';
import 'package:taousapp/presentation/reel_screen/models/reel_model.dart';

/// A controller class for the ReelScreen.
///
/// This class manages the state of the ReelScreen, including the
/// current reelModelObj
class ReelController extends GetxController {
  Rx<ReelModel> reelModelObj = ReelModel().obs;
}
