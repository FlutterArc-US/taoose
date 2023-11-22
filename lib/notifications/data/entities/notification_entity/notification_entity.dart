import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:taousapp/notifications/domain/models/notification/entity.dart';

part 'notification_entity.freezed.dart';

part 'notification_entity.g.dart';

@freezed
class RestNotificationEntity
    with _$RestNotificationEntity
    implements NotificationEntity {
  const factory RestNotificationEntity({
    required int id,
    required String title,
    required String body,
    required int isNew,
    required String type,
    required String time,
    required String? url,
    required String highlight,
    required bool? hasReviewDone,
    required int? sessionId,
  }) = _RestNotificationEntity;

  factory RestNotificationEntity.fromJson(Map<String, dynamic> json) =>
      _$RestNotificationEntityFromJson(json);
}
