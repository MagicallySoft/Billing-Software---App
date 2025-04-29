import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice_generator/colors/colours.dart';
import 'package:invoice_generator/routes/routes.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      checkLoginStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: Duration(seconds: 2),
              curve: Curves.easeInOut,
              child: Image.asset('assets/icon/invoice_logo.png', height: 100),
            ),
            SizedBox(height: 20),
            Text(
              "Invoice Generator",
              style: lato(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void checkLoginStatus() async {
    await Future.delayed(Duration(seconds: 3));
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Get.offNamed(Routes.home);
    } else {
      Get.offNamed(Routes.intro_1);
    }
  }
}
