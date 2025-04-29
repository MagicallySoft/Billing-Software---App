import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerController extends GetxController {
  final formKey = GlobalKey<FormState>();
  RxInt editingIndex = (-1).obs;
  final customers = <Map<String, String>>[].obs;
  RxBool isSameAsBilling = false.obs;
  RxString balanceType = 'Credit'.obs;

  var selectedPriceList = ''.obs;
  List<String> priceListOptions = ['Standard', 'Premium', 'Wholesale'];
  var isAddressEmpty = true.obs;

  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final emailController = TextEditingController();
  final companyController = TextEditingController();
  final gstController = TextEditingController();
  final addressController1 = TextEditingController();
  final addressController2 = TextEditingController();
  final pinecodeController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final countryController = TextEditingController();
  final discountController = TextEditingController();
  final creditLimitController = TextEditingController();
  final panController = TextEditingController();
  final ccemailController = TextEditingController();
  final shippingadd1 = TextEditingController();
  final shippingadd2 = TextEditingController();
  final shippingcity = TextEditingController();
  final shippingstate = TextEditingController();
  final shippingcountry = TextEditingController();
  final shippingpincode = TextEditingController();
  final notesController = TextEditingController();
  final addTageController = TextEditingController();
  final openingBalance = TextEditingController();

  String generateCustomerId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return 'CUST-$timestamp';
  }

  void setSelectedPriceList(String value) {
    selectedPriceList.value = value;
    update();
  }

  void deletCustomer({required index}) {
    customers.removeAt(index);
    update();
  }

  void loadCustomerForEdit(int index) {
    final customer = customers[index];
    nameController.text = customer['name'] ?? '';
    numberController.text = customer['number'] ?? '';
    emailController.text = customer['email'] ?? '';
    companyController.text = customer['company'] ?? '';
    gstController.text = customer['gst'] ?? '';
    addressController1.text = customer['address1'] ?? '';
    addressController2.text = customer['address2'] ?? '';
    pinecodeController.text = customer['pincode'] ?? '';
    cityController.text = customer['city'] ?? '';
    stateController.text = customer['state'] ?? '';
    countryController.text = customer['country'] ?? '';
    discountController.text = customer['discount'] ?? '';
    creditLimitController.text = customer['creditLimit'] ?? '';
    selectedPriceList.value = customer['priceList'] ?? '';
    panController.text = customer['pan'] ?? '';
    ccemailController.text = customer['ccemail'] ?? '';
    shippingadd1.text = customer['shippingadd1'] ?? '';
    shippingadd2.text = customer['shippingadd2'] ?? '';
    shippingcity.text = customer['shippingcity'] ?? '';
    shippingstate.text = customer['shippingstate'] ?? '';
    shippingcountry.text = customer['shippingcountry'] ?? '';
    shippingpincode.text = customer['shippingpincode'] ?? '';
    notesController.text = customer['notes'] ?? '';
    addTageController.text = customer['addTage'] ?? '';
    openingBalance.text = customer['openingBalance'] ?? '';
    editingIndex.value = index;
  }

  void clearFields() {
    nameController.clear();
    numberController.clear();
    emailController.clear();
    companyController.clear();
    gstController.clear();
    addressController1.clear();
    addressController2.clear();
    pinecodeController.clear();
    stateController.clear();
    cityController.clear();
    countryController.clear();
    discountController.clear();
    creditLimitController.clear();
    panController.clear();
    ccemailController.clear();
    shippingadd1.clear();
    shippingadd2.clear();
    shippingcity.clear();
    shippingstate.clear();
    shippingcountry.clear();
    shippingpincode.clear();
    notesController.clear();
    addTageController.clear();
    selectedPriceList.value = '';
    isAddressEmpty.value = true;
    openingBalance.clear();
    editingIndex.value = -1;
  }

  void addOrUpdateCustomer() {
    if (formKey.currentState!.validate()) {
      final newCustomer = {
        'name': nameController.text,
        'number': numberController.text,
        'email': emailController.text,
        'company': companyController.text,
        'gst': gstController.text,
        'address1': addressController1.text,
        'address2': addressController2.text,
        'pincode': pinecodeController.text,
        'city': cityController.text,
        'state': stateController.text,
        'country': countryController.text,
        'discount': discountController.text,
        'creditLimit': creditLimitController.text,
        'priceList': selectedPriceList.value,
        'pan': panController.text,
        'ccemail': ccemailController.text,
        'shippingadd1': shippingadd1.text,
        'shippingadd2': shippingadd2.text,
        'shippingcity': shippingcity.text,
        'shippingstate': shippingstate.text,
        'shippingcountry': shippingcountry.text,
        'shippingpincode': shippingpincode.text,
        'notes': notesController.text,
        'addTage': addTageController.text,
        'openingBalance': openingBalance.text,
      };

      if (editingIndex.value >= 0) {
        newCustomer['customerId'] =
            customers[editingIndex.value]['customerId']!;
        customers[editingIndex.value] = newCustomer;
        editingIndex.value = -1;
      } else {
        newCustomer['customerId'] = generateCustomerId();
        customers.add(newCustomer);
      }
      log('customersid: ${customers[customers.length - 1]['customerId']}');
      clearFields();
      Get.back();
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    numberController.dispose();
    emailController.dispose();
    companyController.dispose();
    gstController.dispose();
    addressController1.dispose();
    addressController2.dispose();
    cityController.dispose();
    pinecodeController.dispose();
    stateController.dispose();
    countryController.dispose();
    discountController.dispose();
    creditLimitController.dispose();
    panController.dispose();
    ccemailController.dispose();
    shippingadd1.dispose();
    shippingadd2.dispose();
    shippingcity.dispose();
    shippingstate.dispose();
    shippingcountry.dispose();
    shippingpincode.dispose();
    notesController.dispose();
    addTageController.dispose();
    openingBalance.dispose();
    super.onClose();
  }

  void copyBillingToShipping() {
    shippingadd1.text = addressController1.text;
    shippingadd2.text = addressController2.text;
    shippingcity.text = cityController.text;
    shippingstate.text = stateController.text;
    shippingcountry.text = countryController.text;
    shippingpincode.text = pinecodeController.text;
    update();
  }
}
