import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:univ_chat_gpt/app/Colors.dart';
import 'package:univ_chat_gpt/app/Routes.dart';
import 'package:univ_chat_gpt/controllers/HomeController.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text(
          "Chats",
          style: TextStyle(color: textColorLight, fontWeight: FontWeight.bold),
        ),
        backgroundColor: appBarColorLight,
        iconTheme: const IconThemeData(color: textColorLight),
        elevation: 0,
      ),
      floatingActionButton: const FloatingActionButton.small(
          onPressed: null, child: Icon(Icons.add)),
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
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Center(
          child: SizedBox(
            height: 50.h,
            width: 0.9.sw,
            child: TextField(
              controller: controller.searchController.value,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: 'Search chats...',
                hintStyle: TextStyle(color: thirdColor),
                suffixIcon: const Icon(
                  Icons.search,
                  color: textColorLight,
                ),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 10.0),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(color: Colors.transparent)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(color: Colors.transparent)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(color: Colors.transparent)),
                filled: true,
                fillColor: thirdColor.withOpacity(0.18),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "History",
              style: TextStyle(color: thirdColor, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                color: thirdColor.withOpacity(0.18)),
            width: 1.sw,
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 8,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        height: 0.08.sh,
                        width: 1.sw,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 0.78.sw,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "subject",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    10.h.verticalSpace,
                                    Text(
                                      "At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga.",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color:
                                              textColorLight.withOpacity(0.5)),
                                    )
                                  ]),
                            ),
                            5.w.horizontalSpace,
                            Text(
                              "11 May",
                              style: TextStyle(
                                  color: textColorLight.withOpacity(0.4)),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ),
        )
      ]),
    ));
  }
}
