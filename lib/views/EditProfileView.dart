import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:univ_chat_gpt/app/Colors.dart';
import 'package:univ_chat_gpt/controllers/EditProfileController.dart';
import 'package:univ_chat_gpt/custom_widgets/RedButton.dart';

import '../custom_widgets/InputField.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EditProfileController controller = Get.put(EditProfileController());
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).primaryIconTheme.color),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("Edit Profile"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 0.20.sw,
                  backgroundColor: primaryColor,
                  child: Obx(() => controller.isLoading.value
                      ? Container()
                      : CircleAvatar(
                          radius: 0.197.sw,
                          foregroundImage:
                              Image.network(controller.profileImage.value)
                                  .image)),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: GestureDetector(
                    onTap: () => controller.showAddPictureBottomSheet(),
                    child: Container(
                      height: 0.1.sw,
                      width: 0.1.sw,
                      decoration: BoxDecoration(
                        color: Get.theme.canvasColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: const EdgeInsets.all(2),
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        child: Icon(
                          Icons.camera_enhance,
                          size: 30.sp,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Obx(() => controller.isLoading.value
              ? Container()
              : Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 24.sp),
                      child: Text(
                        controller.email,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                          color: primaryColor.withOpacity(0.8),
                        ),
                      ),
                    ),
                    0.01.sh.verticalSpace,
                    InputField(
                      label: "Full Name",
                      prefixIcon: Icons.person,
                      textController: controller.fullNameController,
                      validatorFunction: controller.validateName,
                    ),
                    0.01.sh.verticalSpace,
                    InputField(
                      label: "Old Password",
                      prefixIcon: Icons.lock_person_outlined,
                      textController: controller.oldPasswordController,
                      validatorFunction: controller.validatePassword,
                    ),
                    0.01.sh.verticalSpace,
                    InputField(
                      label: "New Password",
                      prefixIcon: Icons.lock,
                      textController: controller.passwordController,
                      suffix: true,
                      validatorFunction: controller.validatePassword,
                    ),
                    0.01.sh.verticalSpace,
                    InputField(
                      label: "New Password Confirmation",
                      prefixIcon: Icons.lock_outlined,
                      textController: controller.password2Controller,
                      suffix: true,
                      validatorFunction: controller.validatePasswordsMatching,
                    ),
                  ],
                )),
          0.04.sh.verticalSpace,
          RedButton(text: "Edit", function: () => controller.updateProfile()),
        ]),
      ),
    ));
  }
}
