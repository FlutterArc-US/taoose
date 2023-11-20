// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../common/usecases/pick_camera_image_usecase.dart' as _i7;
import '../../common/usecases/pick_gallery_image_usecase.dart' as _i8;
import '../../common/usecases/pick_multi_images_usecase.dart' as _i9;
import '../../helpers/image_picker_helper/image_picker_helper.dart' as _i6;
import '../../presentation/chat_screen/data/source/chat_firebase_datasource.dart'
    as _i3;
import '../../presentation/chat_screen/data/source/chats_firebase_data_source_imp.dart'
    as _i4;
import '../../presentation/chat_screen/domain/usecases/create_message.dart'
    as _i5;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i3.ChatFirebaseDataSource>(
        () => _i4.ChatsFirebaseDataSourceImp());
    gh.lazySingleton<_i5.CreateMessageUsecase>(() => _i5.CreateMessageUsecase(
        chatFirebaseDataSource: gh<_i3.ChatFirebaseDataSource>()));
    gh.lazySingleton<_i6.ImagePickerHelper>(
        () => _i6.ImagePickerImagePickerHelper());
    gh.lazySingleton<_i7.PickCameraImageUsecase>(
        () => _i7.PickCameraImageUsecase(image: gh<_i6.ImagePickerHelper>()));
    gh.lazySingleton<_i8.PickGalleryImageUsecase>(
        () => _i8.PickGalleryImageUsecase(image: gh<_i6.ImagePickerHelper>()));
    gh.lazySingleton<_i9.PickMultiGalleryImagesUsecase>(() =>
        _i9.PickMultiGalleryImagesUsecase(image: gh<_i6.ImagePickerHelper>()));
    return this;
  }
}
