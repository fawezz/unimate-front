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

class NewThreadDetailController extends GetxController
    with GetTickerProviderStateMixin {
  ScrollController scrollController = ScrollController();
  static RxString threadId = "".obs;
  RxList<Question> questions = List<Question>.empty().obs;
  RxInt gifIndex = 0.obs; //0 = wave, 1 = idle, 2 = talk, 3 = idk

  late final FlutterGifController gifController0;
  late final FlutterGifController gifController1;
  late final FlutterGifController gifController2;
  late final FlutterGifController gifController3;

  final questionController = TextEditingController().obs;

  void reInit() {
    scrollController = ScrollController();
    threadId.value = "";
    questions.clear();
    gifIndex.value = 0; //0 = wave, 1 = idle, 2 = talk, 3 = idk
    gifIdleRepeat();
    questionController.value.clear();
    SpeechToTextService.speech.stop();
  }

  Future<void> send() async {
    //move();

    if (questionController.value.text.isNotEmpty) {
      http.Response response = await ThreadService.postQuestion(
          questionController.value.text, threadId.value);
      if (response.statusCode == 201) {
        Map<String, dynamic> body = jsonDecode(response.body);
        Question q = Question.fromJson(body["question"]);
        threadId.value = q.thread ?? "";
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
    gifController0.value = 0.0;
    gifController0.animateTo(112.0,
        duration: const Duration(milliseconds: 3000));
  }

  void readText(String text) async {
    gifController1.reset();
    gifIndex.value = 2;
    gifController2.repeat(
        min: 0.0, max: 130.0, period: const Duration(milliseconds: 4000));
    await TextToSpeechService.speak(text, () {}, () {
      gifController2.stop(canceled: false);
      gifIdleRepeat();
      gifController2.reset();
      // gifController2.animateTo(145);
      // gifController2.addStatusListener((status) {
      //   if (AnimationStatus.completed == status) {
      //     print('aaaaaaaaaaaaaaaaaaaaa');
      //     gifIdleRepeat();
      //     gifController2.reset();
      //   }
      // });
    });
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

  void gifIdleRepeat() {
    gifIndex.value = 1;
    gifController1.repeat(
        min: 0.0, max: 138, period: const Duration(milliseconds: 2000));
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    gifController0 = FlutterGifController(vsync: this);
    gifController1 = FlutterGifController(vsync: this);
    gifController2 = FlutterGifController(vsync: this);
    gifController3 = FlutterGifController(vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      gifController0.animateTo(140.0,
          duration: const Duration(milliseconds: 3000));
      //gifController0.repeat(min: 0.0,max: 112, period: Duration(milliseconds: 3000));
      gifController0.addStatusListener((status) {
        print(status.toString());
        gifIdleRepeat();
        gifController0.removeStatusListener((status) {});
      });
    });
  }

  @override
  void onClose() {
    super.onClose();
  }
}
