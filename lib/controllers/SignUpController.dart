import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../services/userService.dart';

class SignUpController extends GetxController{

  final nameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final password2Controller = TextEditingController().obs;

  final bool isEmailValid = false;

  Future<void> signUp() async {
    if(validateFields()){
      EasyLoading.show(status: 'loading...');
      final response = await UserService.postSignUp(nameController.value.text, emailController.value.text,
          passwordController.value.text);
      EasyLoading.dismiss();

      Map<String, dynamic> body = jsonDecode(response.body);
      switch(response.statusCode) {
        case 201: {
          EasyLoading.showSuccess(body["message"]);
          Get.offNamed("/login");
        }
        break;
        case 403: {
          Alert(context: Get.context!, title: "Attention", desc: body["message"] + " Please, Login").show();
        }
        break;
        default: {
          Alert(context: Get.context!, title: "Error", desc: body["message"]).show();
        }
        break;
      }
    }
  }

  bool validateFields(){
    if(passwordController.value.text.isEmpty || password2Controller.value.text.isEmpty
        || emailController.value.text.isEmpty || nameController.value.text.isEmpty ){
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
          desc: "Password must be at least 8 characters long").show();
      return false;
    }
    if(passwordController.value.text != password2Controller.value.text){
      Alert(context: Get.context!, title: "Mismatched Passwords",
          desc: "The password field does not match the password confirmation").show();
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



