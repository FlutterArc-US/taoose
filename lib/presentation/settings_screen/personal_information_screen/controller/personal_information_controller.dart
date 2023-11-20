import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taousapp/core/app_export.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../home_screen/controller/home_controller.dart';
import '../models/personal_information_model.dart';

enum GenderOption { male, female, custom }

class PersonalInformationController extends GetxController {
  Rx<PersonalInformationModel> accountManagementModelObj =
      PersonalInformationModel().obs;
  var hController = Get.find<HomeController>();

  final CollectionReference firestoreInstance =
      FirebaseFirestore.instance.collection('TaousUser');

  final customGenderTextController = TextEditingController();
  final usernameFocusNode = FocusNode();
  Rx selectedGender = GenderOption.male.obs;
  var customGenderText = ''.obs;
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  void pickDate(BuildContext context) async {
    // Calculate the minimum and maximum years
    int currentYear = DateTime.now().year;
    int minimumYear =
        currentYear - 70; // Adjust as needed, 70 years in the past
    int maximumYear = currentYear - 12; // User should be at least 12 years old

    DateTime? newDate = await showCupertinoModalPopup<DateTime>(
      context: context,
      builder: (BuildContext builder) {
        return SizedBox(
          height: 550,
          child: CupertinoDatePicker(
            minimumYear: minimumYear,
            maximumYear: maximumYear,
            mode: CupertinoDatePickerMode.date,
            initialDateTime: selectedDate.value ?? DateTime(currentYear - 12),
            onDateTimeChanged: (DateTime newDateTime) {
              if (newDateTime.year <= maximumYear) {
                selectedDate.value = newDateTime;
              }
            },
          ),
        );
      },
    );

    if (newDate != null && newDate.year <= maximumYear) {
      selectedDate.value = newDate;

      // Assuming you have a way to get the current user's ID
      String userId =
          hController.getUid(); // Replace with your method to get the user's ID

      // Update the user's document in Firestore
      firestoreInstance.doc(userId).update({
        'birthday': newDate, // Store the date as an ISO 8601 String
      }).then((_) {
        print("Birthday updated successfully");
      }).catchError((error) {
        print("Error updating birthday: $error");
      });
    }
  }

  void setGender(GenderOption gender) {
    selectedGender.value = gender;
    if (gender != GenderOption.custom) {
      customGenderText.value = '';
    }
  }

  void setCustomGenderText(String text) {
    if (selectedGender.value == GenderOption.custom) {
      customGenderText.value = text;
    }
  }

  RegExp customGenderRegExp = RegExp(r'^[a-zA-Z ]+$');
  validateCustomGender(String? customGender) {
    if (!customGenderRegExp.hasMatch(customGender!)) {
      return 'Full name is valid.';
    }
    return null;
  }
}
