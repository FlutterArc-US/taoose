import 'package:taousapp/core/app_export.dart';
import 'package:taousapp/presentation/make_complaint_screen/models/make_complaint_model.dart';
import 'package:flutter/material.dart';

/// A controller class for the MakeComplaintScreen.
///
/// This class manages the state of the MakeComplaintScreen, including the
/// current makeComplaintModelObj
class MakeComplaintController extends GetxController {
  TextEditingController enterherreoneController = TextEditingController();

  TextEditingController enterherreController = TextEditingController();

  Rx<MakeComplaintModel> makeComplaintModelObj = MakeComplaintModel().obs;

  @override
  void onClose() {
    super.onClose();
    enterherreoneController.dispose();
    enterherreController.dispose();
  }
}
