import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:univ_chat_gpt/models/QuestionModel.dart';
import 'package:univ_chat_gpt/services/SpeechToTextService.dart';
import 'package:univ_chat_gpt/services/TextToSpeechService.dart';
import 'package:univ_chat_gpt/services/ThreadService.dart';
import 'package:http/http.dart' as http;

import '../app/Colors.dart';
import '../models/ThreadModel.dart';

class ThreadDetailController extends GetxController {
  late Rx<Thread> currentThread;
  Rx<bool> isLoading = true.obs;

  final scrollController = ScrollController();
  //RxList<Question?> questions = List<Question>.empty().obs;
  String? email;
  String? fullName;

  late final FlutterGifController gifController;

  final questionController = TextEditingController().obs;

  Future<void> send() async {
    if (questionController.value.text.isNotEmpty) {
      http.Response response = await ThreadService.postQuestion(
          questionController.value.text, currentThread.value.id);
      Map<String, dynamic> body = jsonDecode(response.body);
      Question q = Question.fromJson(body["question"]);
      currentThread.value.questions.add(q);
      currentThread.refresh();
      FocusScope.of(Get.context!).requestFocus(FocusNode());
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      questionController.value.clear();
    }
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
  Future<void> onInit() async {
    super.onInit();
    currentThread = Rx(Get.arguments[0]);
  }

  @override
  void onClose() {
    super.onClose();
  }
}
