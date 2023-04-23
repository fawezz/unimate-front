import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
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

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

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
      Fluttertoast.showToast(
          msg: "error retrieving user info",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: primaryColor.withOpacity(0.6),
          textColor: Colors.white,
          fontSize: 14.sp);
    }
    refreshController.refreshCompleted();
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