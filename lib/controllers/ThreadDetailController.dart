import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThreadDetailController extends GetxController {
  Rx<bool> isLoading = true.obs;

  final scrollController = ScrollController();
  RxList questions = [].obs;
  String? email;
  String? fullName;

  //chat variables
  final searchController = TextEditingController().obs;

  @override
  Future<void> onInit() async {
    /*isLoading.value = true;
    final user = await UserService.getCurrentProfile();
    currentUser = user.obs;
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
