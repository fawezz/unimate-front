import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:univ_chat_gpt/app/Colors.dart';
import 'package:univ_chat_gpt/app/Routes.dart';
import 'package:univ_chat_gpt/controllers/HomeController.dart';
import 'package:univ_chat_gpt/views/NewThreadDetailView.dart';

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
              title: const Text(
                "New Thread",
              ),
              elevation: 0,
            ),
            drawer: Drawer(
                child: Obx(
              () => Column(
                children: [
                  controller.currentUser.value == null
                      ? Container(
                          color: primaryColor,
                          height: 0.2.sh,
                        )
                      : UserAccountsDrawerHeader(
                          decoration: BoxDecoration(color: primaryColor),
                          accountName: Obx(() => Text(
                                controller.currentUser.value!.fullname!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                          accountEmail: Text(
                            controller.currentUser.value!.email!,
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
                    onTap: () => Get.toNamed(NamedRoutes.editProfile)!
                        .then((_) => controller.getProfile()),
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
                  controller.currentUser.value?.role == "STUDENT"
                      ? ListTile(
                          title: Text(
                            'Schedule',
                            style: TextStyle(fontSize: drawerTextSize),
                          ),
                          leading: IconTheme(
                            data: Theme.of(context).primaryIconTheme,
                            child: Icon(
                              Icons.schedule_outlined,
                              size: drawerIconSize,
                            ),
                          ),
                          onTap: () => Get.toNamed(NamedRoutes.schedule,
                              arguments: [controller.currentUser.value]),
                        )
                      : Container(),
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
            body: SmartRefresher(
                enablePullDown: true,
                physics: const BouncingScrollPhysics(),
                controller: controller.refreshController,
                onRefresh: () => controller.getProfile(),
                child: NewThreadDetailView())));
  }
}
