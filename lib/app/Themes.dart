import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:univ_chat_gpt/app/Colors.dart';

class Themes {
  static void changeTheme(String? theme) {
    switch (theme) {
      case "LIGHT":
        {
          Get.changeTheme(ThemeData.light());
        }
        break;
      case "DARK":
        {
          Get.changeTheme(ThemeData.dark());
        }
        break;
      default:
        {
          Get.changeTheme(
            SchedulerBinding.instance?.window.platformBrightness ==
                    Brightness.light
                ? ThemeData.light()
                : ThemeData.dark(),
          );
        }
        break;
    }
  }

  static ThemeData get lightTheme {
    return ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.white,
        iconTheme: IconThemeData(color: primaryColor));
  }

  static ThemeData get darkTheme {
    return ThemeData(
      canvasColor: secondaryColor,
      colorScheme: ColorScheme.dark(
        primary: primaryColor,
        secondary: primaryColor
      ),
      scaffoldBackgroundColor: secondaryColor,
      
    );
  }
}
