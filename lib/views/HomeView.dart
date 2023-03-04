import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:univ_chat_gpt/app/Colors.dart';
import 'package:univ_chat_gpt/app/Routes.dart';
import 'package:univ_chat_gpt/controllers/HomeController.dart';
import 'package:univ_chat_gpt/views/ThreadDetailView.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text(
                "New Thread",
                style: TextStyle(
                    color: textColorLight, fontWeight: FontWeight.bold),
              ),
              backgroundColor: appBarColorLight,
              iconTheme: const IconThemeData(color: textColorLight),
              elevation: 0,
            ),
            drawer: Drawer(
                child: Obx(
              () => Column(
                children: [
                  controller.isLoading.value
                      ? Container()
                      : UserAccountsDrawerHeader(
                          accountName: Text(
                            controller.fullName!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          accountEmail: Text(
                            controller.email!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                  ListTile(
                    title: Text(
                      'Thread History',
                      style: TextStyle(fontSize: 20.sp),
                    ),
                    leading: Icon(
                      Icons.message_outlined,
                      size: 35.sp,
                      color: Colors.black,
                    ),
                    onTap: () => Get.toNamed(NamedRoutes.threadHistory),
                  ),
                  ListTile(
                    title: Text(
                      'Edit Profile',
                      style: TextStyle(fontSize: 20.sp),
                    ),
                    leading: Icon(
                      Icons.person_outline,
                      size: 35.sp,
                      color: Colors.black,
                    ),
                    onTap: () => Get.toNamed(NamedRoutes.editProfile),
                  ),
                  ListTile(
                    title: Text(
                      'Settings',
                      style: TextStyle(fontSize: 20.sp),
                    ),
                    leading: Icon(
                      Icons.settings_outlined,
                      size: 35.sp,
                      color: Colors.black,
                    ),
                    onTap: null,
                  ),
                  ListTile(
                    title: Text(
                      'About Us',
                      style: TextStyle(fontSize: 20.sp),
                    ),
                    leading: Icon(
                      Icons.info_outline,
                      size: 35.sp,
                      color: Colors.black,
                    ),
                    onTap: null,
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: ListTile(
                      title: Text(
                        'Logout',
                        style: TextStyle(fontSize: 20.sp),
                      ),
                      leading: Icon(
                        Icons.logout,
                        size: 35.sp,
                        color: Colors.black,
                      ),
                      onTap: null,
                    ),
                  ),
                ],
              ),
            )),
            body: ThreadDetailView(
              isNewThread: true,
            )));
  }
}
