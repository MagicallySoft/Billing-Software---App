import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../colors/colours.dart';
import '../../../controllers/guest_log in.dart';
import '../../../controllers/hide_pass.dart';
import '../../../controllers/log in.dart';
import '../../../effect/blur/blur.dart';
import '../register/register.dart';

class LoginScreen extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());
  final GuestLoginController guestController = Get.put(GuestLoginController());
  final HidePass pass = Get.put(HidePass());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(height: 23.h),
              Center(
                child: Text(
                  "Welcome To Invoice ",
                  style: lato(
                    color: white,
                    fontWeight: FontWeight.bold,
                    fontSize: 26.sp,
                  ),
                ),
              ),
              Center(
                child: Text(
                  "Login or Sign up to your  ",
                  style: lato(
                    color: white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp,
                  ),
                ),
              ),
              Center(
                child: Text(
                  "account",
                  style: lato(
                    color: white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp,
                  ),
                ),
              ),
              SizedBox(height: 42.h),
              Row(
                children: [
                  Text(
                    "Sign in",
                    style: lato(
                      color: white,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              TextFormField(
                controller: controller.emailController,
                style: lato(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 14.sp,
                ),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email, color: Colors.white70),
                  hintText: "Enter your email",
                  hintStyle: lato(
                    color: Colors.white54,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.normal,
                  ),
                  labelText: "Email",
                  labelStyle: lato(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal,
                  ),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.25),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(
                      color: Colors.white70.withOpacity(0.5),
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(
                      color: Colors.white54.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: Colors.redAccent, width: 2),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: Colors.redAccent, width: 2),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 16,
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email can't be empty";
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return "Enter a valid email";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.h),
              Obx(
                () => TextFormField(
                  controller: controller.passwordController,
                  obscureText: pass.isPasswordVisible.value,
                  style: TextStyle(color: Colors.white, fontSize: 14),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock, color: Colors.white70),
                    suffixIcon: IconButton(
                      icon: Icon(
                        pass.isPasswordVisible.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.white70,
                      ),
                      onPressed: pass.togglePasswordVisibility,
                    ),
                    hintText: "Enter your password",
                    hintStyle: TextStyle(color: Colors.white54, fontSize: 12),
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.white, fontSize: 14),
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.25),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(
                        color: Colors.white70.withOpacity(0.5),
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(
                        color: Colors.white54.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(
                        color: Colors.blueAccent,
                        width: 2,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(color: Colors.redAccent, width: 2),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(color: Colors.redAccent, width: 2),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 16,
                    ),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.forgotPassword();
                    },
                    child: Text(
                      "Forgot Password ?",
                      style: lato(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: white),
                  onPressed: () {
                    log(
                      "Login Attempt: Email: ${controller.emailController.text}, Password: ${controller.passwordController.text}",
                    );

                    showBlurOverlay(context);
                    controller.login();
                  },
                  child: Text(
                    "Log in",
                    style: lato(
                      color: black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.to(() => RegisterScreen());
                },
                child: Text(
                  "Don't have an account ? Sign up",
                  style: lato(
                    color: white,
                    fontWeight: FontWeight.normal,
                    fontSize: 12.sp,
                  ),
                ),
              ),
              SizedBox(height: 55.h),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          showBlurOverlay(context);
                          controller.googleSignInUser();
                        },
                        icon: Image.network(
                          'https://tse1.mm.bing.net/th?id=OIP.t4Z5Wlv7qFqdBCKwFdKkYAHaHa&pid=Api&P=0&h=180',
                          height: 28,
                        ),
                        label: Text(
                          "Sign in with Google",
                          style: lato(
                            fontSize: 15.sp,
                            color: black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 14),
                          backgroundColor: white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          showBlurOverlay(context);
                          guestController.signInAnonymously();
                        },
                        icon: Image.network(
                          'https://tse2.mm.bing.net/th?id=OIP.5oh4OARW4iNwMSe4BzpPZQHaHa&pid=Api&P=0&h=180',
                          height: 28,
                        ),
                        label: Text(
                          "Sign in as A Guest",
                          style: lato(
                            fontSize: 15.sp,
                            color: black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 14),
                          backgroundColor: white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(),
              Column(
                children: [
                  Text(
                    "By signin in with account you agree to invoice",
                    style: lato(
                      color: white,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    "Terms of Service and Privacy Policy",
                    style: lato(
                      color: white,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.normal,
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
