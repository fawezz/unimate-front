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
  Rx<User?>? currentUser;
  String? email;
  String? fullName;

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


  @override
  Future<void> onInit() async {
    isLoading.value = true;
    final user = await UserService.getCurrentProfile();
    currentUser = user.obs;
    if (currentUser?.value != null) {
      email = currentUser?.value?.email;
      fullName = currentUser?.value?.fullname;
      isLoading.value = false;
    }
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