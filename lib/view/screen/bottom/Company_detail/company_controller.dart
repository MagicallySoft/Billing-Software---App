import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Company extends GetxController {
  TextEditingController companynameController = TextEditingController();
  TextEditingController gstController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController brandnameController = TextEditingController();
  TextEditingController panController = TextEditingController();
  TextEditingController alternatecontactController = TextEditingController();
  TextEditingController webController = TextEditingController();
  TextEditingController addressController1 = TextEditingController();
  TextEditingController addressController2 = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pincoadeController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController shipping1Controller = TextEditingController();
  TextEditingController shipping2Controller = TextEditingController();
  TextEditingController shippingcityController = TextEditingController();
  TextEditingController shippingstateController = TextEditingController();
  TextEditingController shippingpincodeController = TextEditingController();
  TextEditingController shippingcountryController = TextEditingController();

  void clearAddressFields() {
    addressController1.clear();
    addressController2.clear();
    pincoadeController.clear();
    cityController.clear();
    stateController.clear();
    countryController.clear();
    update();
  }

  void clearShippingFields() {
    shipping1Controller.clear();
    shipping2Controller.clear();
    shippingpincodeController.clear();
    shippingcityController.clear();
    shippingstateController.clear();
    shippingcountryController.clear();
    update();
  }

  void shipping() {
    final shippingData = {
      'shippingaddress1': shipping1Controller.text,
      'shippingaddress2': shipping2Controller.text,
      'shippingcity': shippingcityController.text,
      'shippingstate': shippingstateController.text,
      'shippingpincode': shippingpincodeController.text,
      'shippingcountry': shippingcountryController.text,
    };
    log(shippingData.toString());
  }

  void billing() {
    final billingData = {
      'address1': addressController1.text,
      'address2': addressController2.text,
      'city': cityController.text,
      'state': stateController.text,
      'pincode': pincoadeController.text,
      'country': countryController.text,
    };
    log(billingData.toString());
  }

  void saveAllData() {
    final allData = {
      'companyname': companynameController.text,
      'gst': gstController.text,
      'contact': contactController.text,
      'email': emailController.text,
      'brandname': brandnameController.text,
      'pan': panController.text,
      'alternatecontact': alternatecontactController.text,
      'web': webController.text,
      'address1': addressController1.text,
      'address2': addressController2.text,
      'city': cityController.text,
      'state': stateController.text,
      'pincode': pincoadeController.text,
      'country': countryController.text,
      'shippingaddress1': shipping1Controller.text,
      'shippingaddress2': shipping2Controller.text,
      'shippingcity': shippingcityController.text,
      'shippingstate': shippingstateController.text,
      'shippingpincode': shippingpincodeController.text,
      'shippingcountry': shippingcountryController.text,
    };
    log(allData.toString());
  }

  void sameAddress() {
    shipping1Controller.text = addressController1.text;
    shipping2Controller.text = addressController2.text;
    shippingcityController.text = cityController.text;
    shippingstateController.text = stateController.text;
    shippingpincodeController.text = pincoadeController.text;
    shippingcountryController.text = countryController.text;
    update();
  }
}
