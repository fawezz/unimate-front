import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:univ_chat_gpt/app/Colors.dart';
import 'package:univ_chat_gpt/app/Routes.dart';
import 'package:univ_chat_gpt/controllers/LoginController.dart';
import 'package:univ_chat_gpt/custom_widgets/InputField.dart';
import 'package:univ_chat_gpt/custom_widgets/RedButton.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);
  LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      //resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.sp),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //0.05.sh.verticalSpace,
              Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  width: 0.25.sw,
                  height: 0.08.sh,
                  child: Image.asset(Get.isDarkMode
                      ? "assets/icons/espritDark.png"
                      : "assets/icons/espritLight.png"),
                ),
              ),
              SizedBox(
                height: 0.65.sw,
                width: 0.65.sw,
                child: Positioned(
                  left: 8,
                  child: CircleAvatar(
                    radius: Get.width * 0.2,
                    backgroundColor: Colors.transparent,
                    backgroundImage:
                        Image.asset("assets/icons/appLogo.png").image,
                  ),
                ),
              ),
              Text(
                'Welcome Back!',
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'Please, Login',
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              0.05.sh.verticalSpace,
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
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(NamedRoutes.forgetPwdEmail);
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp),
                    ),
                  ),
                ),
              ),
              0.05.sh.verticalSpace,
              RedButton(
                  text: "Login",
                  function: () {
                    print('login');
                    controller.login();
                  }),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15.h),
                child: GestureDetector(
                  onTap: () {
                    Get.offAndToNamed(NamedRoutes.signUp);
                  },
                  child: const Text(
                    'new user? Register now !',
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
