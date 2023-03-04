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
          child: Stack(
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
                        return Container(
                          padding: const EdgeInsets.only(
                              left: 14, right: 14, top: 10, bottom: 10),
                          child: Align(
                              alignment: (index.isEven
                                  ? Alignment.topLeft
                                  : Alignment.topRight),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: (index.isEven
                                      ? thirdColor
                                      : primaryColor),
                                ),
                                padding: const EdgeInsets.all(16),
                                child: Text(
                                  controller.questions[index],
                                  style: TextStyle(fontSize: 15.sp),
                                ),
                              )),
                        );
                      }),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
          height: 60,
          width: double.infinity,
          color: Colors.white,
          child: Row(
            children: <Widget>[
              15.w.horizontalSpace,
              const Expanded(
                child: TextField(
                  style: TextStyle(fontSize: 19),
                  //controller: messageController,
                  decoration: InputDecoration(
                    hintText: "Ask a question...",
                    hintStyle: TextStyle(color: Colors.black54, fontSize: 18),
                    border: InputBorder.none,
                  ),
                ),
              ),
              15.w.horizontalSpace,
              FloatingActionButton(
                mini: true,
                onPressed: () async {
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
        )
      ]),
    ));
  }
}
