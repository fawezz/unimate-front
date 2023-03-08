import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../services/UserService.dart';

class SignUpController extends GetxController {
  final nameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final password2Controller = TextEditingController().obs;
  RxInt levelValue = 1.obs;
  RxString specialityValue = 'SIM'.obs;
  RxString roleValue = "Guest".obs;
  final specialityOptions = <String>[
    'SIM',
    'TWIN ',
    'SLEAM ',
    'NIDS',
    'SE',
    'ArcTIC'
  ];
  final roleOptions = <String>["Guest", "Student", "Teacher"];
  final levelOptions = <int>[1, 2, 3, 4, 5];
  final bool isEmailValid = false;

  Future<void> signUp() async {
    if (validateFields()) {
      EasyLoading.show(status: 'loading...');
      int? lvl = levelValue.value;
      String? speciality = specialityValue.value;
      if (roleValue.value != roleOptions[1]) {
        lvl = speciality = null;
      }
      if ((lvl ?? 0) < 3) {
        speciality = null;
      }
      final response = await UserService.postSignUp(
          nameController.value.text,
          emailController.value.text,
          passwordController.value.text,
          roleValue.value,
          lvl,
          speciality);
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

  List<DropdownMenuItem<String>> get getRoleDropDownItems {
    List<DropdownMenuItem<String>> menuItems = roleOptions
        .map((String e) => DropdownMenuItem(child: Text(e), value: e))
        .toList();
    return menuItems;
  }

  List<DropdownMenuItem<int>> get getLevelDropDownItems {
    List<DropdownMenuItem<int>> menuItems = levelOptions
        .map((int e) => DropdownMenuItem(child: Text("$e"), value: e))
        .toList();
    return menuItems;
  }

  List<DropdownMenuItem<String>> get getSpecialityDropDownItems {
    List<DropdownMenuItem<String>> menuItems = specialityOptions
        .map((String e) => DropdownMenuItem(child: Text(e), value: e))
        .toList();
    return menuItems;
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
