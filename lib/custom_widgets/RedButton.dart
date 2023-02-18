import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:univ_chat_gpt/app/Colors.dart';

class RedButton extends StatelessWidget {
  const RedButton(
      {Key? key,
      required this.text,
      required this.function,
      this.height,
      this.width})
      : super(key: key);

  final String text;
  final double? height;
  final double? width;
  final VoidCallback function;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 0.7.sw,
      height: height ?? 0.06.sh,
      decoration: ShapeDecoration(
        shape: const StadiumBorder(),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [primaryColor, primaryColor.withOpacity(0.8), primaryColor],
        ),
      ),
      child: MaterialButton(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onPressed: function,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 26.sp,
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }
}
