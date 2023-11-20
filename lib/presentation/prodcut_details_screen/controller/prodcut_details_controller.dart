import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:taousapp/core/app_export.dart';
import 'package:taousapp/main.dart';
import 'package:taousapp/presentation/home_screen/controller/home_controller.dart';
import 'package:taousapp/presentation/prodcut_details_screen/models/prodcut_details_model.dart';
import 'package:flutter/material.dart';

/// A controller class for the ProdcutDetailsScreen.
///
/// This class manages the state of the ProdcutDetailsScreen, including the
/// current prodcutDetailsModelObj
class ProdcutDetailsController extends GetxController {
  TextEditingController clothsController = TextEditingController();

  final userEditTextController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  TextEditingController urlController = TextEditingController();

  Rx<ProdcutDetailsModel> prodcutDetailsModelObj = ProdcutDetailsModel().obs;

  //Photo handler
  //RxString imgUrl = "".obs;
  var hController = Get.find<HomeController>();
  RxBool changePic = false.obs;
  RxBool uploading = false.obs;
  RxBool showMessage = false.obs;
  RxString path = "".obs;
  var image;
  RxString description = ''.obs;
  RxString cloths = ''.obs;
  //String imagePath = 'assets/images/img_ellipse8.png';
  // ignore: unused_field
  final _picker = ImagePicker();

  Future fetchImgURL() {
    return FirebaseStorage.instance.ref('taousUser').getDownloadURL();
  }

  Future<void> getImage(ImageSource imageSource) async {
    print(imageSource.toString());
    final _picker = ImagePicker();
    await Permission.camera.request();
    var permissionStatus = await Permission.camera.status;
    if (permissionStatus.isGranted) {
      final pickedFile = await _picker.pickImage(source: imageSource);
      //final pickedImageFile = File(pickedFile!.path);
      if (pickedFile != null) {
        //changePic.value = true;
        final pickedImageFile = File(pickedFile.path);
        image = pickedImageFile;
        path.value = pickedImageFile.path;
        print(path.value.toString());
        //changePic.value= false;
      } else {
        print('No image selected.');
        changePic.value = false;
      }
      update();
    } else {
      print('Permission not granted. Try Again with permission access');
      await Permission.camera.request();
    }
  }

  uploadImage() async {
    final _firebaseStorage = FirebaseStorage.instance.ref();
    var file = File(image.path);
    try {
      var snapshot = await _firebaseStorage
          .child(hController.getUid() + "-" + DateTime.now().toString())
          .putFile(file);
      var downloadUrl = await snapshot.ref.getDownloadURL();
      //imgUrl.value = downloadUrl;
      //print(downloadUrl);

      var updateDoc = hController.firestoreInstance.doc(hController.getUid());
      var updatePost = FirebaseFirestore.instance
          .collection('userPosts')
          .doc(hController.getUid())
          .collection(description.value.toString())
          .doc();
      var docCheck = await updatePost.get();
      print('docId is : ' + docCheck.id);
      if (docCheck.exists) {
        await updatePost.set({
          'timestamp': DateTime.now(),
          'owner': hController.getUid().toString(),
          'likedBy': [],
          'photoUrl': downloadUrl.toString(),
          'cloths': cloths.value,
          'description': description.value,
          'productUrl': urlController.text,
          'comments': 0,
          'postId': docCheck.id,
        });
      } else {
        await updatePost.set({
          'timestamp': DateTime.now(),
          'owner': hController.getUid().toString(),
          'likedBy': [],
          'photoUrl': downloadUrl.toString(),
          'cloths': cloths.value,
          'description': description.value,
          'productUrl': urlController.text,
          'comments': 0,
          'postId': docCheck.id,
        });
      }

      uploading.value = false;
      await updateDoc.update({
        'notifications': FieldValue.arrayUnion(
          [
            {
              'id': 0,
              'timestamp': DateTime.now(),
              'notification': ['Post Successful!', 'Your New Post Is Online.']
            }
          ],
        )
      });

      flutterLocalNotificationsPlugin.show(
          hashCode,
          'Post Successful!',
          'Your New Post Is Online.',
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              //channel.description,
              color: Colors.white,
              // ignore: todo
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: "@mipmap/ic_launcher",
              enableVibration: true,
            ),
          ));
      Get.back();
      Get.back();
    } catch (e) {
      uploading.value = false;
      Get.back();
      print(e);
    }
  }

  RegExp entryRegExp = RegExp(r'^[a-zA-Z ]+$');
  validatecloths(String? entryReg) {
    if (!entryRegExp.hasMatch(entryReg!)) {
      return 'cloths Name is Valid';
    }
    return null;
  }

  RegExp entryRegExpUrl = RegExp(
      r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?');
  validateUrl(String? entryReg) {
    if (!entryRegExpUrl.hasMatch(entryReg!)) {
      return 'URL is Valid';
    }
    return null;
  }

  late FocusNode clothsNode;
  late FocusNode descriptionNode;
  late FocusNode urlNode;

  @override
  void onInit() {
    super.onInit();
    descriptionNode = FocusNode();
    clothsNode = FocusNode();
    urlNode = FocusNode();
  }

  @override
  void onClose() {
    super.onClose();
    clothsController.dispose();
    urlController.dispose();
    descriptionController.dispose();
  }
}
