import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:univ_chat_gpt/controllers/ForgetPwdController.dart';
import 'package:univ_chat_gpt/custom_widgets/InputField.dart';
import 'package:univ_chat_gpt/custom_widgets/RedButton.dart';
import 'package:univ_chat_gpt/app/Colors.dart' as color;

class ForgetPwdEmail extends StatelessWidget {
  const ForgetPwdEmail({super.key});

  @override
  Widget build(BuildContext context) {
    ForgetPwd controller = Get.put(ForgetPwd());
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.fromLTRB(24.sp, 50.sp, 24.sp, 24.sp),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(children: [
              0.1.sh.verticalSpace,
              Text(
                "Forget Password? 😕",
                style: TextStyle(
                    color: color.secondaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              0.1.sh.verticalSpace,
              const Text(
                "Please Enter the email address associated with your account",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
              0.07.sh.verticalSpace,
              Text(
                "We will email you an OTP to reset your password.",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
              ),
              0.1.sh.verticalSpace,
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: InputField(
                  label: "Email",
                  prefixIcon: Icons.email,
                  textController: controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                  validatorFunction: controller.validateEmail,
                ),
              ),
              0.1.sh.verticalSpace,
              RedButton(
                  text: "Confirm",
                  width: 0.4.sw,
                  function: () {
                    controller.sendOTP();
                  }),
            ]),
          ),
        ),
      ),
    );
  }
}
