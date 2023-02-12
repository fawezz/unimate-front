import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:univ_chat_gpt/services/userService.dart';

class LoginController extends GetxController{

  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  final bool isEmailValid = false;



  void login(){
    UserService.postLogin(emailController.value.text, passwordController.value.text);
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



