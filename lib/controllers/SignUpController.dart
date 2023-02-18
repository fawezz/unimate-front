import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../services/userService.dart';

class SignUpController extends GetxController {
  final nameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final password2Controller = TextEditingController().obs;

  final bool isEmailValid = false;

  Future<void> signUp() async {
    if (validateFields()) {
      EasyLoading.show(status: 'loading...');
      final response = await UserService.postSignUp(nameController.value.text,
          emailController.value.text, passwordController.value.text);
      EasyLoading.dismiss();

      Map<String, dynamic> body = jsonDecode(response.body);
      switch (response.statusCode) {
        case 201:
          {
            EasyLoading.showSuccess(body["message"]);
            Get.offNamed("/login");
          }
          break;
        case 403:
          {
            Alert(
                    context: Get.context!,
                    title: "Attention",
                    desc: body["message"] + " Please, Login")
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
    if (validateName(nameController.value.text) != null ||
        validatePassword(passwordController.value.text) != null ||
        validatePasswordsMatching(password2Controller.value.text) != null ||
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

  String? validateName(String? value) {
    if (!RegExp(
            r"^([a-zA-Z]{2,}\s[a-zA-Z]{1,}'?-?[a-zA-Z]{2,}\s?([a-zA-Z]{1,})?)")
        .hasMatch(value!)) {
      return "Please enter a valid Name";
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

  String? validatePassword(String? value) {
    if (passwordController.value.text.length < 8) {
      return "Password must be at least 8 characters long";
    } else {
      return null;
    }
  }

  String? validatePasswordsMatching(String? value) {
    if (passwordController.value.text != password2Controller.value.text) {
      return "Passwords do not match, please verify";
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
