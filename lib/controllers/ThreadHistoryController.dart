import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:univ_chat_gpt/models/ThreadModel.dart';
import 'package:univ_chat_gpt/services/ThreadService.dart';

import '../app/Routes.dart';

class ThreadHistoryController extends GetxController {
  Rx<bool> isLoading = true.obs;

  final searchController = TextEditingController().obs;

  RxList<Thread> threads = <Thread>[].obs;

  void navigateToDetails(int index) {
    Thread t = threads.elementAt(index);
    print(t.questions.length);
    Get.toNamed(NamedRoutes.threadDetail, arguments: [t]);
  }

  @override
  Future<void> onInit() async {
    isLoading.value = true;
    List<Thread>? threadsResponse = await ThreadService.getThreadsByUser();
    if (threadsResponse == null) {
      ///show error toast
    } else {
      threads.value = threadsResponse;
    }
    isLoading.value = false;

    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
