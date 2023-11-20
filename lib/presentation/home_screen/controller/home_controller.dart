import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taousapp/core/app_export.dart';
import 'package:taousapp/presentation/home_screen/models/home_model.dart';
import 'package:taousapp/widgets/custom_bottom_bar.dart';

class HomeController extends GetxController with WidgetsBindingObserver {
  //late String username = "null";
  final FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference firestoreInstance =
      FirebaseFirestore.instance.collection('TaousUser');
  RxString username = ''.obs;
  var gender = ''.obs;
  var birthday = ''.obs;
  getCurrentUser() {
    final User? user = auth.currentUser;
    return user;
  }

  String getUid() {
    final User? user = auth.currentUser;
    final uid = user?.uid;
    return uid.toString();
    // here you write the codes to input the data into firestore
  }

  getUserName() async {
    await firestoreInstance
        .doc(getUid().toString())
        .get()
        .then((name) => username.value = name['UserName'].toString());
  }

  String getPhotoUrl() {
    final User? user = auth.currentUser;
    final url = user?.photoURL;
    return url.toString();
    // here you write the codes to input the data into firestore
  }

  String getEmail() {
    final User? user = auth.currentUser;
    final email = user?.email;
    return email.toString();
  }

  String getName() {
    final User? user = auth.currentUser;
    final name = user?.displayName;
    return name.toString();
  }

  void getGender() async {
    await firestoreInstance
        .doc(getUid().toString())
        .get()
        .then((ge) => gender.value = ge['Geneder'].toString());
  }

  void getBirthday() async {
    await firestoreInstance.doc(getUid().toString()).get().then((birth) {
      if (birth.toString().contains('birthday')) {
        birthday.value = birth['birthday'].toString();
      }
    });
  }

  Future<void> updateOnlineOfflineUserStatus({required bool status}) async {
    final User? user = auth.currentUser;
    final uid = user?.uid;
    if (uid != null && uid.isNotEmpty) {
      await firestoreInstance
          .doc(getUid())
          .set({'online': status}, SetOptions(merge: true));
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    updateOnlineOfflineUserStatus(status: false);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.detached) {
      updateOnlineOfflineUserStatus(status: false);
    } else {
      updateOnlineOfflineUserStatus(status: true);
    }
  }

  RxInt selectedIndex = 0.obs;
  PageController pageController = PageController();
  Rx<BottomBarEnum> type = BottomBarEnum.Home.obs;
  Rx<HomeModel> homeModelObj = HomeModel().obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    getUserName();
    getGender();
    getBirthday();
    WidgetsBinding.instance.addObserver(this);
    updateOnlineOfflineUserStatus(status: true);
  }
}
