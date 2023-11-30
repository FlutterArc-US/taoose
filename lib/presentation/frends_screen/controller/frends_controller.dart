import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taousapp/core/app_export.dart';
import 'package:taousapp/presentation/frends_screen/models/frends_model.dart';
import 'package:flutter/material.dart';
import 'package:taousapp/presentation/home_screen/controller/home_controller.dart';

/// A controller class for the FrendsScreen.
///
/// This class manages the state of the FrendsScreen, including the
/// current frendsModelObj
class FrendsController extends GetxController {
  RxInt activeWidget = 0.obs;
  RxBool isLoading = true.obs; // track if classes fetching
  RxBool gettingData = false.obs;
  RxBool moreData = true.obs;
  RxString userName = ''.obs;

  var hController = Get.find<HomeController>();
  RxList followers = [].obs;
  RxList following = [].obs;
  RxList followersList = [].obs;
  RxList followingList = [].obs;

  var query = FirebaseFirestore.instance.collection("TaousUser");
  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxList<DocumentSnapshot> friends = <DocumentSnapshot>[].obs;
  int perPage = 10; // load how many
  late DocumentSnapshot lastDoc;
  var chunks;
  RxInt searchLength = 0.obs;
  Rx<FrendsModel> frendsModelObj = FrendsModel().obs;
  searchFriends(change) async {
    Query q = firestore
        .collection('TaousUser')
        .where('UserName', isGreaterThanOrEqualTo: change)
        .where('UserName', isLessThan: change + 'z');
    QuerySnapshot query = await q.get();
    friends.value = query.docs;
  }

  RxList followersQueryFinal = [].obs;

  searchFollowers(change) {
    print(searchController.text.length);
    RxList followersQuery = [].obs;
    // print(followersList[0]);

    for (int x = 0; x < followersList.length; x++) {
      if (followersList[x]['fullName']
              .toString()
              .contains(change.toString().toLowerCase()) &&
          change.length > 0) {
        followersQuery.addAll({followersList[x].data()});
        print(followersQuery);
      }
    }
    followersQueryFinal = followersQuery;
    //print(followersQuery);
  }

  getFriends() async {
    Query q = firestore.collection('TaousUser').limit(perPage);
    isLoading.value = true;

    QuerySnapshot querySnapshot = await q.get();
    if (querySnapshot.docs.length > 0) {
      friends.value = querySnapshot.docs;
      lastDoc = querySnapshot.docs[querySnapshot.docs.length - 1];
    } else {
      moreData.value = false;
    }
    if (querySnapshot.docs.length < 4) {
      moreData.value = false;
    }
    //moreDoctors.value = false;
    isLoading.value = false;
  }

  getMoreFriends() async {
    if (moreData.value == false) {
      return;
    }
    if (gettingData.value == true) {
      return;
    }
    gettingData.value = true;
    Query q = firestore
        .collection('TaousUser')
        .startAfterDocument(lastDoc)
        .limit(perPage);

    QuerySnapshot querySnapshot = await q.get();

    if (querySnapshot.docs.length < perPage) {
      moreData.value = false;
    }
    if (moreData.value == true) {
      lastDoc = querySnapshot.docs[querySnapshot.docs.length - 1];
    }

    friends.addAll(querySnapshot.docs);

    gettingData.value = false;
  }

  getMoreFollowers() async {
    int start = 10;
    int end = followers.length % 10;
    int pages = (followers.length ~/ 10);

    //gettingMoreFavourites.value = true;

    for (int i = 1; i <= pages; i++) {
      if (i == pages) {
        print("Repeat test" + followers.toString());
        if (end != 0) {
          Query q = query.where('uid',
              whereIn: followers.sublist(start, start + end));
          QuerySnapshot querySnapshot = await q.get();
          followersList.addAll(querySnapshot.docs);
          //moreFavourites.value = false;
          return;
        } else {
          return;
        }

        //gettingMoreFavourites.value = false;
      } else {
        print("Repeat test");
        Query q =
            query.where('uid', whereIn: followers.sublist(start, start + 10));
        QuerySnapshot querySnapshot = await q.get();
        followersList.addAll(querySnapshot.docs);
        start = start + 10;
        //moreFavourites.value = false;
        //gettingMoreFavourites.value = false;
      }
    }
    //moreFavourites.value = false;
    /*
    Query q = homeController.firestore
        .collection('doctors')
        .where('uid', whereIn: homeController.favourites);
    QuerySnapshot querySnapshot = await q.get();

    if (querySnapshot.docs.length < perPage) {
      moreFavourites.value = false;
    }
    if (moreFavourites.value == true) {
      lastDoc = querySnapshot.docs[querySnapshot.docs.length - 1];
    }
    doctors.value = (querySnapshot.docs);
    gettingMoreFavourites.value = false;
    */
  }

