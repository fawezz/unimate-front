import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:univ_chat_gpt/app/Colors.dart';
import 'package:univ_chat_gpt/app/Routes.dart';
import 'package:univ_chat_gpt/services/UserService.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  final bool isEmailValid = false;

  Future<void> login() async {
    if (validateFields()) {
      EasyLoading.show(status: 'loading...');
      final response = await UserService.postLogin(
          emailController.value.text, passwordController.value.text);
      EasyLoading.dismiss();

      Map<String, dynamic> body = jsonDecode(response.body);
      switch (response.statusCode) {
        case 200:
          {
            EasyLoading.showSuccess("Success");
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString("token", body["token"]);
            await Future.delayed(const Duration(milliseconds: 700));
            EasyLoading.dismiss();
            /*Fluttertoast.showToast(
                msg: body["message"],
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: primaryColor.withOpacity(0.8),
                textColor: Colors.white,
                fontSize: 14.0);
                */
            Get.offAllNamed(NamedRoutes.home);
          }
          break;
        case 403:
          {
            Alert(
                    context: Get.context!,
                    title: "Attention",
                    desc: body["message"])
                .show();
          }
          break;
        default:
          {
            Alert(context: Get.context!, title: "Error", desc: body["message"])
                .show();
          }
          break;
      }
    }
  }

  bool validateFields() {
    if (passwordController.value.text.isEmpty ||
        emailController.value.text.isEmpty ||
        validateEmail(emailController.value.text) != null ||
        validatePassword(passwordController.value.text) != null) {
      Alert(
              context: Get.context!,
              title: "Attention",
              desc: "Please fill all fields correctly")
          .show();
      return false;
    }
    return true;
  }

  String? validatePassword(String? value) {
    if (passwordController.value.text.length < 8) {
      return "Password must be more than 7 characters";
    } else {
      return null;
    }
  }

  String? validateEmail(String? value) {
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z][a-zA-Z]+")
        .hasMatch(value!)) {
      return "Please enter a valid Email";
    } else {
      return null;
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
