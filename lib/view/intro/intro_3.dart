import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:invoice_generator/colors/colours.dart';

import '../../routes/routes.dart';

class Intro3 extends StatelessWidget {
  const Intro3({super.key});

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
              Spacer(),
              Image.asset("assets/photos/intro_3.png", height: 300),
              Spacer(),
              Text.rich(
                TextSpan(
                  text: 'Make Connection ',
                  style: TextStyle(
                    color: white,
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: ' With Invoice Generator',
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
                    "To your Support",
                    style: lato(
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
                  Container(
                    height: 6.h,
                    width: 16.w,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.offNamed(Routes.login);
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
