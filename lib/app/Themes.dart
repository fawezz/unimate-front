import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:univ_chat_gpt/app/Colors.dart';

class Themes {
  static RxBool isDark = false.obs;
  static Rx<ThemeMode> currentThemeMode = (ThemeMode.system).obs;

  static Future<void> saveTheme(String? theme) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("theme", theme!);
    setTheme(theme);
  }

  static void setTheme(String? theme) {
    switch (theme) {
      case "LIGHT":
        {
          //Get.changeTheme(Themes.lightTheme);
          currentThemeMode.value = ThemeMode.light;
          isDark.value = false;
        }
        break;
      case "DARK":
        {
          //Get.changeTheme(Themes.darkTheme);
          currentThemeMode.value = ThemeMode.dark;
          isDark.value = true;
        }
        break;
      default:
        {
          currentThemeMode.value = ThemeMode.system;
          isDark.value = SchedulerBinding.instance.window.platformBrightness ==
                  Brightness.light
              ? false
              : true;
        }
        break;
    }
  }

  static ThemeData get lightTheme {
    return ThemeData(
      appBarTheme: AppBarTheme(
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.sp),
        actionsIconTheme: const IconThemeData(color: textColorLight),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: primaryColor),
      primaryColor: primaryColor,
      colorScheme: ColorScheme.light(tertiary: Colors.grey[200]),
      scaffoldBackgroundColor: Colors.white,
      iconTheme: IconThemeData(color: primaryColor),
      primaryIconTheme: const IconThemeData(
        color: Colors.black,
      ),
      textSelectionTheme: TextSelectionThemeData(cursorColor: primaryColor),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.grey[850],
        titleTextStyle: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.sp),
        actionsIconTheme: const IconThemeData(color: textColorDark),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: primaryColor,),
      primaryColor: primaryColor,
      colorScheme: ColorScheme.dark(tertiary: HexColor("B2B3B7").withOpacity(0.15), secondary: primaryColor),
      iconTheme: IconThemeData(color: primaryColor,),
      primaryIconTheme: const IconThemeData(
        color: Colors.white,
      ),
      textSelectionTheme: TextSelectionThemeData(cursorColor: primaryColor),
    );
  }
}
