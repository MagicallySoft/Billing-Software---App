import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class GuestLoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var user = Rxn<User>();

  @override
  void onInit() {
    super.onInit();
    user.value = _auth.currentUser;
    _auth.authStateChanges().listen((User? newUser) {
      user.value = newUser;
    });
  }

  Future<void> signInAnonymously() async {
    try {
      if (user.value != null) {
        log("✅ User already signed in: ${user.value?.uid}");
        Get.offNamed('/home');
        return;
      }

      UserCredential userCredential = await _auth.signInAnonymously();
      user.value = userCredential.user;
      log("✅ Signed in anonymously: ${userCredential.user?.uid}");
      Get.offNamed('/home');
    } on FirebaseAuthException catch (e) {
      String errorMessage = "An error occurred: ${e.message}";
      if (e.code == "operation-not-allowed") {
        errorMessage = "Anonymous sign-in is disabled in Firebase.";
      }

      Get.snackbar(
        "Login Error",
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    }
  }
}
