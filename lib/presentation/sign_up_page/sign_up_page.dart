import 'controller/sign_up_controller.dart';
import 'models/sign_up_model.dart';
import 'package:flutter/material.dart';
import 'package:taousapp/core/app_export.dart';

// ignore: must_be_immutable
class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key})
      : super(
          key: key,
        );

  SignUpController controller = Get.put(SignUpController(SignUpModel().obs));

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: mediaQueryData.size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 32.h,
                    top: 22.v,
                    right: 32.h,
                  ),
                  child: Container(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