  getMoreFollowing() async {
    int start = 10;
    int end = following.length % 10;
    int pages = (following.length ~/ 10);

    //gettingMoreFavourites.value = true;

    for (int i = 1; i <= pages; i++) {
      if (i == pages) {
        print("Repeat test" + following.toString());
        if (end != 0) {
          Query q = query.where('uid',
              whereIn: following.sublist(start, start + end));
          QuerySnapshot querySnapshot = await q.get();
          followingList.addAll(querySnapshot.docs);
          //moreFavourites.value = false;
          return;
        } else {
          return;
        }

        //gettingMoreFavourites.value = false;
      } else {
        print("Repeat test");
        Query q =
            query.where('uid', whereIn: following.sublist(start, start + 10));
        QuerySnapshot querySnapshot = await q.get();
        followingList.addAll(querySnapshot.docs);
        start = start + 10;
        //moreFavourites.value = false;
        //gettingMoreFavourites.value = false;
      }
    }
    //moreFavourites.value = false;
    /*
    Query q = homeController.firestore
        .collection('doctors')
        .where('uid', whereIn: homeController.favourites);
    QuerySnapshot querySnapshot = await q.get();

    if (querySnapshot.docs.length < perPage) {
      moreFavourites.value = false;
    }
    if (moreFavourites.value == true) {
      lastDoc = querySnapshot.docs[querySnapshot.docs.length - 1];
    }
    doctors.value = (querySnapshot.docs);
    gettingMoreFavourites.value = false;
    */
  }

  getFollowFollowings() async {
    var reference = query.doc(hController.getUid().toString());
    var doc = await reference.get();
    if (doc.exists) {
      var data = doc.data();
      followers.value = await data?["followers"] ?? [];
      following.value = await data?['following'] ?? [];
    }
    return;
  }

  getFollowers() async {
    //print("======================" + data!['followers'].toString());
    if (followers.length <= 10) {
      Query q = query.where("uid", whereIn: followers);
      //isLoading.value = true;
      QuerySnapshot querySnapshot = await q.get();
      followersList.value = querySnapshot.docs;
      //print(doctors.toString());
      //lastDoc = querySnapshot.docs[querySnapshot.docs.length - 1];
      //isLoading.value = false;
      //moreFavourites.value = false;
    } else {
      //moreFavourites.value = true;
      //isLoading.value = true;
      Query q = query.where("uid", whereIn: followers.sublist(0, 10));
      //isLoading.value = false;
      QuerySnapshot querySnapshot = await q.get();
      followersList.value = querySnapshot.docs;
      getMoreFollowers();
    }
    //isLoading.value = false;

    return;
  }

  //RxList search = [].obs;

  getFollowing() async {
    if (following.length <= 10) {
      Query q = query.where("uid", whereIn: following);
      //isLoading.value = true;
      QuerySnapshot querySnapshot = await q.get();
      followingList.value = querySnapshot.docs;
      //print(doctors.toString());
      //lastDoc = querySnapshot.docs[querySnapshot.docs.length - 1];
      //isLoading.value = false;
      //moreFavourites.value = false;
    } else {
      //moreFavourites.value = true;
      //isLoading.value = true;
      Query q = query.where("uid", whereIn: following.sublist(0, 10));
      //isLoading.value = false;
      QuerySnapshot querySnapshot = await q.get();
      followingList.value = querySnapshot.docs;
      getMoreFollowing();
    }
    //isLoading.value=false;
    //print("======================" + data!['following'].toString());
    return;
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    //await getUserName();
    await getFriends();
    await getFollowFollowings();
    //await getFollowers();
    //await getFollowing();
/*
    scrollController.addListener(() {
      double maxScroll = scrollController.position.maxScrollExtent;
      double currentScroll = scrollController.position.pixels;
      //double delta = MediaQuery.of(context).size.height * 0.20;
      double delta = Get.height * 0.20;

      if (maxScroll - currentScroll <= delta) {
        getMoreFriends();
      }
      
    });*/
  }

  @override
  void onClose() {
    super.onClose();
  }
}
