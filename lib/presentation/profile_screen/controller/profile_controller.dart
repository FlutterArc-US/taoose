import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taousapp/core/app_export.dart';
import 'package:taousapp/presentation/frends_screen/controller/frends_controller.dart';
import 'package:taousapp/presentation/home_screen/controller/home_controller.dart';
import 'package:taousapp/presentation/profile_screen/models/profile_model.dart';

/// A controller class for the ProfileScreen.
///
/// This class manages the state of the ProfileScreen, including the
/// current profileModelObj
class ProfileController extends GetxController {
  RxInt followers = 0.obs;
  RxInt following = 0.obs;
  var hController = Get.find<HomeController>();
  var fController = Get.find<FrendsController>();
  Rx<ProfileModel> profileModelObj = ProfileModel().obs;
  RxList posts = [].obs;
  RxList bottomPosts = [].obs;
  RxList shoePosts = [].obs;
  checkNewPosts() async {
    getPosts();
    getBottomPosts();
    getShoePosts();
  }

  getBottomPosts() async {
    var reference = FirebaseFirestore.instance
        .collection("userPosts")
        .doc(hController.getUid().toString())
        .collection('two');
    var docs = await reference.get();
    bottomPosts.value = docs.docs.map((doc) => doc.data()).toList();
    print(bottomPosts.value);
    return;
  }

  getShoePosts() async {
    var reference = FirebaseFirestore.instance
        .collection("userPosts")
        .doc(hController.getUid().toString())
        .collection('three');
    var docsn = await reference.get();
    shoePosts.value = docsn.docs.map((doc) => doc.data()).toList();
    print(shoePosts.value);
    return;
  }

  getPosts() async {
    var reference = FirebaseFirestore.instance
        .collection("userPosts")
        .doc(hController.getUid().toString())
        .collection('one');
    var docsn = await reference.get();
    posts.value = docsn.docs.map((doc) => doc.data()).toList();
    print(posts.value);
    return;
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    checkNewPosts();
  }
}
