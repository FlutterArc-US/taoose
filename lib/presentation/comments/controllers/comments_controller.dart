import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:taousapp/notifications/domain/models/notification/push_notification.dart';
import 'package:taousapp/notifications/domain/usecases/send_notificaiton.dart';
import 'package:taousapp/presentation/post_screen/models/comment_model.dart';
import 'package:taousapp/util/di/di.dart';

class CommentsController extends GetxController {
  var replyingTo = ''.obs;

  final sendNotificationUsecase = sl<SendNotificationUsecase>();

  Future<void> writeComment({
    required String postId,
    required String comment,
    required String myUserId,
    required String category,
    required String postOwnerUserId,
  }) async {
    FirebaseFirestore.instance
        .collection('userPosts')
        .doc(postOwnerUserId)
        .collection(category)
        .doc(postId)
        .update({
      'comments': FieldValue.increment(1),
    });
    final id = DateTime.now().millisecondsSinceEpoch.toString();

    FirebaseFirestore.instance
        .collection('userPosts')
        .doc(postOwnerUserId)
        .collection(category)
        .doc(postId)
        .collection('comments')
        .doc(id)
        .set(({
          "id": id,
          'commentedBy': myUserId,
          'time': DateTime.now().toString(),
          'comment': comment,
        }));

    if (myUserId != postOwnerUserId) {
      final input = SendNotificationUsecaseInput(
        userId: postOwnerUserId,
        notification: PushNotification(
          id: DateTime.now().millisecondsSinceEpoch,
          title: 'New Comment',
          description: comment,
        ),
      );

      await sendNotificationUsecase(input);
    }
  }

  Future<void> writeSubComment({
    required String postId,
    required String commentId,
    required String comment,
    required String myUserId,
    required String category,
    required String postOwnerId,
    required String commentOwnerId,
  }) async {
    FirebaseFirestore.instance
        .collection('userPosts')
        .doc(postOwnerId)
        .collection(category)
        .doc(postId)
        .update({
      'comments': FieldValue.increment(1),
    });
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    FirebaseFirestore.instance
        .collection('userPosts')
        .doc(postOwnerId)
        .collection(category)
        .doc(postId)
        .collection('comments')
        .doc(commentId)
        .collection('subComments')
        .doc(id)
        .set({
      "id": id,
      'commentedBy': myUserId,
      'time': DateTime.now().toString(),
      'comment': comment,
    });

    if (myUserId != commentOwnerId) {
      //TODO: Send Notification to other person

      final input = SendNotificationUsecaseInput(
        userId: commentOwnerId,
        notification: PushNotification(
          id: DateTime.now().millisecondsSinceEpoch,
          title: 'New Reply',
          description: comment,
        ),
      );

      await sendNotificationUsecase(input);
    }
  }

  Stream<List<CommentModel>> listenToComments({
    required String postOwnerId,
    required String postId,
    required String category,
  }) {
    return FirebaseFirestore.instance
        .collection('userPosts')
        .doc(postOwnerId)
        .collection(category)
        .doc(postId)
        .collection('comments')
        .snapshots()
        .map(
          (event) =>
              event.docs.map((e) => CommentModel.fromJson(e.data())).toList(),
        );
  }

  Stream<List<CommentModel>> listenToSubComments({
    required String postOwnerId,
    required String postId,
    required String category,
    required String commentId,
  }) {
    return FirebaseFirestore.instance
        .collection('userPosts')
        .doc(postOwnerId)
        .collection(category)
        .doc(postId)
        .collection('comments')
        .doc(commentId)
        .collection('subComments')
        .snapshots()
        .map(
          (event) =>
              event.docs.map((e) => CommentModel.fromJson(e.data())).toList(),
        );
  }
}
