import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:taousapp/core/app_export.dart';
import 'package:taousapp/main.dart';
import 'package:taousapp/presentation/edit_profile_screen/models/edit_profile_model.dart';
import 'package:taousapp/presentation/home_screen/controller/home_controller.dart';

class EditprofileController extends GetxController {
  var hController = Get.find<HomeController>();

  TextEditingController newNameController =
      TextEditingController(text: HomeController().getName().toString());

  TextEditingController newUsernameController = TextEditingController();

  Rx<EditprofileModel> editprofileModelObj = EditprofileModel().obs;
  RxBool changePic = false.obs;
  RxBool uploading = false.obs;
  RxString imgUrl = HomeController().getPhotoUrl().obs;
  RxString username = ''.obs;

  final _firestoreInstance = FirebaseFirestore.instance;
  var image;
  //String imagePath = 'assets/images/img_ellipse8.png';
  // ignore: unused_field
  final _picker = ImagePicker();

  var usernameAvailable = false.obs;
  var fullnameAvailable = false.obs;
  final RxBool isUsernameValid = true.obs;
  RegExp fullNameRegExp = RegExp(r'^[a-zA-Z ]+$');
  RxBool lock = true.obs;
  validateFullName(String? fullname) {
    if (!fullNameRegExp.hasMatch(fullname!)) {
      return 'Full name is valid.';
    }
    return null;
  }

  void updateUsername(String newUsername) async {
    await checkUsernameAvailability(newUsername);
    if (usernameAvailable.value) {
      try {
        User? user = hController.getCurrentUser();
        if (user != null) {
          await hController.firestoreInstance.doc(user.uid).update({
            'UserName': newUsername.toLowerCase(),
          });

          Get.snackbar(
            'Username Updated',
            'Your username has been updated successfully',
            backgroundColor: Colors.white,
          );
          hController.getUserName();
        }
      } catch (e) {
        print('Error updating username: $e');

        Get.snackbar(
          'Error Updating Username',
          'There was an error updating your username',
          backgroundColor: Colors.white,
        );
      }
    } else {
      isUsernameValid.value = false;
    }
  }

  validateUsername(name) async {
    print("Validating");
    bool available = false;
    await checkUsernameAvailability(name).then((value) {
      if (usernameAvailable.value == true) {
        available = true;
      } else
        available = false;
    });
    print(available);
    return available;
  }

  Future<void> checkUsernameAvailability(String username) async {
    try {
      QuerySnapshot<Map<String, dynamic>> result = await _firestoreInstance
          .collection('TaousUser')
          .where('UserName', isEqualTo: username.toString().toLowerCase())
          .get();

      usernameAvailable.value = result.docs.isEmpty;
    } catch (error) {
      // Handle error if any
      print('Error checking username availability: $error');
      usernameAvailable.value = false;
    }
  }

  //RxString fullName = ''.obs;
  Future<void> updateFirstName(String newFirstName) async {
    try {
      User? user = hController.getCurrentUser();
      if (user != null) {
        await hController.firestoreInstance.doc(user.uid).update({
          'fullName': newFirstName.toLowerCase(),
        });
        await hController
            .getCurrentUser()
            .updateDisplayName(newFirstName.toLowerCase());

        Get.snackbar(
          'Name Updated',
          'Your name has been updated successfully',
          backgroundColor: Colors.white,
        );
      }
    } catch (e) {
      print('Error updating name: $e');

      Get.snackbar(
        'Error Updating Name',
        'There was an error updating your name',
        backgroundColor: Colors.white,
      );
    }
  }

  getUserData() {
      
      newUsernameController.text = hController.username.value;
      return hController.username.value;
    
  }

  Future fetchImgURL() {
    return FirebaseStorage.instance.ref('taousUser').getDownloadURL();
  }

  uploadImage() async {
    final _firebaseStorage = FirebaseStorage.instance.ref();
    var file = File(image.path);
    try {
      var snapshot =
          await _firebaseStorage.child(hController.getEmail()).putFile(file);
      var downloadUrl = await snapshot.ref.getDownloadURL();
      hController.getCurrentUser().updatePhotoURL(downloadUrl);
      Get.back();
      imgUrl.value = downloadUrl;
      print(downloadUrl);
      hController.update();
      uploading.value = false;
      var updateDoc = hController.firestoreInstance.doc(hController.getUid());

      await updateDoc.update({
        'profileUrl': downloadUrl,
        'notifications': FieldValue.arrayUnion(
          [
            {
              'id': 0,
              'timestamp': DateTime.now(),
              'notification': [
                'Profile Picture Update Successful!',
                'Your profile picture has been updated successfully.'
              ]
            }
          ],
        )
      });

      flutterLocalNotificationsPlugin.show(
          hashCode,
          'Profile Picture Update Successful!',
          'Your profile picture has been updated successfully.',
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
    } catch (e) {
      uploading.value = false;
      Get.back();
      print(e);
    }
  }

  /*
  Future<bool> askPermission() async {
    PermissionStatus status = await Permission.camera.request();
    if(status.isDenied == true)
    {
      askPermission();
    }
    else{
      return true;
    }
  }
  */
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

  late FocusNode newUsernameNode;
  late FocusNode fullNameNode;
  late FocusNode newNameNode;
  @override
  void onInit() {
    super.onInit();
    getUserData();
    fullNameNode = FocusNode();
    newNameNode = FocusNode();
    newUsernameNode = FocusNode();
  }

  @override
  void onClose() {
    super.onClose();
    newUsernameController.dispose();
  }
}
