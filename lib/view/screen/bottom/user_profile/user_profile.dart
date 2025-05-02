import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:invoice_generator/view/screen/bottom/user_profile/user_profile_controller.dart';

import '../../../../colors/colours.dart';
import '../../../../controllers/logout_controller.dart';

class UserProfile extends StatelessWidget {
  final controller = Get.put(UserProfileController());
  final logoutcontroller = Get.put(LogoutController());

  UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: white),
          onPressed: () => Get.back(),
        ),
        title: Text("User Profile", style: TextStyle(color: white)),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "User Details",
              style: TextStyle(
                color: white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.h),
            Container(
              decoration: BoxDecoration(
                color: grey900,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Obx(
                    () => ListTile(
                      leading: Icon(
                        Icons.account_circle_outlined,
                        color: Colors.blue,
                      ),
                      title: Text("User Name", style: TextStyle(color: white)),
                      subtitle: Text(
                        controller.userName.value.isEmpty
                            ? "Update User Name"
                            : controller.userName.value,
                        style: TextStyle(color: grey),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: white,
                        size: 16,
                      ),
                      onTap: () {
                        controller.nameController.text =
                            controller.userName.value;
                        showModal(
                          context,
                          "Enter User Name",
                          controller.nameController,
                          () {
                            controller.userName.value =
                                controller.nameController.text;
                            controller.addData();
                            Get.back();
                          },
                        );
                      },
                    ),
                  ),
                  Divider(color: Colors.grey.shade800),
                  Obx(
                    () => ListTile(
                      leading: Icon(Icons.email_outlined, color: Colors.blue),
                      title: Text(
                        "Email Address",
                        style: TextStyle(color: white),
                      ),
                      subtitle: Text(
                        controller.email.value.isEmpty
                            ? "Update your email address"
                            : controller.email.value,
                        style: TextStyle(color: grey),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: white,
                        size: 16,
                      ),
                      onTap: () {
                        controller.emailController.text =
                            controller.email.value;
                        showModal(
                          context,
                          "Enter Email",
                          controller.emailController,
                          () {
                            controller.email.value =
                                controller.emailController.text;
                            controller.addData();
                            Get.back();
                          },
                        );
                      },
                    ),
                  ),
                  Divider(color: Colors.grey.shade800),
                  Obx(
                    () => ListTile(
                      leading: Icon(Icons.phone_outlined, color: Colors.blue),
                      title: Text(
                        "Phone Number",
                        style: TextStyle(color: white),
                      ),
                      subtitle: Text(
                        controller.phone.value.isEmpty
                            ? "Update your contact no."
                            : controller.phone.value,
                        style: TextStyle(color: grey),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: white,
                        size: 16,
                      ),
                      onTap: () {
                        controller.phoneController.text =
                            controller.phone.value;
                        showModal(
                          context,
                          "Enter Phone Number",
                          controller.phoneController,
                          () {
                            controller.phone.value =
                                controller.phoneController.text;
                            controller.addData();
                            Get.back();
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25.h),
            Text(
              "Privacy Settings",
              style: TextStyle(
                color: white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.h),
            Container(
              decoration: BoxDecoration(
                color: grey900,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  GetBuilder<UserProfileController>(
                    builder: (context) {
                      return GestureDetector(
                        onTap: () {
                          log("clicked");
                          controller.clearData();
                        },
                        child: settingTile(
                          Icons.refresh,
                          Colors.red,
                          "Reset Data",
                        ),
                      );
                    },
                  ),
                  settingTile(
                    Icons.person_remove_alt_1_outlined,
                    Colors.blue,
                    "Delete Account",
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Confirm Logout"),
                            content: Text("Are you sure you want to logout?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  logoutcontroller.logout();
                                },
                                child: Text("Logout"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: settingTile(Icons.logout, Colors.blue, "Logout"),
                  ),
                ],
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  ListTile settingTile(IconData icon, Color iconColor, String text) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(text, style: TextStyle(color: Colors.white)),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        color: Colors.white,
        size: 16,
      ),
    );
  }

  void showModal(
    BuildContext context,
    String title,
    TextEditingController controller,
    VoidCallback onSave,
  ) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: grey900,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 16,
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Update ${title.split(' ')[1]}",
                            style: TextStyle(
                              color: white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp,
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () => Get.back(),
                            icon: Icon(Icons.close, color: white, size: 16.sp),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 16,
                      ),
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          labelText: title,
                          labelStyle: TextStyle(color: white),
                          filled: true,
                          fillColor: Colors.transparent,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white24),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: white),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        style: TextStyle(color: white),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: 80.h,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: onSave,
                            child: Text(
                              "Save",
                              style: TextStyle(
                                color: white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
