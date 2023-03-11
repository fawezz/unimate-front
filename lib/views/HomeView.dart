import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:univ_chat_gpt/app/Colors.dart';
import 'package:univ_chat_gpt/app/Routes.dart';
import 'package:univ_chat_gpt/controllers/HomeController.dart';
import 'package:univ_chat_gpt/views/ThreadDetailView.dart';

import '../app/Themes.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final HomeController controller = Get.put(HomeController());
  var drawerIconColor = Get.theme.primaryIconTheme.color;

  final drawerIconSize = 28.sp;
  final drawerTextSize = 18.sp;
  //var drawerIconColor = Theme.of(Get.context!).primaryIconTheme.color;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              toolbarTextStyle: Get.theme.appBarTheme.toolbarTextStyle,
              title: Text(
                "New Thread",
              ),
              elevation: 0,
            ),
            drawer: Drawer(
                child: Obx(
              () => Column(
                children: [
                  controller.isLoading.value
                      ? Container()
                      : UserAccountsDrawerHeader(
                          decoration: BoxDecoration(color: primaryColor),
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
                      style: TextStyle(fontSize: drawerTextSize),
                    ),
                    leading: IconTheme(
                      data: Theme.of(context).primaryIconTheme,
                      child: Icon(
                        Icons.message_outlined,
                        size: drawerIconSize,
                      ),
                    ),
                    onTap: () => Get.toNamed(NamedRoutes.threadHistory),
                  ),
                  ListTile(
                    title: Text(
                      'Edit Profile',
                      style: TextStyle(fontSize: drawerTextSize),
                    ),
                    leading: IconTheme(
                      data: Theme.of(context).primaryIconTheme,
                      child: Icon(
                        Icons.person_outline,
                        size: drawerIconSize,
                      ),
                    ),
                    onTap: () => Get.toNamed(NamedRoutes.editProfile),
                  ),
                  ListTile(
                    title: Text(
                      'Settings',
                      style: TextStyle(fontSize: drawerTextSize),
                    ),
                    leading: IconTheme(
                      data: Theme.of(context).primaryIconTheme,
                      child: Icon(
                        Icons.settings_outlined,
                        size: drawerIconSize,
                      ),
                    ),
                    onTap: () => Get.toNamed(NamedRoutes.settings),
                  ),
                  ListTile(
                    title: Text(
                      'About Us',
                      style: TextStyle(fontSize: drawerTextSize),
                    ),
                    leading: IconTheme(
                      data: Theme.of(context).primaryIconTheme,
                      child: Icon(
                        Icons.info_outline,
                        size: drawerIconSize,
                      ),
                    ),
                    onTap: null,
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: ListTile(
                      title: Text(
                        'Logout',
                        style: TextStyle(fontSize: drawerTextSize),
                      ),
                      leading: IconTheme(
                        data: Theme.of(context).primaryIconTheme,
                        child: Icon(
                          Icons.logout,
                          size: drawerIconSize,
                        ),
                      ),
                      onTap: () => controller.logout(),
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
