import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../colors/colours.dart';
import 'bank_controller.dart';

class AddAccount extends StatelessWidget {
  AddAccount({super.key});

  final BankController controller = Get.put(BankController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: black,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: white),
        ),
        title: Text("Add New Bank Detail", style: TextStyle(color: white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(
              "Bank details",
              style: TextStyle(
                color: white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),

            // IFSC
            Text("Bank IFSC*", style: TextStyle(color: white)),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: controller.ifscController,
                    style: TextStyle(color: white),
                    decoration: InputDecoration(
                      hintText: "Enter Bank IFSC code",
                      hintStyle: TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.grey[900],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.only(left: 20, right: 1),
                    child: Center(
                      child: Text(
                        "Fetch Bank Details",
                        style: lato(
                          color: white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Bank name
            Text("Bank name*", style: TextStyle(color: white)),
            SizedBox(height: 8),
            TextField(
              controller: controller.bankNameController,
              style: TextStyle(color: white),
              decoration: InputDecoration(
                hintText: "Enter bank name",
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 16),

            // Account no.
            Text("Bank account no.*", style: TextStyle(color: white)),
            SizedBox(height: 8),
            TextField(
              controller: controller.accountNoController,
              keyboardType: TextInputType.number,
              style: TextStyle(color: white),
              decoration: InputDecoration(
                hintText: "Enter bank account number",
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 16),

            // Confirm account no.
            Text("Confirm Bank account no.*", style: TextStyle(color: white)),
            SizedBox(height: 8),
            TextField(
              controller: controller.confirmAccountNoController,
              keyboardType: TextInputType.number,
              style: TextStyle(color: white),
              decoration: InputDecoration(
                hintText: "Confirm Your Bank Account Number",
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 16),

            // Branch name
            Text("Bank branch name*", style: TextStyle(color: white)),
            SizedBox(height: 8),
            TextField(
              controller: controller.branchNameController,
              style: TextStyle(color: white),
              decoration: InputDecoration(
                hintText: "Enter bank branch name",
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 16),

            // UPI
            Text("UPI", style: TextStyle(color: white)),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: TextField(
                    controller: controller.upiController,
                    style: TextStyle(color: white),
                    decoration: InputDecoration(
                      hintText: "Enter UPI (Optional)",
                      hintStyle: TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.grey[900],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.only(left: 3, right: 1),
                    child: Center(
                      child: Text(
                        "Verify UPI",
                        style: lato(
                          color: white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            Text(
              "This UPI ID will be used to generate Dynamic QR codes on the invoices and bills.",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            SizedBox(height: 16),

            Text("Opening balance", style: TextStyle(color: white)),
            SizedBox(height: 8),
            TextField(
              controller: controller.openingBalanceController,
              keyboardType: TextInputType.number,
              style: TextStyle(color: white),
              decoration: InputDecoration(
                hintText: "Opening balance (Optional)",
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            onPressed: () {
              controller.CheckAccountNo();
              if (controller.bankNameController.text.isNotEmpty &&
                  controller.accountNoController.text.isNotEmpty &&
                  controller.confirmAccountNoController.text.isNotEmpty &&
                  controller.branchNameController.text.isNotEmpty) {
                controller.addAccount();
              }
              log(controller.bankAccounts.toString());
              controller.clearFields();
            },
            child: Text(
              "Add New Bank",
              style: TextStyle(color: white, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
