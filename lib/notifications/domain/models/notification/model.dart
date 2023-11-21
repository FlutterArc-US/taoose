import 'package:taousapp/notifications/domain/models/notification/entity.dart';

class NotificationModel {
  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.highlight,
    required this.time,
    required this.type,
    required this.isNew,
    this.url,
    this.hasReviewDone,
    this.sessionId,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
      url: json['url'] as String?,
      isNew: json['isNew'] as int,
      time: json['time'] as String,
      type: json['type'] as String,
      highlight: json['highlight'] as String,
      sessionId: json['sessionId'] as int,
      hasReviewDone: json['hasReviewDone'] as bool,
    );
  }

  factory NotificationModel.fromEntity(NotificationEntity entity) {
    return NotificationModel(
      id: entity.id,
      title: entity.title,
      body: entity.body,
      isNew: entity.isNew,
      type: entity.type,
      time: entity.time,
      url: entity.url,
      highlight: entity.highlight,
      sessionId: entity.sessionId,
      hasReviewDone: entity.hasReviewDone,
    );
  }

  final int id;
  final String title;
  final String body;
  final String type;
  final int isNew;
  final String time;
  final String? url;
  final String highlight;
  final bool? hasReviewDone;
  final int? sessionId;
}
