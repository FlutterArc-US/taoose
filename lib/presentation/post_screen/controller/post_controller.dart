import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taousapp/core/app_export.dart';
import 'package:taousapp/presentation/frends_screen/controller/frends_controller.dart';
import 'package:taousapp/presentation/home_screen/controller/home_controller.dart';
import 'package:taousapp/presentation/post_screen/models/comment_model.dart';
import 'package:taousapp/presentation/post_screen/models/post_model.dart';

/// A controller class for the PostScreen.
///
/// This class manages the state of the PostScreen, including the
/// current postModelObj
class PostController extends GetxController {
  @override
  Future<void> onInit() async {
    super.onInit();
    await getFollowings();
    await getFollowingPosts();
  }

  RxBool loading = true.obs;
  Rx<PostModel> postModelObj = PostModel().obs;
  var hController = Get.find<HomeController>();
  var fController = Get.find<FrendsController>();
  RxList posts = [].obs;

  //RxList bottomPosts = [].obs;
  //RxList shoePosts = [].obs;
  var docFetch = FirebaseFirestore.instance.collection("userPosts");
  var query = FirebaseFirestore.instance.collection("TaousUser");
  RxList followings = [].obs;

  /*checkNewPosts() async {
    DocumentReference ref = FirebaseFirestore.instance
        .collection("userPosts")
        .doc(hController.getUid().toString());
    var refdoc = await ref.get();
    if (refdoc.exists) {
      ref.snapshots().listen((event) {
        getPosts();
      });
    }
  }*/
  getFollowings() async {
    var reference = query.doc(hController.getUid().toString());
    var doc = await reference.get();
    if (doc.exists) {
      var data = doc.data();
      followings.value = await data?['following'];
    }
    followings.add(hController.getUid().toString());
    //print("Following the following"+followings.toString());
    return;
  }

  getFollowingPosts() async {
    posts.value = [];
    int loops = followings.length;
    for (int i = 0; i < loops; i++) {
      var ref = docFetch
          .doc(followings[i].toString())
          .collection('one')
          .orderBy("timestamp")
          .limit(2);
      var docu = await ref.get();

      posts.value.addAll(docu.docs.map((doc) => doc.data()).toList());

      ref = docFetch
          .doc(followings[i].toString())
          .collection('two')
          .orderBy("timestamp")
          .limit(2);
      docu = await ref.get();

      posts.value.addAll(docu.docs.map((doc) => doc.data()).toList());

      ref = docFetch
          .doc(followings[i].toString())
          .collection('three')
          .orderBy("timestamp")
          .limit(2);
      docu = await ref.get();

      posts.value.addAll(docu.docs.map((doc) => doc.data()).toList());
    }
    loading.value = false;
  }

/*
  getPosts() async {
    var reference = FirebaseFirestore.instance
        .collection("userPosts")
        .doc(hController.getUid().toString());
    var doc = await reference.get();
    if (doc.exists) {
      var data = doc.data();
      posts.value = data?["posts"];
      print(posts);
    }
    return;
  }

*/
  Future<DocumentSnapshot<Object?>> getUserDetails(docId) async {
    var q = await hController.firestoreInstance.doc(docId).get();
    return q;
  }

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

    FirebaseFirestore.instance
        .collection('userPosts')
        .doc(postOwnerUserId)
        .collection(category)
        .doc(postId)
        .collection('comments')
        .add({
      'commentedBy': myUserId,
      'time': DateTime.now().toString(),
      'comment': comment,
    });

    if (myUserId != postOwnerUserId) {
      //TODO: Send Notification to other person
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

    FirebaseFirestore.instance
        .collection('userPosts')
        .doc(postOwnerId)
        .collection(category)
        .doc(postId)
        .collection('comments')
        .doc(commentId)
        .collection('subComments')
        .add({
      'commentedBy': myUserId,
      'time': DateTime.now().toString(),
      'comment': comment,
    });

    if (myUserId != commentOwnerId) {
      //TODO: Send Notification to other person
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
