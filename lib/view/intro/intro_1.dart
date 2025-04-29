import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:invoice_generator/colors/colours.dart';

import '../../routes/routes.dart';

class Intro1 extends StatefulWidget {
  const Intro1({super.key});

  @override
  State<Intro1> createState() => _Intro1State();
}

class _Intro1State extends State<Intro1> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text.rich(
                TextSpan(
                  text: 'Welcome to ',
                  style: TextStyle(
                    color: white,
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: 'Invoice Generator',
                      style: TextStyle(
                        color: blue,
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    " To your desire",
                    style: TextStyle(
                      color: white,
                      fontWeight: FontWeight.w300,
                      fontSize: 24.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 100.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 6.h,
                    width: 16.w,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Container(
                    height: 6.h,
                    width: 16.w,
                    decoration: BoxDecoration(
                      color: blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Container(
                    height: 6.h,
                    width: 16.w,
                    decoration: BoxDecoration(
                      color: blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      Get.offNamed(Routes.login);
                    },
                    child: Text(
                      "Skip",
                      style: TextStyle(
                        color: white,
                        fontWeight: FontWeight.normal,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () async {
                      Get.offNamed(Routes.intro_2);
                    },
                    child: CircleAvatar(
                      radius: 30.w,
                      backgroundColor: blue,
                      child: Icon(Icons.arrow_forward_ios_sharp, color: white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
