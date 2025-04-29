import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:invoice_generator/routes/routes.dart';

class LoginController extends GetxController {
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
      Get.offNamed(Routes.home);
    } on FirebaseAuthException catch (e) {
      _showErrorSnackbar(_getErrorMessage(e.code));
    } catch (e) {
      _showErrorSnackbar("An unexpected error occurred. Please try again.");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logoutUser() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offNamed(Routes.login);
    } catch (e) {
      log("Error logging out: $e");
    }
  }

  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<void> googleSignInUser() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        _showErrorSnackbar("Google Sign-In was cancelled.");
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      Get.offNamed(Routes.home);
    } catch (e) {
      _showErrorSnackbar("Failed to sign in with Google. Please try again.");
    }
  }

  String getCurrentUserName() {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      for (var provider in user.providerData) {
        if (provider.providerId == "password") {
          return user.email?.split("@").first ?? "User";
        } else if (provider.providerId == "google.com") {
          return user.email ?? "User";
        }
      }
    }

    return "Guest";
  }

  Future<void> forgotPassword() async {
    if (emailController.text.trim().isEmpty) {
      _showErrorSnackbar("Please enter your email address.");
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );
      Get.snackbar(
        "Success",
        "A password reset link has been sent to your email.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } on FirebaseAuthException catch (e) {
      _showErrorSnackbar(_getErrorMessage(e.code));
    } catch (e) {
      _showErrorSnackbar("An error occurred. Please try again.");
    }
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
        return "The email address is invalid.";
      case "user-disabled":
        return "This user account has been disabled.";
      case "user-not-found":
        return "No account found with this email.";
      case "wrong-password":
        return "Incorrect password. Please try again.";
      case "network-request-failed":
        return "Network error. Please check your connection.";
      case "too-many-requests":
        return "Too many login attempts. Please try again later.";
      case "email-already-in-use":
        return "This email is already registered. Please log in.";
      case "weak-password":
        return "Your password is too weak. Try a stronger one.";
      default:
        return "An unknown error occurred. Please try again.";
    }
  }
}
