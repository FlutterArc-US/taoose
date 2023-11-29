/// This class defines the variables used in the [chat_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class MessageModel {
  MessageModel({
    required this.id,
    required this.members,
    required this.timestamp,
    required this.idTo,
    required this.idFrom,
    required this.status,
    required this.type,
  });

  factory MessageModel.fromJson(Map<String, Object?> json) {
    return MessageModel(
      id: (json['id'] ?? "") as String,
      members: List<String>.from(json['members'] as List<dynamic>),
      timestamp: (json['timestamp']!).toString(),
      idTo: json['idTo'] as String,
      idFrom: json['idFrom'] as String,
      status: json['status'] as int,
      type: json['type'] as int,
    );
  }

  final String id;

  final String idFrom;

  final String idTo;
  final List<String> members;

  final int status;

  final String timestamp;
  final int type;
}
