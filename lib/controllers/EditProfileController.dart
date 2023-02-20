import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:univ_chat_gpt/services/userService.dart';

import '../models/UserModel.dart';

class EditProfileController extends GetxController {
  final fullNameController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final password2Controller = TextEditingController().obs;
  final oldPasswordController = TextEditingController().obs;

  Rx<User?>? currentUser;
  late final String fullName;
  late final String email;
  Rx<String> profileImage = "".obs;
  Rx<bool> isLoading = true.obs;

  @override
  Future<void> onInit() async {
    EasyLoading.show(
        status: 'Loading..',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black);
    isLoading.value = true;
    final user = await UserService.getCurrentProfile();
    currentUser = user.obs;
    if (currentUser?.value != null) {
      email = currentUser?.value?.email ?? "default email";
      fullName = currentUser?.value?.fullname ?? "default name";
      //profileImage = currentUser?.value?.pic ?? "";
      profileImage.value = "assets/icons/seller.jpg";
      fullNameController.value.text = fullName;
      isLoading.value = false;
      EasyLoading.dismiss();
    }
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> updateProfile() async {
    if (fullNameController.value.text == fullName &&
        passwordController.value.text == "") {
      _showToast("No changes made");
    } else {
      EasyLoading.show(status: 'loading...');
      final response = await UserService.putUpdateProfile(
          fullNameController.value.text, passwordController.value.text);
      Map<String, dynamic> body = jsonDecode(response.body);
      EasyLoading.dismiss();
      switch (response.statusCode) {
        case 200:
          {
            EasyLoading.showSuccess(body["message"]);
            await Future.delayed(const Duration(milliseconds: 700));
            Get.back();
          }
          break;
        default:
          {
            Alert(context: Get.context!, title: "Error", desc: body["message"])
                .show();
          }
          break;
      }
    }
  }

  bool validateFields() {
    if (validateName(fullNameController.value.text) != null ||
        validatePassword(passwordController.value.text) != null ||
        validatePasswordsMatching(password2Controller.value.text) != null ||
        validatePassword(passwordController.value.text) != null) {
      Alert(
              context: Get.context!,
              title: "Attention",
              desc: "Please fill all fields correctly")
          .show();
      return false;
    }
    return true;
  }

  String? validateName(String? value) {
    if (!RegExp(
            r"^([a-zA-Z]{2,}\s[a-zA-Z]{1,}'?-?[a-zA-Z]{2,}\s?([a-zA-Z]{1,})?)")
        .hasMatch(value!)) {
      return "Please enter a valid Name";
    } else {
      return null;
    }
  }

  String? validatePassword(String? value) {
    if (passwordController.value.text.length < 8) {
      return "Password must be at least 8 characters long";
    } else {
      return null;
    }
  }

  String? validatePasswordsMatching(String? value) {
    if (passwordController.value.text != password2Controller.value.text) {
      return "Passwords do not match, please verify";
    } else {
      return null;
    }
  }

  _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.redAccent.withOpacity(0.8),
        textColor: Colors.white,
        fontSize: 14.0);
  }

// SELECT IMAGE
  final ImagePicker _picker = ImagePicker();
  Rx<File>? imageFile;

  void selectImage(String _source) async {
    XFile? selectedImage;
    selectedImage = await _picker.pickImage(
        source: _source == "CAMERA" ? ImageSource.camera : ImageSource.gallery);
    if (selectedImage == null) {
      return;
    }
    imageFile?.value = File(selectedImage.path);
  }

  showAddPictureBottomSheet() {
    showModalBottomSheet(
        context: Get.context!,
        builder: (BuildContext context) {
          return Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            child: Wrap(children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                          child: Container(
                        height: 8,
                        width: 66,
                        decoration: BoxDecoration(
                            color: HexColor("##EBEBEB"),
                            borderRadius: BorderRadius.circular(10)),
                      )),
                      0.03.sh.verticalSpace,
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () async {
                            if (await Permission.camera.request().isGranted) {
                              selectImage("CAMERA");
                            } else {
                              _showToast("Camera Permission Denied");
                            }
                          },
                          child: Row(children: [
                            Container(
                              height: 40.h,
                              width: 40.h,
                              decoration: BoxDecoration(
                                  color: HexColor("#EBEFF2"),
                                  borderRadius: BorderRadius.circular(40)),
                              child: const Icon(Icons.camera_enhance_outlined),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 14),
                              child: Text(
                                "Camera",
                                style: TextStyle(
                                    color: HexColor("#0A3C5F"),
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () async {
                            if (await Permission.storage.request().isGranted) {
                              selectImage("GALLERY");
                            } else {
                              _showToast("Storage Permission Denied");
                            }
                          },
                          child: Row(children: [
                            Container(
                              height: 40.h,
                              width: 40.h,
                              decoration: BoxDecoration(
                                  color: HexColor("#EBEFF2"),
                                  borderRadius: BorderRadius.circular(40)),
                              child: const Icon(Icons.image),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 14),
                              child: Text(
                                "Gallery",
                                style: TextStyle(
                                    color: HexColor("#0A3C5F"),
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ]),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ]),
          );
        });
  }
}
