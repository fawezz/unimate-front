import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:univ_chat_gpt/app/Colors.dart';
import 'package:univ_chat_gpt/controllers/LoginController.dart';
import 'package:univ_chat_gpt/custom_widgets/InputField.dart';
import 'package:univ_chat_gpt/custom_widgets/RedButton.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginController controller = Get.put(LoginController());
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
              SizedBox(
                height: 0.4.sw,
                width: 0.4.sw,
                child: Positioned(
                  left: 8,
                  child: CircleAvatar(
                    radius: Get.width * 0.116,
                    backgroundColor: primaryColor,
                    //backgroundImage: Image.asset("assets/icons/seller.jpg").image,
                  ),
                ),
              ),
              0.05.sh.verticalSpace,
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
                  textController: controller.emailController),
              InputField(
                label: "Password",
                prefixIcon: Icons.lock,
                textController: controller.passwordController,
                suffix: true,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: GestureDetector(
                    onTap: () {
                      print('forgot');
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
                    Get.offAndToNamed('/signUp');
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
