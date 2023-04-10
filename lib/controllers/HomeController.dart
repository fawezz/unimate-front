import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:univ_chat_gpt/app/Colors.dart';
import 'package:univ_chat_gpt/services/UserService.dart';

import '../app/Routes.dart';
import '../models/UserModel.dart';

class HomeController extends GetxController {
  Rx<bool> isLoading = true.obs;

  //drawer variables
  Rx<User?> currentUser = null.obs;

  //chat variables
  final searchController = TextEditingController().obs;

  Future<void> logout() async {
    Alert(
        type: AlertType.warning,
        context: Get.context!,
        title: "Logging out",
        desc: "Are you sure you want to logout ?",
        buttons: [
          DialogButton(
              color: primaryColor,
              child: const Text(
                "Logout",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove("token");
                Get.offAllNamed(NamedRoutes.login);
              }),
          DialogButton(
              color: secondaryColor,
              child:
                  const Text("Cancel", style: TextStyle(color: Colors.white)),
              onPressed: () => Get.back())
        ]).show();
    /**/
  }

  Future<void> getProfile() async {
    final user = await UserService.getCurrentProfile();
    print(currentUser.value == null);
    if (currentUser.value == null) {
      currentUser = user.obs;
    }
    if (user != null) {
      currentUser.update((value) {
        value!.fullname = user.fullname;
      });

      currentUser.refresh();
      isLoading.value = false;
    } else {
      //error getting user data from server
    }
  }

  @override
  Future<void> onInit() async {
    isLoading.value = true;
    getProfile();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}


  /*showSettingsBottomSheet() {
    showModalBottomSheet(
        context: Get.context!,
        builder: (BuildContext context) {
          return SettingsSheet();
        });
  }*/