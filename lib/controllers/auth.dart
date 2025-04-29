import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/routes.dart';

class AuthController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var isLoading = false.obs;

  Future<void> login() async {
    isLoading.value = true;
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Get.offNamedUntil(Routes.home, (route) => false);
    } on FirebaseAuthException catch (e) {
      _showErrorSnackbar(_getErrorMessage(e.code));
    } catch (e) {
      _showErrorSnackbar("An unexpected error occurred. Please try again.");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register() async {
    if (!_validateFields()) return;

    isLoading.value = true;
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

      User? user = userCredential.user;

      Get.offNamed(Routes.login);
    } on FirebaseAuthException catch (e) {
      _showErrorSnackbar(_getErrorMessage(e.code));
    } catch (e) {
      _showErrorSnackbar("An unexpected error occurred. Please try again.");
    } finally {
      isLoading.value = false;
    }
  }

  bool _validateFields() {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      _showErrorSnackbar("Please enter both email and password.");
      return false;
    }
    if (passwordController.text.trim().length < 6) {
      _showErrorSnackbar("Password must be at least 6 characters long.");
      return false;
    }
    return true;
  }

  void _showErrorSnackbar(String message) {
    Get.snackbar(
      "Error",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
    );
  }

  String _getErrorMessage(String errorCode) {
    switch (errorCode) {
      case "invalid-email":
        return "Invalid email format.";
      case "user-disabled":
        return "This user account has been disabled.";
      case "user-not-found":
        return "No account found with this email.";
      case "wrong-password":
        return "Incorrect password. Please try again.";
      case "email-already-in-use":
        return "This email is already registered. Try logging in.";
      case "weak-password":
        return "Your password is too weak. Use a stronger password.";
      case "network-request-failed":
        return "Network error. Please check your internet connection.";
      case "too-many-requests":
        return "Too many login attempts. Please wait and try again.";
      default:
        return "An unknown error occurred. Please try again.";
    }
  }
}
