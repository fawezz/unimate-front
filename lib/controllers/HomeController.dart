import 'package:get/get.dart';
import 'package:univ_chat_gpt/services/userService.dart';

import '../models/UserModel.dart';

class HomeController extends GetxController {
  Rx<bool> isLoading = true.obs;
  Rx<User?>? currentUser;
  String? email;
  String? fullName;

  @override
  Future<void> onInit() async {
    isLoading.value = true;
    final user = await UserService.getCurrentProfile();
    currentUser = user.obs;
    if (currentUser?.value != null) {
      email = currentUser?.value?.email;
      fullName = currentUser?.value?.fullname;
      isLoading.value = false;
    }
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}