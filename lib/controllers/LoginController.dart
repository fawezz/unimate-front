import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:univ_chat_gpt/services/userService.dart';

import '../models/UserModel.dart';

class LoginController extends GetxController{

  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  final bool isEmailValid = false;



  Future<void> login() async {
    if(validateFields()){
      EasyLoading.show(status: 'loading...');
      final response = await UserService.postLogin(emailController.value.text, passwordController.value.text);
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
            Alert(context: Get.context!, title: "Success", desc: body["token"])
                .show();
            //Get.toNamed("/test");
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

  bool validateFields(){
    if(passwordController.value.text.isEmpty || emailController.value.text.isEmpty ){
      Alert(context: Get.context!, title: "Required Fields",
          desc: "Please fill all fields").show();
      return false;
    }
    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]+")
        .hasMatch(emailController.value.text)) {
      Alert(context: Get.context!, title: "Invalid Email", desc: "Please enter a valid Email").show();
      return false;
    }
    if(passwordController.value.text.length < 8){
      Alert(context: Get.context!, title: "Password too weak",
          desc: "Minimum length for Passwords is 8 characters").show();
      return false;
    }
    return true;
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



