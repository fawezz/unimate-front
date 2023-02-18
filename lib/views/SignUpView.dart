import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:univ_chat_gpt/app/Routes.dart';
import 'package:univ_chat_gpt/custom_widgets/InputField.dart';
import 'package:univ_chat_gpt/custom_widgets/RedButton.dart';
import '../controllers/SignUpController.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SignUpController controller = Get.put(SignUpController());
    return SafeArea(
        child: Scaffold(
      //resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.all(24.sp),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              0.05.sh.verticalSpace,
              Text(
                'Join Us!',
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'Create an account',
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              0.05.sh.verticalSpace,
              InputField(
                label: "Full Name",
                prefixIcon: Icons.person,
                textController: controller.nameController,
                validatorFunction: controller.validateName,
              ),
              InputField(
                label: "Email",
                prefixIcon: Icons.email,
                textController: controller.emailController,
                validatorFunction: controller.validateEmail,
                keyboardType: TextInputType.emailAddress,
              ),
              InputField(
                label: "Password",
                prefixIcon: Icons.lock,
                textController: controller.passwordController,
                suffix: true,
                validatorFunction: controller.validatePassword,
              ),
              InputField(
                label: "Password Confirmation",
                prefixIcon: Icons.lock_outlined,
                textController: controller.password2Controller,
                suffix: true,
                validatorFunction: controller.validatePasswordsMatching,
              ),
              0.05.sh.verticalSpace,
              RedButton(
                  text: "Register",
                  function: () {
                    controller.signUp();
                  }),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15.h),
                child: GestureDetector(
                  onTap: () {
                    Get.offAndToNamed(NamedRoutes.login);
                  },
                  child: const Text(
                    'I’m already a member !',
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
