import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../app/Colors.dart';

class InputField extends StatelessWidget {
  InputField(
      {Key? key,
      required this.label,
      required this.prefixIcon,
      this.suffixIcon,
      required this.textController,
      required,
      this.function,
      this.suffix = false})
      : super(key: key);

  final String label;
  final VoidCallback? function;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final bool suffix;
  RxBool passwordVisible = false.obs;

  Rx<TextEditingController> textController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 20.w, bottom: 8.w),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              height: 0.0818.sh,
              width: 0.88.sw,
              child: Container(
                  width: 0.88.sw,
                  height: 0.07.sh,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: secondaryColor),
                  padding: EdgeInsets.only(left: 10.w, right: 10.w),
                  child: Center(
                      child: Obx(
                    () => TextFormField(
                      controller: textController.value,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText: suffix ? !passwordVisible.value : false.obs.value,
                      style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        hintText: 'please enter your $label...',
                        hintStyle: const TextStyle(color: Colors.white),
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          prefixIcon,
                          color: Colors.white,
                        ),
                        suffixIcon: suffix
                            ? GestureDetector(
                                onTap: suffix == false
                                    ? null
                                    : () {
                                        passwordVisible.value =
                                            !passwordVisible.value;
                                      },
                                child: Obx(
                                  () => Icon(
                                    !passwordVisible.value
                                        ? Icons.remove_red_eye_outlined
                                        : Icons.remove_red_eye,
                                    color: Colors.white,
                                  ),
                                ))
                            : null,
                      ),
                    ),
                  ))),
            ),
          ),
        ],
      ),
    );
  }
}
