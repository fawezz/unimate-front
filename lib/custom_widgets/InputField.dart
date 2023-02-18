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
      this.validatorFunction,
      this.keyboardType,
      this.suffix = false})
      : super(key: key);

  final String label;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final bool suffix;
  RxBool passwordVisible = false.obs;
  TextInputType? keyboardType;
  final String? Function(String?)? validatorFunction;

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
              width: 0.88.sw,
              child: Obx(
                () => TextFormField(
              controller: textController.value,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              obscureText: suffix ? !passwordVisible.value : false.obs.value,
              keyboardType: keyboardType,
              style: TextStyle(color: Colors.white, fontSize: 16.sp),
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                filled: true,
                fillColor: secondaryColor,
                hintText: 'please enter your $label...',
                hintStyle: const TextStyle(color: Colors.white),
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                ),
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
              validator: validatorFunction,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
