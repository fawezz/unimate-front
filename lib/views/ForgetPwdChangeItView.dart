import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:univ_chat_gpt/controllers/ForgetPwdController.dart';
import 'package:univ_chat_gpt/custom_widgets/InputField.dart';
import 'package:univ_chat_gpt/custom_widgets/RedButton.dart';

class ChangePwd extends StatelessWidget {
  const ChangePwd({super.key});

  @override
  Widget build(BuildContext context) {
    ForgetPwd controller = Get.put(ForgetPwd());
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.all(24.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            0.09.sh.verticalSpace,
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '''Reset
Password 🔒''',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 42.sp),
              ),
            ),
            0.1.sh.verticalSpace,
            InputField(
                label: "Password",
                prefixIcon: Icons.lock_outline_rounded,
                suffix: true,
                textController: controller.password),
            InputField(
              label: "Confirm Password",
              prefixIcon: Icons.lock_outline_rounded,
              textController: controller.confirmPassword,
              suffix: true,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Text(
                  'Both passwords must match.',
                  style:
                      TextStyle(fontWeight: FontWeight.w400, fontSize: 18.sp),
                ),
              ),
            ),
            0.05.sh.verticalSpace,
            RedButton(
                text: "Change password",
                function: () {
                  controller.changePwd();
                }),
          ],
        ),
      ),
    ));
  }
}
