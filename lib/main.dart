import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:univ_chat_gpt/views/ForgetPasswordOTPView.dart';
import 'package:univ_chat_gpt/views/ForgetPwdEmail.dart';
import 'package:univ_chat_gpt/views/LoginView.dart';
import 'package:univ_chat_gpt/views/SignUpView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      builder: (context , child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'University ChatGPT',
          theme: ThemeData(
              primarySwatch: Colors.red,
              //fontFamily: "Cairo",
              scaffoldBackgroundColor: Colors.white,
              canvasColor: Colors.transparent
          ),
          home: const SignUpView(),
          getPages: [
            GetPage(name: '/signUp', page: () => const SignUpView()),
            GetPage(name: '/login', page: () => const LoginView()),
            GetPage(name: '/forgetPwd', page: () => const ForgetPwdView()),
            GetPage(name: '/forgetPwdEmail', page: () => const ForgetPwdEmail())
          ],
        );
      },
    );
  }
}