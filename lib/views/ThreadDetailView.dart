import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:univ_chat_gpt/app/Colors.dart';
import 'package:univ_chat_gpt/controllers/ThreadDetailController.dart';

class ThreadDetailView extends StatelessWidget {
  ThreadDetailView({
    super.key,
    required this.isNewThread,
  });

  final ThreadDetailController controller = Get.put(ThreadDetailController());
  final bool isNewThread;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        Expanded(
          child: Obx(
            () => Stack(
              children: [
                controller.questions.isEmpty
                    ? const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "You have no previous questions",
                        ))
                    : ListView.builder(
                        controller: controller.scrollController,
                        //physics: BouncingScrollPhysics(),      //if it bounces then it wont scroll to the endd initially
                        itemCount: controller.questions.length,
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
                                      controller.questions[index]!.prompt!,
                                      style: TextStyle(fontSize: 15.sp),
                                    ),
                                  )),
                            ),
                            //bot response
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 14, right: 14, top: 10, bottom: 10),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                        ),
                                        color: primaryColor,
                                      ),
                                      padding: const EdgeInsets.all(16),
                                      child: AnimatedTextKit(
                                        totalRepeatCount: 1,
                                        animatedTexts: [
                                          TypewriterAnimatedText(
                                              controller.questions[index]!.tag!,
                                              textStyle:
                                                  TextStyle(fontSize: 15.sp)),
                                        ],
                                      ))),
                            ),
                          ]);
                        }),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
            height: 55,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Theme.of(context).colorScheme.tertiary,
            ),
            child: Row(
              children: <Widget>[
                15.w.horizontalSpace,
                Expanded(
                  child: TextField(
                    style: TextStyle(fontSize: 19.sp),
                    controller: controller.questionController.value,
                    decoration: InputDecoration(
                      hintText: "Ask a question...",
                      hintStyle:
                          TextStyle(color: Colors.black54, fontSize: 18.sp),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                15.w.horizontalSpace,
                FloatingActionButton(
                  mini: true,
                  onPressed: () async {
                    controller.send();
                    // if(!messageController.text.isBlank){
                    //   SharedPreferences prefs = await SharedPreferences.getInstance();
                    //   model.newMessage =
                    //       ChatMessage(senderId: prefs.getInt("idUser"), senderName: prefs.getString("firstName"),
                    //           message: messageController.text, description: Get.arguments["description"],
                    //           participantsIds: model.currentConv.participantsIds);
                    //   model.sendMessage();
                    //   messageController.clear();
                    //   scrollController.jumpTo(scrollController.position.maxScrollExtent);
                    // }
                    // //messageController.value
                  },
                  backgroundColor: primaryColor,
                  elevation: 0,
                  child: const Icon(
                    Icons.send,
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
