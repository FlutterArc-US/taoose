import 'package:injectable/injectable.dart';
import 'package:taousapp/helpers/image_picker_helper/image_picker_helper.dart';
import 'package:taousapp/infrastructure/usecase.dart';
import 'package:taousapp/infrastructure/usecase_input.dart';

@lazySingleton
class PickCameraImageUsecase implements Usecase<NoInput, String> {
  PickCameraImageUsecase({required ImagePickerHelper image}) : _image = image;
  final ImagePickerHelper _image;

  @override
  Future<String> call(NoInput imagePath) async {
    return _image.cameraImage();
  }
}
