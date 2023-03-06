import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:univ_chat_gpt/models/QuestionModel.dart';
import 'package:univ_chat_gpt/services/ThreadService.dart';
import 'package:http/http.dart' as http;

class ThreadDetailController extends GetxController {
  Rx<bool> isLoading = true.obs;

  final scrollController = ScrollController();
  RxList<Question?> questions = List<Question>.empty().obs;
  String? email;
  String? fullName;

  //chat variables
  final questionController = TextEditingController().obs;

  Future<void> send() async {
    if (questionController.value.text.isNotEmpty) {
      http.Response response =
          await ThreadService.postPreddictTag(questionController.value.text);
      Map<String, dynamic> body = jsonDecode(response.body);
      Question q = Question.fromJson(body["thread"]);
      questions.add(q);
      questionController.value.clear();
    }
  }

  @override
  Future<void> onInit() async {
    // questions.add(Question(
    //     prompt: "hello how are you ?", completion: "i am fine", tag: "test"));
    questions.add(Question(
        prompt: "where is block A?",
        completion: "go straight",
        tag: "blocks andd buildings"));

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
