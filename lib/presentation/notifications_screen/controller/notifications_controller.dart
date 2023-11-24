import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taousapp/core/app_export.dart';
import 'package:taousapp/notifications/domain/models/notification/push_notification.dart';
import 'package:taousapp/notifications/domain/usecases/send_notificaiton.dart';
import 'package:taousapp/presentation/notifications_screen/models/notifications_model.dart';
import 'package:taousapp/util/di/di.dart';

import '../../home_screen/controller/home_controller.dart';

/// A controller class for the NotificationsScreen.
///
/// This class manages the state of the NotificationsScreen, including the
/// current notificationsModelObj
class NotificationsController extends GetxController {
  Rx<NotificationsModel> notificationsModelObj = NotificationsModel().obs;
  final sendNotificationUsecase = sl<SendNotificationUsecase>();

  // ignore: non_constant_identifier_names
  var Ncontroller = Get.find<HomeController>();
  RxBool show = false.obs;
  RxList notifications = [].obs;
  RxList requests = [].obs;
  RxList requestList = [].obs;
  var query = FirebaseFirestore.instance.collection("TaousUser");

  checkNewNotification() async {
    DocumentReference ref = query.doc(Ncontroller.getUid().toString());
    var refdoc = await ref.get();
    if (refdoc.exists) {
      ref.snapshots().listen((event) {
        getNotifications();
      });
    }
  }

  acceptFollow(info) async {
    try {
      await query.doc(Ncontroller.getUid().toString()).update({
        'followers': FieldValue.arrayUnion([info['uid'].toString()]),
      });
      await query.doc(info['uid'].toString()).update({
        'following': FieldValue.arrayUnion([Ncontroller.getUid().toString()]),
      });
      await query.doc(Ncontroller.getUid().toString()).update({
        'requests': FieldValue.arrayRemove([info['uid'].toString()]),
      });

      if (Ncontroller.getUid() != info['uid']) {
        //TODO: Send Notification to other person

        final input = SendNotificationUsecaseInput(
          userId: info['uid'],
          notification: PushNotification(
            id: DateTime.now().millisecondsSinceEpoch,
            title: 'Accept Request',
            description: '${Ncontroller.getName()} has accept your request',
          ),
        );

        await sendNotificationUsecase(input);
      }
      await getFollowRequests();
      await getRequests();
    } catch (e) {
      print('Error: $e');
    }
  }

  getNotifications() async {
    var reference = query.doc(Ncontroller.getUid().toString());
    var doc = await reference.get();
    if (doc.exists) {
      var data = doc.data();
      notifications.value = data?["notifications"];
    }
    return;
  }

  getFollowRequests() async {
    var reference = query.doc(Ncontroller.getUid().toString());
    var doc = await reference.get();
    if (doc.exists) {
      var data = doc.data();
      requests.value = data?["requests"];
      print("======================" + data!['requests'].toString());
      if (requests.length == 0) {
        show.value = false;
      }
    }
    return;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getMoreRequests() async {
    int start = 10;
    int end = requests.length % 10;
    int pages = (requests.length ~/ 10);

    //gettingMoreFavourites.value = true;

    for (int i = 1; i <= pages; i++) {
      if (i == pages) {
        print("Repeat test" + requests.toString());
        if (end != 0) {
          Query q =
              query.where('uid', whereIn: requests.sublist(start, start + end));
          QuerySnapshot querySnapshot = await q.get();
          requestList.addAll(querySnapshot.docs);
          //moreFavourites.value = false;
          return;
        } else {
          return;
        }

        //gettingMoreFavourites.value = false;
      } else {
        print("Repeat test");
        Query q =
            query.where('uid', whereIn: requests.sublist(start, start + 10));
        QuerySnapshot querySnapshot = await q.get();
        requestList.addAll(querySnapshot.docs);
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

  getRequests() async {
    if (requests.length <= 10) {
      Query q = query.where("uid", whereIn: requests);
      //isLoading.value = true;
      QuerySnapshot querySnapshot = await q.get();
      requestList.value = querySnapshot.docs;
      //print(doctors.toString());
      //lastDoc = querySnapshot.docs[querySnapshot.docs.length - 1];
      //isLoading.value = false;
      //moreFavourites.value = false;
    } else {
      //moreFavourites.value = true;
      //isLoading.value = true;
      Query q = query.where("uid", whereIn: requests.sublist(0, 10));
      //isLoading.value = false;
      QuerySnapshot querySnapshot = await q.get();
      requestList.value = querySnapshot.docs;
      getMoreRequests();
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    getNotifications();
    checkNewNotification();
    getFollowRequests();
    //getRequests();
  }
}
