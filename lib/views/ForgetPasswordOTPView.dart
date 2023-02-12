import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:univ_chat_gpt/controllers/ForgetPwdController.dart';
import 'package:univ_chat_gpt/custom_widgets/RedButton.dart';
import 'package:univ_chat_gpt/app/Colors.dart' as color;

class ForgetPwdView extends StatelessWidget {
  const ForgetPwdView({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    ForgetPwd controller = Get.put(ForgetPwd());
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.all(24.sp),
          child: Column(children: [
            0.2.sh.verticalSpace,
            Text(
              "OTP",
              style: TextStyle(
                  color: color.primaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            0.009.sh.verticalSpace,
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
                      height: 68,
                      width: 64,
                      child: TextFormField(
                        onChanged: (value) =>
                            {FocusScope.of(context).nextFocus()},
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
                      height: 68,
                      width: 64,
                      child: TextFormField(
                        onChanged: (value) =>
                            {FocusScope.of(context).nextFocus()},
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
                      height: 68,
                      width: 64,
                      child: TextFormField(
                        onChanged: (value) =>
                            {FocusScope.of(context).nextFocus()},
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
                      height: 68,
                      width: 64,
                      child: TextFormField(
                        onChanged: (value) =>
                            {FocusScope.of(context).nextFocus()},
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
            Padding(
              padding: EdgeInsets.fromLTRB(
                  height * 0.1, height * 0.4, height * 0.1, 0),
              child: RedButton(
                  text: "Confirm",
                  function: () {
                    print('Confirmed');
                  }),
            ),
          ]),
        ),
      ),
    );
  }
}
