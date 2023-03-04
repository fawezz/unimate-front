import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ThreadHistoryController extends GetxController {

  Rx<bool> isLoading = true.obs;

  final searchController = TextEditingController().obs;

  RxList questions = [].obs;


  @override
  Future<void> onInit() async {
    /*isLoading.value = true;
    final user = await UserService.getCurrentProfile();
    
    if (currentUser?.value != null) {
      email = currentUser?.value?.email;
      fullName = currentUser?.value?.fullname;
      isLoading.value = false;
    }*/
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
