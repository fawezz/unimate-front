import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import '../Controllers/ProfileController.dart';

class ProfileView extends StatelessWidget {
  ProfileView({
    Key? key,
  }) : super(key: key);

  //_toggleController
  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 32),
                    child: Stack(
                          children: [
                            SizedBox(
                              height: Get.width * 0.25,
                              width: Get.width * 0.25,
                              child: Positioned(
                                left: 8,
                                child: CircleAvatar(
                                  radius: Get.width * 0.116,
                                  backgroundColor: HexColor("#00B4EF"),
                                  backgroundImage:
                                      Image.asset("assets/icons/seller.jpg")
                                          .image,
                                ),
                              ),
                            ),
                                 Positioned(
                                    bottom: 0,
                                    left: 0,
                                    child: Container(
                                      height: Get.width * 0.0966,
                                      width: Get.width * 0.0966,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      padding: const EdgeInsets.all(2),
                                      child: CircleAvatar(
                                        radius: Get.width * 0.4347,
                                        backgroundColor: HexColor("#E9E9E9"),
                                        child: const Icon(Icons.camera_alt_outlined),
                                      ),
                                    ),
                                  )
                          ],
                        ),
                ),
                    Padding(
                      padding: EdgeInsets.only(left: 24.sp),
                      child: Column(
                        children: [
                          Text(
                            "Ahmed Ben Talal",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                              color: HexColor("#0A3C5F"),
                            ),
                          ),
                          6.h.verticalSpace,
                          Text(
                            "+923003213215",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: HexColor("#0A3C5F"),
                            ),
                          )
                        ],
                      ),
                    ),
            (Get.height * 0.01).verticalSpace,
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Container(
                height: Get.height * 0.0886,
                width: Get.width * 0.884,
                decoration: BoxDecoration(
                  color: HexColor("#F1F4F9"),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.058),
                  child: 
                       const Text("aaaaa") 
                ),
              ),
            ),
            120.h.verticalSpace,
          ]
        ),
      ),
    ));
  }
}
