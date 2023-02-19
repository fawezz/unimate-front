import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:univ_chat_gpt/app/Routes.dart';
import 'package:univ_chat_gpt/services/userService.dart';

class ForgetPwd extends GetxController {
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final confirmPasswordController = TextEditingController().obs;

  late final String email;

  final otp1Controller = TextEditingController().obs;
  final otp2Controller = TextEditingController().obs;
  final otp3Controller = TextEditingController().obs;
  final otp4Controller = TextEditingController().obs;

  //Sending OTP Post Request
  Future<void> sendOTP() async {
    if (validateEmail(emailController.value.text) == null) {
      EasyLoading.show(status: 'loading...');
      final response =
          await UserService.postSendOTP(emailController.value.text);
      EasyLoading.dismiss();

      Map<String, dynamic> body = jsonDecode(response.body);
      switch (response.statusCode) {
        case 200:
          {
            EasyLoading.showSuccess(
                "OTP Sent To ${emailController.value.text}");
            email = emailController.value.text;
            await Future.delayed(const Duration(milliseconds: 1000));
            EasyLoading.dismiss();

            Get.toNamed(NamedRoutes.forgetPwdOTP);
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
    } else {
      Alert(
              context: Get.context!,
              title: "Attention",
              desc: "Please fill the required fields")
          .show();
    }
  }

  //Verifying OTP Post Request
  Future<void> verifyOTP() async {
    if (otpCollectorAndParser() != -1) {
      EasyLoading.show(status: 'loading...');
      print(email + "from verif orp");
      final response =
          await UserService.postVerifyOTP(email, otpCollectorAndParser());
      EasyLoading.dismiss();

      Map<String, dynamic> body = jsonDecode(response.body);
      switch (response.statusCode) {
        case 200:
          {
            EasyLoading.showSuccess("Success");
            await Future.delayed(const Duration(milliseconds: 700));
            EasyLoading.dismiss();
            Alert(context: Get.context!, title: "Done").show();
            Get.offAndToNamed(NamedRoutes.resetPwd);
          }
          break;
        case 403:
          {
            Alert(
                    context: Get.context!,
                    title: "Wrong OTP",
                    desc: body["message"])
                .show();
          }
          break;
        default:
          {
            Alert(
                    context: Get.context!,
                    title: "Please Verify",
                    desc: body["message"])
                .show();
          }
          break;
      }
    } else {
      Alert(
              context: Get.context!,
              title: "Attention",
              desc: "please fill in the otp code sent to your email.")
          .show();
    }
  }

  //Fun to Get value of each OTP field , collect them as a string then parse it to Int and return it
  int otpCollectorAndParser() {
    if (otp1Controller.value.text != "" &&
        otp2Controller.value.text != "" &&
        otp3Controller.value.text != "" &&
        otp4Controller.value.text != "") {
      return int.parse(otp1Controller.value.text +
          otp2Controller.value.text +
          otp3Controller.value.text +
          otp4Controller.value.text);
    }
    return -1;
  }

  //Changing Pwd Post Request
  Future<void> resetPwd() async {
    if (comparePwd()) {
      EasyLoading.show(status: 'loading...');
      SharedPreferences pref = await SharedPreferences.getInstance();
      final response = await UserService.putResetPwd(
          pref.getString("email")!, passwordController.value.text);
      EasyLoading.dismiss();
      Map<String, dynamic> body = jsonDecode(response.body);
      switch (response.statusCode) {
        case 200:
          {
            EasyLoading.showSuccess("Success ✅\nPassword Changed");
            await Future.delayed(const Duration(milliseconds: 1000));
            EasyLoading.dismiss();
            Get.offAllNamed('/login');
          }
          break;
        case 404:
          {
            Alert(context: Get.context!, title: "Error", desc: body["message"])
                .show();
          }
          break;
        default:
          {
            Alert(
                    context: Get.context!,
                    title: "Error",
                    desc: "Passwords do not match")
                .show();
          }
          break;
      }
    } else {
      Alert(
              context: Get.context!,
              title: "Attention",
              desc: "Please fill the fields correctly.")
          .show();
    }
  }

  //Fun to Compare Passwords Before sending the Request
  bool comparePwd() {
    if (passwordController.value.text != confirmPasswordController.value.text ||
        validatePassword("") != null) {
      return false;
    } else {
      return true;
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
    if (passwordController.value.text != confirmPasswordController.value.text) {
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
    emailController.value.dispose();
    passwordController.value.dispose();
    confirmPasswordController.value.dispose();
    otp1Controller.value.dispose();
    otp2Controller.value.dispose();
    otp3Controller.value.dispose();
    otp4Controller.value.dispose();
  }
}
