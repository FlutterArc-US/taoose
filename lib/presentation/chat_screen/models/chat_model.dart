/// This class defines the variables used in the [chat_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class ChatModel {
  ChatModel({
    required this.id,
    required this.members,
    required this.timestamp,
    this.unReadMsgCount,
    this.message,
    this.user,
    this.typing,
  });

  factory ChatModel.fromJson(Map<String, Object?> json) {
    return ChatModel(
      id: (json['id'] ?? "") as String,
      members: List<String>.from(json['members'] as List<dynamic>),
      timestamp: (json['timestamp']!).toString(),
      message: json['message'] as Map<String, dynamic>?,
      typing: List<String>.from((json?['members'] as List<dynamic>?) ?? []),
    );
  }

  final String id;
  final List<String> members;
  final List<String>? typing;

  final String timestamp;
  final int? unReadMsgCount;
  final Map<String, dynamic>? message;
  final Map<String, dynamic>? user;

  ChatModel copyWith({
    String? id,
    List<String>? availableFor,
    List<String>? members,
    String? timestamp,
    int? unReadMsgCount,
    Map<String, dynamic>? message,
    Map<String, dynamic>? user,
  }) {
    return ChatModel(
      id: id ?? this.id,
      members: members ?? this.members,
      timestamp: timestamp ?? this.timestamp,
      unReadMsgCount: unReadMsgCount ?? this.unReadMsgCount,
      message: message ?? this.message,
      user: user ?? this.user,
    );
  }
}
