import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:univ_chat_gpt/app/Routes.dart';
import 'package:univ_chat_gpt/custom_widgets/InputField.dart';
import 'package:univ_chat_gpt/custom_widgets/RedButton.dart';
import '../app/Colors.dart';
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
              Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.w, bottom: 8.w),
                      child: SizedBox(
                        width: 0.25.sw,
                        child: Text(
                          "Role",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: 0.25.sw,
                    child: Obx(() => DropdownButton<String>(
                        isExpanded: true,
                        hint: const Text("Role"),
                        value: controller.roleValue.value,
                        items: controller.getRoleDropDownItems,
                        onChanged: (String? value) {
                          controller.roleValue.value = value!;
                          controller.classeController.value.clear();
                        })),
                  ),
                  Spacer()
                ],
              ),
              Obx(() => controller.roleValue.value == controller.roleOptions[1]
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20.w, bottom: 8.w),
                          child: SizedBox(
                            width: 0.25.sw,
                            child: Text(
                              "Level",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: 0.25.sw,
                          child: Obx(() => DropdownButton<int>(
                              isExpanded: true,
                              value: controller.levelValue.value,
                              items: controller.getLevelDropDownItems,
                              onChanged: (int? value) {
                                controller.levelValue.value = value!;

                                controller.specialityValue.value =
                                    controller.levelValue.value == 3
                                        ? controller.specialityOptions3rdYear[0]
                                        : controller
                                            .specialityOptions4thYear[0];
                              })),
                        ),
                        Spacer()
                      ],
                    )
                  : Container()),
              Obx(() => controller.levelValue.value > 2 &&
                      controller.roleValue.value == controller.roleOptions[1]
                  ? Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20.w, bottom: 8.w),
                          child: SizedBox(
                            width: 0.25.sw,
                            child: Text(
                              "Speciality",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        Obx(
                          () => Container(
                            width: 0.25.sw,
                            child: DropdownButton(
                                isExpanded: true,
                                value: controller.specialityValue.value,
                                items: controller.getSpecialityDropDownItems,
                                onChanged: (String? value) {
                                  controller.specialityValue.value = value!;
                                }),
                          ),
                        ),
                        Spacer()
                      ],
                    )
                  : Container()),
              Obx(() => controller.roleValue.value == controller.roleOptions[1]
                  ? Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: Row(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 20.w, bottom: 8.w),
                              child: SizedBox(
                                width: 0.25.sw,
                                child: Text(
                                  "Class",
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                            width: 0.3.sw,
                            child: Obx(
                              () => TextFormField(
                                controller: controller.classeController.value,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.number,
                                maxLength: 2,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .appBarTheme
                                        .titleTextStyle
                                        ?.color,
                                    fontSize: 16.sp),
                                textAlignVertical: TextAlignVertical.center,
                                decoration: InputDecoration(
                                    hintText: "class number",
                                    fillColor: secondaryColor,
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 10.0),
                                    counterText: ""),
                                validator: controller.validateClasse,
                              ),
                            ),
                          ),
                          Spacer()
                        ],
                      ),
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
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
