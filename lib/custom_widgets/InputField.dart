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
                  fontSize: 16.sp,
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
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      decoration: InputDecoration(
                        hintText: 'please enter your $label...',
                        hintStyle: const TextStyle(color: Colors.white),
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          prefixIcon,
                          color: Colors.white,
                        ),
                        suffixIcon: Icon(
                          suffixIcon,
                          color: Colors.white,
                        ),
                      ),
                      validator: (String? value) {
                        return value!.isEmpty ? 'this field is required' : null;
                      },
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
