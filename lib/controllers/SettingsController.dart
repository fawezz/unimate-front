import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/Themes.dart';

class SettingsController extends GetxController {
  Rx<String> darkMode = "LIGHT".obs;

  Future<void> changeTheme() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("theme", darkMode.value);
    Themes.changeTheme(darkMode.value);
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    final prefs = await SharedPreferences.getInstance();
    darkMode.value = prefs.getString("theme") ?? "LIGHT";
  }
}
