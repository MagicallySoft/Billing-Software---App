import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BankController extends GetxController {
  TextEditingController ifscController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController accountNoController = TextEditingController();
  TextEditingController confirmAccountNoController = TextEditingController();
  TextEditingController branchNameController = TextEditingController();
  TextEditingController upiController = TextEditingController();
  TextEditingController openingBalanceController = TextEditingController();

  var bankAccounts = <Map<String, String>>[].obs;
  var defaultAccountIndex = (-1).obs;

  void addAccount() {
    bankAccounts.add({
      'ifsc': ifscController.text,
      'bankName': bankNameController.text,
      'accountNo': accountNoController.text,
      'confirmAccountNo': confirmAccountNoController.text,
      'branchName': branchNameController.text,
      'upi': upiController.text,
      'openingBalance': openingBalanceController.text,
    });
    update();
  }

  void CheckAccountNo() {
    if (accountNoController.text != confirmAccountNoController.text) {
      Get.snackbar(
        "Error",
        "Account numbers do not match.",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
  }

  void setDefaultAccount(int index) {
    defaultAccountIndex.value = index;
    Get.snackbar(
      "Default Account",
      "This account is set as default.",
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
    update();
  }

  void clearFields() {
    ifscController.clear();
    bankNameController.clear();
    accountNoController.clear();
    confirmAccountNoController.clear();
    branchNameController.clear();
    upiController.clear();
    openingBalanceController.clear();
    update();
  }
}
