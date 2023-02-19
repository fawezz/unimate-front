import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:univ_chat_gpt/controllers/ForgetPwdController.dart';
import 'package:univ_chat_gpt/custom_widgets/RedButton.dart';
import 'package:univ_chat_gpt/app/Colors.dart' as color;

class ForgetPwdOTPView extends StatelessWidget {
  const ForgetPwdOTPView({super.key});

  @override
  Widget build(BuildContext context) {
    double otpFieldWidth = 64;
    double otpFieldHeight = 68;
    ForgetPwd controller = Get.find();
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.all(24.sp),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(children: [
              0.15.sh.verticalSpace,
              Text(
                "OTP",
                style: TextStyle(
                    color: color.primaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              0.1.sh.verticalSpace,
              const Text(
                "Enter the verification Code We just sent you on your email address",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
              0.1.sh.verticalSpace,
              Form(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: otpFieldHeight.h,
                        width: otpFieldWidth.w,
                        child: TextFormField(
                          controller: controller.otp1Controller.value,
                          onChanged: (value) => {
                            FocusScope.of(context).nextFocus(),
                          },
                          decoration: const InputDecoration(
                            hintText: "0",
                            contentPadding: EdgeInsets.all(10.0),
                          ),
                          style: Theme.of(context).textTheme.headline6,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      SizedBox(
                        height: otpFieldHeight.h,
                        width: otpFieldWidth.w,
                        child: TextFormField(
                          controller: controller.otp2Controller.value,
                          onChanged: (value) => {
                            FocusScope.of(context).nextFocus(),
                          },
                          decoration: const InputDecoration(
                            hintText: "0",
                            contentPadding: EdgeInsets.all(10.0),
                          ),
                          style: Theme.of(context).textTheme.headline6,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      SizedBox(
                        height: otpFieldHeight.h,
                        width: otpFieldWidth.w,
                        child: TextFormField(
                          controller: controller.otp3Controller.value,
                          onChanged: (value) => {
                            FocusScope.of(context).nextFocus(),
                          },
                          decoration: const InputDecoration(
                            hintText: "0",
                            contentPadding: EdgeInsets.all(10.0),
                          ),
                          style: Theme.of(context).textTheme.headline6,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      SizedBox(
                        height: otpFieldHeight.h,
                        width: otpFieldWidth.w,
                        child: TextFormField(
                          controller: controller.otp4Controller.value,
                          onChanged: (value) => {
                            FocusScope.of(context).nextFocus(),
                          },
                          decoration: const InputDecoration(
                            hintText: "0",
                            contentPadding: EdgeInsets.all(10.0),
                          ),
                          style: Theme.of(context).textTheme.headline6,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              0.32.sh.verticalSpace,
              Padding(
                padding: const EdgeInsets.all(10),
                child: RedButton(
                    text: "Confirm",
                    function: () {
                      controller.verifyOTP();
                    }),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
