// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RestNotificationEntityImpl _$$RestNotificationEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$RestNotificationEntityImpl(
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
      isNew: json['isNew'] as int,
      type: json['type'] as String,
      time: json['time'] as String,
      url: json['url'] as String?,
      highlight: json['highlight'] as String,
      hasReviewDone: json['hasReviewDone'] as bool?,
      sessionId: json['sessionId'] as int?,
    );

Map<String, dynamic> _$$RestNotificationEntityImplToJson(
        _$RestNotificationEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'isNew': instance.isNew,
      'type': instance.type,
      'time': instance.time,
      'url': instance.url,
      'highlight': instance.highlight,
      'hasReviewDone': instance.hasReviewDone,
      'sessionId': instance.sessionId,
    };
