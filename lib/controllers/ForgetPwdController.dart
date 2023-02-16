import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:univ_chat_gpt/services/userService.dart';

class ForgetPwd extends GetxController {
  //Getting The email from ForgetPwdView
  final emailAddress = TextEditingController().obs;
  //Getting Password&Confirm FromForgetPwdChangeItView
  final password = TextEditingController().obs;
  final confirmPassword = TextEditingController().obs;

  //Creating Controllers to the OTP Fields
  late Rx<TextEditingController> otp1Controller;
  late Rx<TextEditingController> otp2Controller;
  late Rx<TextEditingController> otp3Controller;
  late Rx<TextEditingController> otp4Controller;

  //Refering to the fields To acces their Values
  final otp1 = TextEditingController().obs;
  final otp2 = TextEditingController().obs;
  final otp3 = TextEditingController().obs;
  final otp4 = TextEditingController().obs;

  //Sending OTP Post Request
  Future<void> sendOTP() async {
    if (true) {
      EasyLoading.show(status: 'loading...');
      final response = await UserService.postSendOTP(emailAddress.value.text);
      EasyLoading.dismiss();

      Map<String, dynamic> body = jsonDecode(response.body);
      switch (response.statusCode) {
        case 200:
          {
            EasyLoading.showSuccess("Success");
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString("email", emailAddress.value.text);
            await Future.delayed(const Duration(milliseconds: 700));
            EasyLoading.dismiss();
            Alert(
                    context: Get.context!,
                    title: "OTP Sended To ${emailAddress.value.text}")
                .show();
            Get.offAndToNamed('/forgetPwd');
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

  //Verifying OTP Post Request
  Future<void> verifyOTP() async {
    if (otpCollectorAndParser() != 0) {
      EasyLoading.show(status: 'loading...');
      SharedPreferences pre = await SharedPreferences.getInstance();
      final response = await UserService.postVerifyOTP(
          pre.getString("email")!, otpCollectorAndParser());
      EasyLoading.dismiss();

      Map<String, dynamic> body = jsonDecode(response.body);
      switch (response.statusCode) {
        case 200:
          {
            EasyLoading.showSuccess("Success");
            await Future.delayed(const Duration(milliseconds: 700));
            EasyLoading.dismiss();
            Alert(context: Get.context!, title: "Done").show();
            Get.offAndToNamed('/changePwd');
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
    }
  }

  //Fun to Get value of each OTP field , collect them as a string then parse it to Int and return it
  int otpCollectorAndParser() {
    if (otp1.value.text != "" &&
        otp2.value.text != "" &&
        otp3.value.text != "" &&
        otp4.value.text != "") {
      return int.parse(otp1.value.text +
          otp2.value.text +
          otp3.value.text +
          otp4.value.text);
    }
    return 0;
  }

  //Changing Pwd Post Request
  Future<void> changePwd() async {
    if (comparePwd()) {
      EasyLoading.show(status: 'loading...');
      SharedPreferences pref = await SharedPreferences.getInstance();
      final response = await UserService.putResetPwd(
          pref.getString("email")!, password.value.text);
      EasyLoading.dismiss();
      Map<String, dynamic> body = jsonDecode(response.body);
      switch (response.statusCode) {
        case 200:
          {
            EasyLoading.showSuccess("Success ✅");
            await Future.delayed(const Duration(milliseconds: 700));
            EasyLoading.dismiss();
            Alert(context: Get.context!, title: "Password Changed").show();
            Get.offAndToNamed('/login');
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
                    title: "Failure ⚠️",
                    desc: "Password doest confirm")
                .show();
          }
          break;
      }
    }
  }

  //Fun to Compare Passwords Before sending the Request
  bool comparePwd() {
    if (password.value.text != confirmPassword.value.text) {
      return false;
    } else {
      return true;
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
