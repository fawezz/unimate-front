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
  final classeController = TextEditingController().obs;
  RxInt levelValue = 1.obs;
  RxInt classeValue = 1.obs;
  RxString specialityValue = ''.obs;
  RxString roleValue = "Guest".obs;
  final specialityOptions3rdYear = <String>[
    'A',
    'B',
  ];
  final specialityOptions4thYear = <String>[
    'SIM',
    'TWIN',
    'SLEAM',
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
      int? classe = classeValue.value;

      if (roleValue.value != roleOptions[1]) {
        // not a student
        lvl = speciality = classe = null;
      } else {
        // a student
        if ((lvl) < 3) {
          speciality = "A";
        }
      }

      final response = await UserService.postSignUp(
          nameController.value.text,
          emailController.value.text,
          passwordController.value.text,
          roleValue.value,
          lvl,
          speciality,
          classe);
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
    if (roleValue.value == roleOptions[1] &&
        validateClasse(classeController.value.text) != null) {
      Alert(
              context: Get.context!,
              title: "Attention",
              desc: "Your class number is required")
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

  String? validateClasse(String? value) {
    if (classeController.value.isBlank! || value!.isEmpty) {
      return "required field";
    } else {
      if (!value.isNumericOnly) {
        return "invalid class";
      }
    }
    classeValue.value = int.parse(value);
    return null;
  }

  List<DropdownMenuItem<String>> get getRoleDropDownItems {
    List<DropdownMenuItem<String>> menuItems = roleOptions
        .map((String e) => DropdownMenuItem(value: e, child: Text(e)))
        .toList();
    return menuItems;
  }

  List<DropdownMenuItem<int>> get getLevelDropDownItems {
    List<DropdownMenuItem<int>> menuItems = levelOptions
        .map((int e) => DropdownMenuItem(value: e, child: Text("$e")))
        .toList();
    return menuItems;
  }

  List<DropdownMenuItem<String>> get getSpecialityDropDownItems {
    List<String> options = levelValue.value == 3
        ? specialityOptions3rdYear
        : specialityOptions4thYear;
    print(specialityValue.value);
    List<DropdownMenuItem<String>> menuItems = options
        .map((String e) => DropdownMenuItem(value: e, child: Text(e)))
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
