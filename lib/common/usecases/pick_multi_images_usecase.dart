import 'package:injectable/injectable.dart';
import 'package:taousapp/helpers/image_picker_helper/image_picker_helper.dart';
import 'package:taousapp/infrastructure/usecase.dart';
import 'package:taousapp/infrastructure/usecase_input.dart';

@lazySingleton
class PickMultiGalleryImagesUsecase implements Usecase<NoInput, List<String>> {
  PickMultiGalleryImagesUsecase({required ImagePickerHelper image})
      : _image = image;
  final ImagePickerHelper _image;

  @override
  Future<List<String>> call(NoInput input) async {
    return _image.multiGalleryImages();
  }
}
