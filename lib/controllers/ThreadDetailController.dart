import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:univ_chat_gpt/models/QuestionModel.dart';
import 'package:univ_chat_gpt/services/ThreadService.dart';
import 'package:http/http.dart' as http;

class ThreadDetailController extends GetxController
    with GetSingleTickerProviderStateMixin {
  Rx<bool> isLoading = true.obs;

  final scrollController = ScrollController();
  RxList<Question?> questions = List<Question>.empty().obs;
  String? email;
  String? fullName;

  late final gifController;

  //chat variables
  final questionController = TextEditingController().obs;

  Future<void> send() async {
    move();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (questionController.value.text.isNotEmpty) {
      http.Response response = await ThreadService.postPredictCompletion(
          questionController.value.text);
      Map<String, dynamic> body = jsonDecode(response.body);
      Question q = Question.fromJson(body["question"]);
      questions.add(q);
      FocusScope.of(Get.context!).requestFocus(FocusNode());
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      questionController.value.clear();
    }
  }

  void move() {
    gifController.value = 0.0;
    gifController.animateTo(112.0, duration: Duration(milliseconds: 3000));
  }

  @override
  Future<void> onInit() async {
    gifController = FlutterGifController(vsync: this);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      gifController.animateTo(112.0, duration: Duration(milliseconds: 3000));
      // gifController.repeat(
      //   min: 0.0,
      //   max: 53.0,
      //   period: const Duration(milliseconds: 1000),
      // );
    });
    // questions.add(Question(
    //     prompt: "hello how are you ?", completion: "i am fine", tag: "test"));
    questions.add(Question(
        prompt: "where is block A?",
        completion: "go straight",
        tag: "blocks and buildings"));

    print(questions.length);
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
