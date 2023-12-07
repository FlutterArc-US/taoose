enum NotificationType {
  newMessage,
  comment,
  likeComment,
  likePost,
  followRequest,
  unFollow,
  acceptRequest,
  rejectRequest;

  String get name => switch (this) {
        NotificationType.newMessage => 'newMessage',
        NotificationType.comment => 'comment',
        NotificationType.likeComment => 'likeComment',
        NotificationType.likePost => 'likePost',
        NotificationType.followRequest => 'followRequest',
        NotificationType.unFollow => 'unFollow',
        NotificationType.acceptRequest => 'acceptRequest',
        NotificationType.rejectRequest => 'rejectRequest',
      };
}
