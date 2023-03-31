import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechToTextService {
  static stt.SpeechToText speech = stt.SpeechToText();
  static bool speechEnabled = false;
  static RxBool isListening = false.obs;

  static void initSpeech() async {
    speechEnabled = await speech.initialize(onStatus: (val) {
      print('speech initiaize onStatus: $val');
      if (val == "listening") {
        isListening.value = true;
      } else {
        isListening.value = false;
      }
    }, onError: (val) {
      print('speech initiaize onError: $val');
              isListening.value = false;
    },
    finalTimeout: Duration(seconds: 10)
    );
  }

  // bool available = await speech.initialize( onStatus: statusListener, onError: errorListener );
  // if ( available ) {
  //     speech.listen( onResult: resultListener );
  // }
  // else {
  //     print("The user has denied the use of speech recognition.");
  // }
  // // some time later...
  // speech.stop()
}
