import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:univ_chat_gpt/controllers/SettingsController.dart';

class SettingsView extends StatelessWidget {
  SettingsView({super.key});
  final SettingsController controller = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Dark mode",
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: Obx(() => Radio(
                  value: "LIGHT",
                  groupValue: controller.darkMode.value,
                  onChanged: (String? value) {
                    controller.darkMode.value = value!;
                    controller.changeTheme();
                  },
                )),
            title: Text("Off"),
          ),
          ListTile(
            leading: Obx(() => Radio(
                  value: "DARK",
                  groupValue: controller.darkMode.value,
                  onChanged: (String? value) {
                    controller.darkMode.value = value!;
                    controller.changeTheme();
                  },
                )),
            title: Text("Dark"),
          ),
          ListTile(
            leading: Obx(() => Radio(
                  value: "SYSTEM",
                  groupValue: controller.darkMode.value,
                  onChanged: (String? value) {
                    controller.darkMode.value = value!;
                    controller.changeTheme();
                  },
                )),
            title: Text("System"),
          ),
        ]),
      ),
    ));
  }
}
