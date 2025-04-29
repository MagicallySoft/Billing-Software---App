import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HidePass extends GetxController {
  var isPasswordVisible = true.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  final TextEditingController passwordController = TextEditingController();
}
