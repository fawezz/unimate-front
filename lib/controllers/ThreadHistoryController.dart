import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:univ_chat_gpt/models/ThreadModel.dart';
import 'package:univ_chat_gpt/services/ThreadService.dart';
import 'package:http/http.dart' as http;

import '../app/Colors.dart';
import '../app/Routes.dart';

class ThreadHistoryController extends GetxController {
  Rx<bool> isLoading = true.obs;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  final searchController = TextEditingController().obs;

  RxList<Thread> threads = <Thread>[].obs;
  RxList<Thread> searchedThreads = <Thread>[].obs;

  void navigateToDetails(int index) {
    Thread t = searchedThreads.elementAt(index);
    Get.toNamed(NamedRoutes.threadDetail, arguments: [t]);
  }

  void deleteThread(int index) async {
    Thread t = searchedThreads.elementAt(index);
    http.Response response = await ThreadService.deleteThread(t.id!);
    //print(response.body + "AAAAAAAAAAA");
    //Map<String, dynamic> body = jsonDecode(response.body);
    if (response.statusCode == 204) {
      threads.value.removeWhere((element) => element.id! == t.id!);
      searchedThreads.value.removeAt(index);
      print("delete =  ${searchedThreads.length} ${threads.length}");
      EasyLoading.showSuccess("Thread deleted!");
    } else {
      if (response.statusCode == 404) {
        EasyLoading.showError("Thread not found!");
      } else {
        EasyLoading.showError("error");
      }
    }
  }

  Future<bool?> showDeleteConfirmation() async {
    return await showDialog<bool>(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          title: const Text('Are you sure you want to delete this thread?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Yes'),
            )
          ],
        );
      },
    );
  }

  Future<void> getThreads() async {
    List<Thread>? threadsResponse = await ThreadService.getThreadsByUser();
    if (threadsResponse == null) {
      Fluttertoast.showToast(
          msg: "error retrieving threads",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: primaryColor.withOpacity(0.6),
          textColor: Colors.white,
          fontSize: 14.sp);
    } else {
      threads.value = threadsResponse;
      searchedThreads.value = threads;
    }
    refreshController.refreshCompleted();
    return Future(() => null);
  }

  void searchTitles(String? searchText) {
    searchedThreads.value = threads.value
        .where((object) =>
            object.title.toLowerCase().contains(searchText!.toLowerCase()))
        .toList();
    //print("$searchText =  ${searchedThreads.length} ${threads.length}");
  }

  @override
  Future<void> onInit() async {
    isLoading.value = true;
    EasyLoading.show(
        status: 'Loading..',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black);

    await getThreads();

    EasyLoading.dismiss();
    isLoading.value = false;

    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
