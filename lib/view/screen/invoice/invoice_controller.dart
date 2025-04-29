import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../colors/colours.dart';
import 'invoice_model.dart';

class InvoiceController extends GetxController {
  TextEditingController addressController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController refrenceController = TextEditingController();
  TextEditingController ifscController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController termsController = TextEditingController();
  TextEditingController openingBalance = TextEditingController();
  var dispatchAddress = ''.obs;

  var selectedCustomer = Get.arguments ?? 'Customer Name';
  RxString paymentMethod = 'Cash'.obs;
  File? signatureImage;

  RxList<InvoiceData> invoiceList = <InvoiceData>[].obs;
  int? id;
  Rx<DateTime?> dueDate = Rx<DateTime?>(null);

  Future<void> pickSignatureFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      signatureImage = File(pickedFile.path);
      update();
    }
  }

  String generateInvoiceId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    id = 'INV-$timestamp' as int?;
    update();
    return 'INV-$timestamp';
  }

  void clearData() {
    addressController.clear();
    bankNameController.clear();
    accountNumberController.clear();
    refrenceController.clear();
    ifscController.clear();
    notesController.clear();
    termsController.clear();
    openingBalance.clear();
    signatureImage = null;
    paymentMethod = 'Cash'.obs;

    dispatchAddress.value = '';
    dueDate.value = null;
    update();
  }

  void saveInvoiceData() {
    InvoiceData invoice = InvoiceData(
      address: addressController.text,
      bankName: bankNameController.text,
      accountNumber: accountNumberController.text,
      reference: refrenceController.text,
      ifscCode: ifscController.text,
      notes: notesController.text,
      terms: termsController.text,
      paymentMethod: paymentMethod.value,
      signatureImage: signatureImage,
      customerName: selectedCustomer.toString(),
      date: DateTime.now(),
      due: dueDate.value ?? DateTime.now(),
      id: id ?? 0,
    );

    log(addressController.text);
    log(bankNameController.text);
    log(accountNumberController.text);
    log(refrenceController.text);
    log(ifscController.text);
    log(notesController.text);
    log(termsController.text);
    log(paymentMethod.value);
    log(signatureImage.toString());
    log(id.toString());
    invoiceList.add(invoice);
    log("Invoice Saved. Total Invoices: ${invoiceList.length}");

    Get.snackbar(
      "Success",
      "Invoice created successfully!",
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
    update();
  }

  Future<void> selectDueDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dueDate.value ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      dueDate.value = picked;
      update();
    }
  }

  Widget buildInvoiceInfo(BuildContext context) {
    DateTime date = DateTime.now();
    return Transform.scale(
      scale: 1,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Invoice #", style: TextStyle(color: Colors.grey)),
              const Text(
                "INV-1",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              Row(
                children: [
                  Text(
                    date.toString().split(' ')[0],
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => selectDueDate(context),
                    child: Row(
                      children: [
                        const SizedBox(width: 55),
                        const Text(
                          "Due Date: ",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Obx(() {
                          return Text(
                            dueDate.value != null
                                ? dueDate.value.toString().split(' ')[0]
                                : "Select Date",
                            style: const TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }),
                        const SizedBox(width: 6),
                        const Icon(
                          Icons.calendar_today,
                          color: Colors.grey,
                          size: 16,
                        ),
                      ],
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

  Widget buildSection(String title, String buttonText) {
    return Card(
      color: Colors.grey[900],
      child: ListTile(
        title: Text(title, style: const TextStyle(color: Colors.white)),
        trailing: TextButton(
          onPressed: () {},
          child: Text(
            "$buttonText",
            style: const TextStyle(color: Colors.blue),
          ),
        ),
      ),
    );
  }

  void dropDown({required BuildContext context}) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: grey900,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButton<String>(
                    value: paymentMethod.value,
                    dropdownColor: grey900,
                    style: TextStyle(color: white),
                    underline: const SizedBox(),
                    items:
                        ['Cash', 'Bank'].map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text(e, style: TextStyle(color: white)),
                          );
                        }).toList(),
                    onChanged: (val) {
                      setState(() {
                        paymentMethod.value = val!;
                      });
                    },
                  ),
                  if (paymentMethod == 'Bank') ...[
                    const SizedBox(height: 10),
                    buildBankField("Bank Name", bankNameController),
                    const SizedBox(height: 10),
                    buildBankField("Account Number", accountNumberController),
                    const SizedBox(height: 10),
                    buildBankField("IFSC Code", ifscController),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: blue),
                      child: Text(
                        "Save",
                        style: TextStyle(
                          color: white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            );
          },
        );
      },
    );
  }

  // Widget to build bank-related fields
  Widget buildBankField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      style: TextStyle(color: white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: white),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white24),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: white),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
