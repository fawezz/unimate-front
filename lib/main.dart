import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:univ_chat_gpt/app/Colors.dart';
import 'package:univ_chat_gpt/app/Routes.dart';
import 'package:univ_chat_gpt/views/EditProfileView.dart';
import 'package:univ_chat_gpt/views/HomeView.dart';
import 'package:univ_chat_gpt/views/ThreadHistoryView.dart';
import 'package:univ_chat_gpt/views/ThreadDetailView.dart';
import 'package:univ_chat_gpt/views/forgotPwd/ResetPasswordView.dart';
import 'package:univ_chat_gpt/views/forgotPwd/ForgetPwdEmail.dart';
import 'package:univ_chat_gpt/views/LoginView.dart';
import 'package:univ_chat_gpt/views/SignUpView.dart';
import 'views/forgotPwd/ForgetPwdOTPView.dart';

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
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'University ChatGPT',
          theme: ThemeData(
              primarySwatch: Colors.red,
              //fontFamily: "Cairo",
              scaffoldBackgroundColor: Colors.white,
              //canvasColor: Colors.transparent,
              iconTheme: IconThemeData(color: primaryColor)),
          home: const LoginView(),
          getPages: [
            GetPage(name: NamedRoutes.signUp, page: () => const SignUpView()),
            GetPage(name: NamedRoutes.login, page: () => const LoginView()),
            GetPage(
                name: NamedRoutes.forgetPwdOTP,
                page: () => const ForgetPwdOTPView()),
            GetPage(
                name: NamedRoutes.forgetPwdEmail,
                page: () => const ForgetPwdEmail()),
            GetPage(
                name: NamedRoutes.resetPwd,
                page: () => const ResetPasswordView()),
            GetPage(
                name: NamedRoutes.editProfile,
                page: () => const EditProfileView()),
            GetPage(name: NamedRoutes.home, page: () => HomeView()),
            GetPage(
                name: NamedRoutes.threadDetail,
                page: () => ThreadDetailView(
                      isNewThread: false,
                    )),
            GetPage(
                name: NamedRoutes.threadHistory,
                page: () => ThreadHistoryView()),
          ],
          builder: EasyLoading.init(),
        );
      },
    );
  }
}
