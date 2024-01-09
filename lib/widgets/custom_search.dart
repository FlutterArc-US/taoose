import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taousapp/core/app_export.dart';
import 'package:taousapp/presentation/home_screen/controller/home_controller.dart';

import 'app_bar/appbar_iconbutton.dart';
import 'cusom_text_form_field1.dart';
import 'custom_search_view.dart';
import 'custom_search_widget.dart';

class CustomSearch extends StatefulWidget {
  const CustomSearch({super.key});

  @override
  State<CustomSearch> createState() => _CustomSearchState();
}

class _CustomSearchState extends State<CustomSearch> {
  final hController = Get.find<HomeController>();

  final RxList<DocumentSnapshot> users = <DocumentSnapshot>[].obs;
  TextEditingController searchController = TextEditingController();

  void searchUsers(String change) async {
    String username;
    print(change.toString().replaceAll(RegExp('@'), ''));
    if (change.length > 0) {
      if (change.toString().contains(RegExp('@')) && change.length > 1) {
        username = change.toString().replaceAll(RegExp('@'), '');
        Query q = hController.firestoreInstance
            .where('UserName', isGreaterThanOrEqualTo: username)
            .where('UserName', isLessThan: username + 'z');
        QuerySnapshot query = await q.get();
        users.value = query.docs;
      } else {
        Query q = hController.firestoreInstance
            .where('fullName', isGreaterThanOrEqualTo: change)
            .where('fullName', isLessThan: change + 'z');
        QuerySnapshot query = await q.get();
        users.value = query.docs;
      }
    } else {
      users.value = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppbarIconbutton(
      svgPath: ImageConstant.imgCharmsearch,
      /*margin: EdgeInsets.symmetric(
              horizontal: 2.h,
              vertical: 2.v,
            ),*/
      onTap: () {
        showModalBottomSheet(
          isDismissible: true,
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => GestureDetector(
            onTap: () {
              SystemChannels.textInput.invokeMethod('TextInput.hide');
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Obx(
                () => Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                          child: InkWell(
                              onTap: () {
                                Get.back();
                                SystemChannels.textInput
                                    .invokeMethod('TextInput.hide');
                              },
                              child: const Icon(Icons.arrow_drop_down))),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, bottom: 15),
                        child: CustomSearchView(
                          onChanged: (value) {
                            print(value);
                            if (value == '') {}
                            print(value);
                            searchUsers(value.toString().toLowerCase());
                          },
                          suffix: Padding(
                            padding: EdgeInsets.only(
                              right: 8.h,
                            ),
                            child: IconButton(
                              onPressed: () {
                                searchController.clear();
                              },
                              icon: Icon(
                                Icons.clear,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                          //focusNode: controller.descriptionNode,
                          prefix: Container(
                            margin: EdgeInsets.fromLTRB(8.h, 12.v, 4.h, 13.v),
                            child: CustomImageView(
                              svgPath: ImageConstant.imgCharmsearch,
                              color: appTheme.gray500,
                            ),
                          ),
                          autofocus: false,
                          controller: searchController,
                          hintText: "Search Users".tr,
                          borderDecoration: TextFormFieldStyleHelper.fillGray,
                          fillColor: appTheme.gray10001,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 9.h,
                            vertical: 14.v,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, bottom: 15.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info,
                              size: 15,
                              color: Colors.grey,
                            ),
                            Text(
                              "  Add '@' To Search By Username. Ex. @Taous",
                              style: CustomTextStyles.bodyMediumGray60002,
                            ),
                          ],
                        ),
                      ),
                      users.length == 0
                          ? Container()
                          : Expanded(
                              child: SingleChildScrollView(
                                child: GetBuilder<HomeController>(
                                    builder: (context) {
                                  return ListView.builder(
                                    itemCount: users.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: ((context, index) {
                                      //return Container(width: 20, height:20, color: Colors.red,);
                                      return InkWell(
                                        child: CustomSearchWidget(
                                            users[index].data() as dynamic),
                                        onTap: () async {
                                          final data = users[index].data();

                                          if (data == null) {
                                            return;
                                          }
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                          final userId =
                                              Map<String, dynamic>.from(
                                                  data as Map)['uid'];

                                          if (hController.getUid() == userId) {
                                            await Get.toNamed(
                                                AppRoutes.profileScreen);
                                          } else {
                                            await Get.toNamed(
                                                AppRoutes.profileScreenUser,
                                                arguments: users[index].data());
                                          }

                                          Get.back();
                                        },
                                      );
                                    }),
                                  );
                                }),
                              ),
                            )
                    ]),
              ),
            ),
          ),
        );
      },
    );
  }
}
