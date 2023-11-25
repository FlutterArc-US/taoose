import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:taousapp/core/app_export.dart';
import 'package:taousapp/notifications/domain/models/notification/push_notification.dart';
import 'package:taousapp/notifications/domain/usecases/send_notificaiton.dart';
import 'package:taousapp/presentation/frends_screen/controller/frends_controller.dart';
import 'package:taousapp/presentation/home_screen/controller/home_controller.dart';
import 'package:taousapp/presentation/profile_screen_user/models/profile_model_user.dart';
import 'package:taousapp/util/di/di.dart';

/// A controller class for the ProfileScreen.
///
/// This class manages the state of the ProfileScreen, including the
/// current profileModelObj
class ProfileControllerUser extends GetxController {
  var hController = Get.find<HomeController>();
  var fController = Get.find<FrendsController>();
  RxBool locked = true.obs;
  RxBool following = false.obs;
  RxBool private = true.obs;
  RxBool requested = false.obs;
  Rx<ProfileModelUser> profileModelUserObj = ProfileModelUser().obs;
  var docFetch = FirebaseFirestore.instance.collection("TaousUser");
  RxList posts = [].obs;
  RxList bottomPosts = [].obs;
  RxList shoePosts = [].obs;
  // ignore: prefer_typing_uninitialized_variables
  var data;
  setData(dataa) async {
    var doc = docFetch.doc(dataa['uid']);
    var fetched = await doc.get();
    if (fetched.exists) {
      data = fetched.data();
      if (data?["accountType"] == 1) {
        private.value = true;
        locked.value = true;
      } else {
        private.value = false;
        locked.value = false;
      }
      if (data?['requests'].contains(hController.getUid().toString())) {
        requested.value = true;
      }
    }
  }

  checkFollowing(dataa) async {
    if (kDebugMode) {
      print('checking');
    }
    if (dataa?['followers'].contains(hController.getUid().toString())) {
      if (kDebugMode) {
        print('following this account');
      }
      private.value = false;
      locked.value = false;
      following.value = true;
      checkNewPosts(dataa);
      return true;
    } else {
      if (kDebugMode) {
        print('not following this account');
      }
      following.value = false;
      return false;
    }
  }

  follow(uid) async {
    try {
      if (uid['accountType'] == 1) {
        await docFetch.doc(uid['uid']).update({
          'requests': FieldValue.arrayUnion([hController.getUid().toString()]),
        });
        requested.value = true;
        sendNotificationToUser(
          followUserId: uid['uid'],
          title: 'Follow Request',
          description: '${hController.getName()} has requested to follow you',
        );
      } else {
        await docFetch.doc(uid['uid']).update({
          'followers': FieldValue.arrayUnion([hController.getUid().toString()]),
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }

  unfollowUser(uid) async {
    try {
      await docFetch.doc(uid['uid']).update({
        'followers': FieldValue.arrayRemove([hController.getUid().toString()]),
      }).then((value) {
        docFetch.doc(hController.getUid().toString()).update({
          'following': FieldValue.arrayRemove([uid['uid'].toString()])
        });

        sendNotificationToUser(
          followUserId: uid['uid'],
          title: 'UnFollow',
          description: '${hController.getName()} has unfollow you',
        );
      });
      following.value = false;
      setData(uid);
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }

  cancelFollow(uid) async {
    try {
      await docFetch.doc(uid['uid']).update({
        'requests': FieldValue.arrayRemove([hController.getUid().toString()]),
      });
      requested.value = false;

      sendNotificationToUser(
          followUserId: uid['uid'],
          title: "Reject Request",
          description: '${hController.getName()} has reject your request');
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }

  getBottomPosts(dataa) async {
    var reference = FirebaseFirestore.instance
        .collection("userPosts")
        .doc(dataa['uid'].toString())
        .collection('two');
    var docsn = await reference.get();
    bottomPosts.value = docsn.docs.map((doc) => doc.data()).toList();
    print(bottomPosts.value);
    return;
  }

  getShoePosts(dataa) async {
    var reference = FirebaseFirestore.instance
        .collection("userPosts")
        .doc(dataa['uid'].toString())
        .collection('three');
    var docsn = await reference.get();
    shoePosts.value = docsn.docs.map((doc) => doc.data()).toList();
    print(shoePosts.value);
    return;
  }

  getPosts(dataa) async {
    var reference = FirebaseFirestore.instance
        .collection("userPosts")
        .doc(dataa['uid'].toString())
        .collection('one');
    var docsn = await reference.get();
    posts.value = docsn.docs.map((doc) => doc.data()).toList();
    print(posts.value);
    return;
  }

  checkNewPosts(dataa) async {
    getPosts(dataa);
    getBottomPosts(dataa);
    getShoePosts(dataa);
  }

  final sendNotificationUsecase = sl<SendNotificationUsecase>();

  Future<void> sendNotificationToUser({
    required String followUserId,
    required String title,
    required String description,
  }) async {
    final currentUserId = hController.getUid();

    if (currentUserId != followUserId) {
      final document = await FirebaseFirestore.instance
          .collection('TaousUser')
          .doc(currentUserId)
          .get();
      if (!document.exists) {
        return;
      }
      final data = document.data();
      final username = data?['fullName'];

      final input = SendNotificationUsecaseInput(
        userId: followUserId,
        notification: PushNotification(
          title: title,
          description: description,
          id: DateTime.now().millisecondsSinceEpoch,
        ),
      );

      await sendNotificationUsecase(input);
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();
  }
}
