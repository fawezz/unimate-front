import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:univ_chat_gpt/app/Colors.dart';
import 'package:univ_chat_gpt/services/SpeechToTextService.dart';
import '../controllers/ThreadDetailController.dart';

class ThreadDetailView extends StatelessWidget {
  ThreadDetailView({
    super.key,
  });

  final ThreadDetailController controller = Get.put(ThreadDetailController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            onPressed: () => Get.back(),
            icon: IconTheme(
              data: Theme.of(context).primaryIconTheme,
              child: const Icon(
                Icons.arrow_back,
              ),
            ),
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              Obx(
                () => ListView.builder(
                    padding: EdgeInsets.only(top: 50),
                    controller: controller.scrollController,
                    physics:
                        const BouncingScrollPhysics(), //if it bounces then it wont scroll to the endd initially
                    itemCount: controller.currentThread.value.questions.length,
                    itemBuilder: (context, index) {
                      return Wrap(children: [
                        //user question
                        Container(
                          padding: const EdgeInsets.only(
                              left: 14, right: 14, top: 10, bottom: 10),
                          child: Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                  ),
                                  color: thirdColor,
                                ),
                                padding: const EdgeInsets.all(16),
                                child: Text(
                                  (controller.currentThread.value
                                          .questions[index].prompt) ??
                                      "error getting data",
                                  style: TextStyle(
                                      fontSize: 18.sp, color: Colors.white),
                                ),
                              )),
                        ),
                        //bot response
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 14, right: 14, top: 10, bottom: 10),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: GestureDetector(
                                    onLongPress: () {
                                      controller.copy((controller
                                          .currentThread
                                          .value
                                          .questions[index]
                                          .completion)!);
                                    },
                                    child: Container(
                                        constraints:
                                            BoxConstraints(maxWidth: 0.75.sw),
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            bottomRight: Radius.circular(20),
                                            bottomLeft: Radius.circular(20),
                                          ),
                                          color: primaryColor,
                                        ),
                                        padding: const EdgeInsets.all(16),
                                        child: index !=
                                                (controller.currentThread.value
                                                        .questions.length -
                                                    1)
                                            ? Text(
                                                (controller
                                                    .currentThread
                                                    .value
                                                    .questions[index]
                                                    .completion)!,
                                                style: TextStyle(
                                                    fontSize: 18.sp,
                                                    color: Colors.white))
                                            : AnimatedTextKit(
                                                totalRepeatCount: 1,
                                                animatedTexts: [
                                                  TypewriterAnimatedText(
                                                      (controller
                                                          .currentThread
                                                          .value
                                                          .questions[index]
                                                          .completion)!,
                                                      textStyle: TextStyle(
                                                          fontSize: 18.sp,
                                                          color: Colors.white)),
                                                ],
                                              )),
                                  )),
                            ),
                            IconButton(
                                color: Colors.white,
                                onPressed: () => controller.readText((controller
                                    .currentThread
                                    .value
                                    .questions[index]
                                    .completion)!),
                                icon: IconTheme(
                                    data: Theme.of(context).iconTheme,
                                    child: Icon(
                                      Icons.volume_up,
                                      color: Theme.of(context)
                                          .primaryIconTheme
                                          .color,
                                    )))
                          ],
                        ),
                      ]);
                    }),
              ),
              Positioned(
                top: -1,
                width: Get.width,
                height: 120,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Theme.of(context).scaffoldBackgroundColor,
                        Theme.of(context)
                            .scaffoldBackgroundColor
                            .withOpacity(0.0),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Obx(
          () => SpeechToTextService.isListening.isTrue
              ? AvatarGlow(
                  animate: true,
                  glowColor: primaryColor,
                  endRadius: 60,
                  repeat: true,
                  duration: const Duration(seconds: 3),
                  repeatPauseDuration: const Duration(microseconds: 100),
                  child: FloatingActionButton(
                    heroTag: "micGlow",
                    mini: false,
                    onPressed: null,
                    backgroundColor: thirdColor,
                    elevation: 0,
                    child: Icon(
                      Icons.mic_none,
                      color: primaryColor,
                      size: 20,
                    ),
                  ),
                )
              : Container(),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
            height: 65.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Theme.of(context).colorScheme.tertiary,
            ),
            child: Row(
              children: <Widget>[
                FloatingActionButton(
                  heroTag: "mic",
                  mini: true,
                  onPressed: () {
                    controller.listenToSpeech();
                  },
                  backgroundColor: thirdColor,
                  elevation: 0,
                  child: const Icon(
                    Icons.mic_none,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                15.w.horizontalSpace,
                Expanded(
                  child: TextField(
                    style: TextStyle(fontSize: 19.sp),
                    controller: controller.questionController.value,
                    decoration: InputDecoration(
                        hintText: "Ask a question...",
                        hintStyle:
                            TextStyle(color: Colors.grey, fontSize: 18.sp),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.only(
                          bottom: 8.0,
                        )),
                    maxLines: 1,
                  ),
                ),
                15.w.horizontalSpace,
                FloatingActionButton(
                  heroTag: "send",
                  mini: true,
                  onPressed: () {
                    controller.send();
                  },
                  backgroundColor: primaryColor,
                  elevation: 0,
                  child: const Icon(
                    Icons.send_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        )
      ]),
    ));
  }
}
