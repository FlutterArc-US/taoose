// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../common/usecases/pick_camera_image_usecase.dart' as _i24;
import '../../common/usecases/pick_gallery_image_usecase.dart' as _i25;
import '../../common/usecases/pick_multi_images_usecase.dart' as _i26;
import '../../core/utils/logger.dart' as _i21;
import '../../helpers/image_picker_helper/image_picker_helper.dart' as _i16;
import '../../notifications/data/repository/notifications_repository_imp.dart'
    as _i23;
import '../../notifications/data/source/remote/notifications_remote_datasource_imp.dart'
    as _i20;
import '../../notifications/domain/data/notifications_remote_datasource.dart'
    as _i19;
import '../../notifications/domain/repository/notifications_repository.dart'
    as _i22;
import '../../notifications/domain/usecases/enable_notification_setting.dart'
    as _i11;
import '../../notifications/domain/usecases/get_firebase_messaging_token.dart'
    as _i15;
import '../../notifications/domain/usecases/get_notifications.dart' as _i30;
import '../../notifications/domain/usecases/initialize_local_notification.dart'
    as _i17;
import '../../notifications/domain/usecases/send_notificaiton.dart' as _i27;
import '../../notifications/domain/usecases/show_local_notification.dart'
    as _i28;
import '../../notifications/domain/usecases/update_fcm_token.dart' as _i29;
import '../../presentation/chat_screen/data/source/chat_firebase_datasource.dart'
    as _i3;
import '../../presentation/chat_screen/data/source/chats_firebase_data_source_imp.dart'
    as _i4;
import '../../presentation/chat_screen/domain/repository/chat_repository.dart'
    as _i5;
import '../../presentation/chat_screen/domain/repository/chat_repository_imp.dart'
    as _i6;
import '../../presentation/chat_screen/domain/usecases/create_chat.dart' as _i7;
import '../../presentation/chat_screen/domain/usecases/create_message.dart'
    as _i8;
import '../../presentation/chat_screen/domain/usecases/delete_chat.dart' as _i9;
import '../../presentation/chat_screen/domain/usecases/delete_message.dart'
    as _i10;
import '../../presentation/chat_screen/domain/usecases/get_all_chats.dart'
    as _i12;
import '../../presentation/chat_screen/domain/usecases/get_all_messages.dart'
    as _i13;
import '../../presentation/chat_screen/domain/usecases/get_chat_id_for_users.dart'
    as _i14;
import '../../presentation/chat_screen/domain/usecases/update_unread_messages_usecase.dart'
    as _i18;

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
    gh.lazySingleton<_i5.ChatRepository>(() => _i6.ChatsRepositoryImp(
          chatsFirebaseDataSource: gh<_i3.ChatFirebaseDataSource>(),
          chatFirebaseDataSource: gh<_i3.ChatFirebaseDataSource>(),
        ));
    gh.lazySingleton<_i7.CreateChatUsecase>(
        () => _i7.CreateChatUsecase(chatsRepository: gh<_i5.ChatRepository>()));
    gh.lazySingleton<_i8.CreateMessageUsecase>(() => _i8.CreateMessageUsecase(
        chatFirebaseDataSource: gh<_i3.ChatFirebaseDataSource>()));
    gh.lazySingleton<_i9.DeleteChatUsecase>(
        () => _i9.DeleteChatUsecase(chatsRepository: gh<_i5.ChatRepository>()));
    gh.lazySingleton<_i10.DeleteMessageUsecase>(() =>
        _i10.DeleteMessageUsecase(chatsRepository: gh<_i5.ChatRepository>()));
    gh.lazySingleton<_i11.EnableNotificationSettingUsecase>(
        () => _i11.EnableNotificationSettingUsecase());
    gh.lazySingleton<_i12.GetAllChatsUsecase>(() =>
        _i12.GetAllChatsUsecase(chatsRepository: gh<_i5.ChatRepository>()));
    gh.lazySingleton<_i13.GetAllMessagesUsecase>(() =>
        _i13.GetAllMessagesUsecase(chatsRepository: gh<_i5.ChatRepository>()));
    gh.lazySingleton<_i14.GetChatIdForUsersUsecase>(() =>
        _i14.GetChatIdForUsersUsecase(
            chatRepository: gh<_i5.ChatRepository>()));
    gh.lazySingleton<_i15.GetFCMTokenUsecase>(() => _i15.GetFCMTokenUsecase());
    gh.lazySingleton<_i16.ImagePickerHelper>(
        () => _i16.ImagePickerImagePickerHelper());
    gh.lazySingleton<_i17.InitializeLocalNotificationUsecase>(
        () => _i17.InitializeLocalNotificationUsecase());
    gh.lazySingleton<_i18.MarkReadMessagesUsecase>(() =>
        _i18.MarkReadMessagesUsecase(
            chatsRepository: gh<_i5.ChatRepository>()));
    gh.lazySingleton<_i19.NotificationsRemoteDataSource>(
        () => _i20.NotificationsRemoteDataSourceImp(logger: gh<_i21.Logger>()));
    gh.lazySingleton<_i22.NotificationsRepository>(() =>
        _i23.NotificationsRepositoryImp(
            firebaseMessagingRemoteDataSource:
                gh<_i19.NotificationsRemoteDataSource>()));
    gh.lazySingleton<_i24.PickCameraImageUsecase>(
        () => _i24.PickCameraImageUsecase(image: gh<_i16.ImagePickerHelper>()));
    gh.lazySingleton<_i25.PickGalleryImageUsecase>(() =>
        _i25.PickGalleryImageUsecase(image: gh<_i16.ImagePickerHelper>()));
    gh.lazySingleton<_i26.PickMultiGalleryImagesUsecase>(() =>
        _i26.PickMultiGalleryImagesUsecase(
            image: gh<_i16.ImagePickerHelper>()));
    gh.lazySingleton<_i27.SendNotificationUsecase>(
        () => _i27.SendNotificationUsecase());
    gh.lazySingleton<_i28.ShowLocalNotificationUsecase>(
        () => _i28.ShowLocalNotificationUsecase());
    gh.lazySingleton<_i29.UpdateFcmTokenUsecase>(() =>
        _i29.UpdateFcmTokenUsecase(
            firebaseMessagingRepository: gh<_i22.NotificationsRepository>()));
    gh.lazySingleton<_i30.GetNotificationsUsecase>(() =>
        _i30.GetNotificationsUsecase(
            firebaseMessagingRepository: gh<_i22.NotificationsRepository>()));
    return this;
  }
}
