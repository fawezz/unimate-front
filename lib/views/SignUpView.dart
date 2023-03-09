import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:univ_chat_gpt/app/Routes.dart';
import 'package:univ_chat_gpt/custom_widgets/InputField.dart';
import 'package:univ_chat_gpt/custom_widgets/RedButton.dart';
import '../controllers/SignUpController.dart';

class SignUpView extends StatelessWidget {
  SignUpView({Key? key}) : super(key: key);
  SignUpController controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
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
              16.h.verticalSpace,
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 20.w, bottom: 8.w),
                  child: Text(
                    "Role",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Obx(() => DropdownButton<String>(
                  hint: Text("Role"),
                  value: controller.roleValue.value,
                  items: controller.getRoleDropDownItems,
                  onChanged: (String? value) {
                    controller.roleValue.value = value!;
                  })),
              Obx(() => controller.roleValue.value == controller.roleOptions[1]
                  ? Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 20.w, bottom: 8.w),
                            child: Text(
                              "Level",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        Obx(() => DropdownButton<int>(
                            value: controller.levelValue.value,
                            items: controller.getLevelDropDownItems,
                            onChanged: (int? value) {
                              controller.levelValue.value = value!;
                            })),
                      ],
                    )
                  : Container()),
              Obx(() => controller.levelValue.value > 2 &&
                      controller.roleValue.value == controller.roleOptions[1]
                  ? Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 20.w, bottom: 8.w),
                            child: Text(
                              "Speciality",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        Obx(() => DropdownButton(
                            value: controller.specialityValue.value,
                            items: controller.getSpecialityDropDownItems,
                            onChanged: (String? value) {
                              controller.specialityValue.value = value!;
                            })),
                      ],
                    )
                  : Container()),
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
