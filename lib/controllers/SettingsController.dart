import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/Themes.dart';

class SettingsController extends GetxController {
  Rx<String> darkMode = "LIGHT".obs;

  Future<void> changeTheme() async {
    
    Themes.saveTheme(darkMode.value);
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    final prefs = await SharedPreferences.getInstance();
    darkMode.value = prefs.getString("theme") ?? "LIGHT";
  }
}
