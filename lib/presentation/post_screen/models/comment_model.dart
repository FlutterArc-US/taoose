class CommentModel {
  final String id;
  final String commentedBy;
  final String comment;
  final String time;

  final List<String>? likedBy;

  CommentModel({
    required this.id,
    required this.comment,
    required this.time,
    required this.commentedBy,
    this.likedBy,
  });

  static CommentModel fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json["id"],
      comment: json['comment'],
      time: json['time'],
      commentedBy: json['commentedBy'],
      likedBy: List.from(json['likedBy'] ?? []),
    );
  }
}
