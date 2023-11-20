class CommentModel {
  final String commentedBy;
  final String comment;
  final String time;

  CommentModel({
    required this.comment,
    required this.time,
    required this.commentedBy,
  });

  static CommentModel fromJson(Map<String, dynamic> json) {
    return CommentModel(
      comment: json['comment'],
      time: json['time'],
      commentedBy: json['commentedBy'],
    );
  }
}
