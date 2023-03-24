import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:univ_chat_gpt/app/Routes.dart';
import 'package:univ_chat_gpt/views/EditProfileView.dart';
import 'package:univ_chat_gpt/views/HomeView.dart';
import 'package:univ_chat_gpt/views/SettingsView.dart';
import 'package:univ_chat_gpt/views/ThreadHistoryView.dart';
import 'package:univ_chat_gpt/views/ThreadDetailView.dart';
import 'package:univ_chat_gpt/views/forgotPwd/ResetPasswordView.dart';
import 'package:univ_chat_gpt/views/forgotPwd/ForgetPwdEmail.dart';
import 'package:univ_chat_gpt/views/LoginView.dart';
import 'package:univ_chat_gpt/views/SignUpView.dart';
import 'app/Themes.dart';
import 'services/TextToSpeechService.dart';
import 'views/forgotPwd/ForgetPwdOTPView.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString("token");
  String? theme = prefs.getString("theme");
  TextToSpeechService.initTTS();
  runApp(MyApp(
    token: token,
  ));
  Themes.setTheme(theme);
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.token});
  String? token;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      builder: (context, child) {
        return Obx(() => GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'University ChatGPT',
              theme: Themes.lightTheme,
              darkTheme: Themes.darkTheme,
              themeMode: Themes.currentThemeMode.value,
              home: token == null ? LoginView() : HomeView(),
              getPages: [
                GetPage(name: NamedRoutes.signUp, page: () => SignUpView()),
                GetPage(name: NamedRoutes.login, page: () => LoginView()),
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
                GetPage(name: NamedRoutes.settings, page: () => SettingsView()),
              ],
              builder: EasyLoading.init(),
            ));
      },
    );
  }
}
