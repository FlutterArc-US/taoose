abstract class NotificationEntity {
  NotificationEntity({
    required this.id,
    required this.title,
    required this.body,
    required this.isNew,
    required this.type,
    required this.time,
    required this.highlight,
    this.url,
    this.hasReviewDone,
    this.sessionId,
  });

  final int id;
  final String title;
  final String body;
  final int isNew;
  final String type;
  final String time;
  final String? url;
  final String highlight;
  final int? sessionId;
  final bool? hasReviewDone;
}
