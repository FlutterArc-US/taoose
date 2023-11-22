// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../common/usecases/pick_camera_image_usecase.dart' as _i15;
import '../../common/usecases/pick_gallery_image_usecase.dart' as _i16;
import '../../common/usecases/pick_multi_images_usecase.dart' as _i17;
import '../../core/utils/logger.dart' as _i12;
import '../../helpers/image_picker_helper/image_picker_helper.dart' as _i8;
import '../../notifications/data/repository/notifications_repository_imp.dart'
    as _i14;
import '../../notifications/data/source/remote/notifications_remote_datasource_imp.dart'
    as _i11;
import '../../notifications/domain/data/notifications_remote_datasource.dart'
    as _i10;
import '../../notifications/domain/repository/notifications_repository.dart'
    as _i13;
import '../../notifications/domain/usecases/enable_notification_setting.dart'
    as _i6;
import '../../notifications/domain/usecases/get_firebase_messaging_token.dart'
    as _i7;
import '../../notifications/domain/usecases/get_notifications.dart' as _i21;
import '../../notifications/domain/usecases/initialize_local_notification.dart'
    as _i9;
import '../../notifications/domain/usecases/send_notificaiton.dart' as _i18;
import '../../notifications/domain/usecases/show_local_notification.dart'
    as _i19;
import '../../notifications/domain/usecases/update_fcm_token.dart' as _i20;
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
    gh.lazySingleton<_i6.EnableNotificationSettingUsecase>(
        () => _i6.EnableNotificationSettingUsecase());
    gh.lazySingleton<_i7.GetFCMTokenUsecase>(() => _i7.GetFCMTokenUsecase());
    gh.lazySingleton<_i8.ImagePickerHelper>(
        () => _i8.ImagePickerImagePickerHelper());
    gh.lazySingleton<_i9.InitializeLocalNotificationUsecase>(
        () => _i9.InitializeLocalNotificationUsecase());
    gh.lazySingleton<_i10.NotificationsRemoteDataSource>(
        () => _i11.NotificationsRemoteDataSourceImp(logger: gh<_i12.Logger>()));
    gh.lazySingleton<_i13.NotificationsRepository>(() =>
        _i14.NotificationsRepositoryImp(
            firebaseMessagingRemoteDataSource:
                gh<_i10.NotificationsRemoteDataSource>()));
    gh.lazySingleton<_i15.PickCameraImageUsecase>(
        () => _i15.PickCameraImageUsecase(image: gh<_i8.ImagePickerHelper>()));
    gh.lazySingleton<_i16.PickGalleryImageUsecase>(
        () => _i16.PickGalleryImageUsecase(image: gh<_i8.ImagePickerHelper>()));
    gh.lazySingleton<_i17.PickMultiGalleryImagesUsecase>(() =>
        _i17.PickMultiGalleryImagesUsecase(image: gh<_i8.ImagePickerHelper>()));
    gh.lazySingleton<_i18.SendNotificationUsecase>(
        () => _i18.SendNotificationUsecase());
    gh.lazySingleton<_i19.ShowLocalNotificationUsecase>(
        () => _i19.ShowLocalNotificationUsecase());
    gh.lazySingleton<_i20.UpdateFcmTokenUsecase>(() =>
        _i20.UpdateFcmTokenUsecase(
            firebaseMessagingRepository: gh<_i13.NotificationsRepository>()));
    gh.lazySingleton<_i21.GetNotificationsUsecase>(() =>
        _i21.GetNotificationsUsecase(
            firebaseMessagingRepository: gh<_i13.NotificationsRepository>()));
    return this;
  }
}
