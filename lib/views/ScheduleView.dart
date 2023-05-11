import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:univ_chat_gpt/app/Colors.dart';
import 'package:univ_chat_gpt/app/Constants.dart';

import '../models/UserModel.dart';

class ScheduleView extends StatefulWidget {
  const ScheduleView({super.key});

  @override
  State<ScheduleView> createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  late String localFile;
  late User user;

  @override
  void initState() {
    super.initState();
    user = Get.arguments[0];
    localFile =
        "$scheduleBaseUrl${user.level}${user.speciality}${user.classe}.pdf";
    //UserService.getSchedule().then((value) => localFile = value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back,
                color: Theme.of(context).primaryIconTheme.color),
            onPressed: () => Get.back(),
          ),
          title: const Text("Schedule"),
          elevation: 0,
        ),
        body: Container(
            child: const PDF(nightMode: false //Get.isDarkMode
                    )
                .cachedFromUrl(
          localFile,
          placeholder: (progress) => Center(
              child: SizedBox(
            height: 100,
            width: 100,
            child: Column(
              children: [
                CircularProgressIndicator(
                  color: primaryColor,
                ),
                Text(
                  '$progress %',
                  style: const TextStyle(color: Colors.red, fontSize: 20),
                ),
              ],
            ),
          )),
          errorWidget: (error) => Center(
              child: SizedBox(
            width: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.report_problem_outlined,
                  color: Colors.red,
                  size: 120.sp,
                ),
                const Text("schedule not found"),
              ],
            ),
          )),
        )));
  }
}
