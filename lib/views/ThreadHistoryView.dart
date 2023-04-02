import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:univ_chat_gpt/controllers/ThreadHistoryController.dart';

import '../app/Colors.dart';
import '../app/Routes.dart';

class ThreadHistoryView extends StatelessWidget {
  ThreadHistoryView({super.key});
  final ThreadHistoryController controller = Get.put(ThreadHistoryController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'History',
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
        ),
        floatingActionButton: const FloatingActionButton.small(
            onPressed: null,
            child: Icon(
              Icons.add,
              color: Colors.white70,
            )),
        body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Padding(
            padding: EdgeInsets.only(top: 18.h),
            child: Center(
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
                        borderSide:
                            const BorderSide(color: Colors.transparent)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide:
                            const BorderSide(color: Colors.transparent)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide:
                            const BorderSide(color: Colors.transparent)),
                    filled: true,
                    fillColor: thirdColor.withOpacity(0.18),
                  ),
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
                style:
                    TextStyle(color: thirdColor, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          ////////////////////////////////////////////////////////////////////////
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
                child: Obx(() => controller.threads.isEmpty
                    ? const Center(
                        child: Text("You don't have any threads yet."))
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: controller.threads.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: GestureDetector(
                              onTap: () => controller.navigateToDetails(index),
                              child: Container(
                                height: 0.08.sh,
                                width: 1.sw,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 0.75.sw,
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              //controller.threads[index].title,
                                              controller.threads[index].questions.first.tag!,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            10.h.verticalSpace,
                                            Text(
                                              controller.threads[index]
                                                      .questions.first.prompt ??
                                                  "error",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.grey[400]),
                                            )
                                          ]),
                                    ),
                                    5.w.horizontalSpace,
                                    Text(
                                      "11 May",
                                      style: TextStyle(color: Colors.grey[400]),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        })),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
