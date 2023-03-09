import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class SettingsSheet extends StatelessWidget {
  const SettingsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40))),
      child: Wrap(children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                    child: Container(
                  height: 8,
                  width: 66,
                  decoration: BoxDecoration(
                      color: HexColor("##EBEBEB"),
                      borderRadius: BorderRadius.circular(10)),
                )),
                0.03.sh.verticalSpace,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () async {},
                    child: Row(children: [
                      Container(
                        height: 40.h,
                        width: 40.h,
                        decoration: BoxDecoration(
                            color: HexColor("#EBEFF2"),
                            borderRadius: BorderRadius.circular(40)),
                        child: const Icon(Icons.camera_enhance_outlined),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 14),
                        child: Text(
                          "Camera",
                          style: TextStyle(
                              color: HexColor("#0A3C5F"),
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () async {},
                    child: Row(children: [
                      Container(
                        height: 40.h,
                        width: 40.h,
                        decoration: BoxDecoration(
                            color: HexColor("#EBEFF2"),
                            borderRadius: BorderRadius.circular(40)),
                        child: const Icon(Icons.image),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 14),
                        child: Text(
                          "Gallery",
                          style: TextStyle(
                              color: HexColor("#0A3C5F"),
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ]),
                  ),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
