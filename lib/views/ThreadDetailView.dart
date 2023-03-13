import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gif/flutter_gif.dart';
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
        GifImage(
          controller: controller.gifController,
          image: AssetImage("assets/gifs/wavingBGIFV2.gif"),
        ),
        0.02.sh.verticalSpace,
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
                        padding: EdgeInsets.only(top: 50),
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
                                      child: Container(
                                          constraints:
                                              BoxConstraints(maxWidth: 0.8.sw),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.only(
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
                                                  controller.questions[index]!
                                                      .completion!,
                                                  textStyle: TextStyle(
                                                      fontSize: 18.sp,
                                                      color: Colors.white)),
                                            ],
                                          ))),
                                ),
                                IconButton(
                                    onPressed: null,
                                    icon: Icon(Icons.volume_up))
                              ],
                            ),
                          ]);
                        }),
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
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 18.sp),
                      border: InputBorder.none,
                    ),
                    maxLines: 1,
                  ),
                ),
                15.w.horizontalSpace,
                FloatingActionButton(
                  mini: true,
                  onPressed: () async {
                    //controller.send();
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
