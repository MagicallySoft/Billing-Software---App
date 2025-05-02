import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfileController extends GetxController {
  var userName = ''.obs;
  var email = ''.obs;
  var phone = ''.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  List data = [];

  void clearData() {
    userName.value = '';
    email.value = '';
    phone.value = '';

    nameController.clear();
    emailController.clear();
    phoneController.clear();
  }

  void addData() {
    data.add({
      'name': nameController.text,
      'email': emailController.text,
      'phone': phoneController.text,
    });
    log(data.toString());
  }
}
