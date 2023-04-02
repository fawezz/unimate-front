import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:univ_chat_gpt/models/QuestionModel.dart';
import 'package:univ_chat_gpt/services/SpeechToTextService.dart';
import 'package:univ_chat_gpt/services/TextToSpeechService.dart';
import 'package:univ_chat_gpt/services/ThreadService.dart';
import 'package:http/http.dart' as http;

import '../app/Colors.dart';

class NewThreadDetailController extends GetxController
    with GetSingleTickerProviderStateMixin {
  Rx<bool> isLoading = true.obs;
  final scrollController = ScrollController();
  String threadId = "";
  RxList<Question> questions = List<Question>.empty().obs;
  String? email;
  String? fullName;

  late final FlutterGifController gifController;

  final questionController = TextEditingController().obs;

  Future<void> send() async {
    //move();

    if (questionController.value.text.isNotEmpty) {
      http.Response response = await ThreadService.postQuestion(
          questionController.value.text, threadId);
      if (response.statusCode == 201) {
        Map<String, dynamic> body = jsonDecode(response.body);
        Question q = Question.fromJson(body["question"]);
        threadId = q.thread ?? "";
        questions.add(q);
        FocusScope.of(Get.context!).requestFocus(FocusNode());
        questionController.value.clear();
        if (questions.length > 1) {
          scrollController.animateTo(scrollController.position.maxScrollExtent,
              duration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn);
        }
        return;
      }
      Fluttertoast.showToast(
          msg: "Error connecting to server",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: primaryColor.withOpacity(0.6),
          textColor: Colors.white,
          fontSize: 14.0);
    }
  }

  void move() {
    gifController.value = 0.0;
    gifController.animateTo(112.0, duration: Duration(milliseconds: 3000));
  }

  void readText(String text) async {
    await TextToSpeechService.speak(text);
  }

  void listenToSpeech() {
    if (SpeechToTextService.isListening.isFalse) {
      SpeechToTextService.speech.listen(
        onResult: (result) {
          questionController.value.text = result.recognizedWords;
          TextSelection.fromPosition(
              TextPosition(offset: questionController.value.text.length));
          questionController.value.selection = TextSelection.collapsed(
              offset: questionController.value.text.length);
        },
        pauseFor: const Duration(seconds: 3),
      );
    } else {
      SpeechToTextService.speech.stop();
    }
  }

  void copy(String text) {
    Clipboard.setData(ClipboardData(text: text));
    Fluttertoast.showToast(
        msg: "Copied to Clipboard",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: primaryColor.withOpacity(0.6),
        textColor: Colors.white,
        fontSize: 14.0);
  }

  @override
  void onReady() {
    /*
    if (currentThread.value != null) {
      isLoading.value = true;
      /*final user = await UserService.getCurrentProfile();
      currentUser = user.obs;
      if (currentUser?.value != null) {
        email = currentUser?.value?.email;
        fullName = currentUser?.value?.fullname;*/
      isLoading.value = false;
    }*/
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    gifController = FlutterGifController(vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      gifController.animateTo(112.0,
          duration: const Duration(milliseconds: 3000));
      // gifController.repeat(
      //   min: 0.0,
      //   max: 53.0,
      //   period: const Duration(milliseconds: 1000),
      // );
    });
  }

  @override
  void onClose() {
    super.onClose();
  }
}
