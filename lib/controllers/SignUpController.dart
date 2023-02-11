import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController{

  final nameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final password2Controller = TextEditingController().obs;

  final bool isEmailValid = false;

  @override
  void onInit() {

    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}



