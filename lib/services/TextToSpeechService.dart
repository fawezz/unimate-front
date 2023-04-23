import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeechService {
  static FlutterTts tts = FlutterTts();

  static initTTS() async {
    tts.setLanguage("en-US");
    tts.setPitch(1);
    tts.setSpeechRate(0.5);
  }

  static speak(
      String text, VoidCallback startHandler, VoidCallback endHandler) async {
    tts.setStartHandler(() {
      print("start moving avatar");
      startHandler();
    });

    tts.setCompletionHandler(() {
      print("stop moving avatar");
      endHandler();
    });
    await tts.awaitSynthCompletion(true);

    tts.speak(text);
  }
}
