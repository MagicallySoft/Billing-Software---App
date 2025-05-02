import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice_generator/view/screen/bottom/signature/signature%20controller.dart';
import '../../../../colors/colours.dart';
import '../../../../routes/routes.dart';

class SignatureScreen extends StatelessWidget {
  const SignatureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the controller for managing signature state
    SignatureControllerX signatureController = Get.put(SignatureControllerX());

    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: white),
        ),
        backgroundColor: black,
        elevation: 0,
        title: Text(
          "Signature",
          style: TextStyle(color: white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Obx(() {
        final sig = signatureController.signature.value;
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(height: 20),
              if (sig != null && sig.isNotEmpty)
                Column(
                  children: [
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        border: Border.all(color: Colors.white54),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.all(8),
                      child: Image.memory(sig),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              if (sig == null || sig.isEmpty)
                Center(
                  child: Text(
                    "No Signature Added",
                    style: TextStyle(color: white70, fontSize: 18),
                  ),
                ),
            ],
          ),
        );
      }),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 8,
        ),
        child: ElevatedButton(
          onPressed: () {
            Get.toNamed(Routes.signature_add);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            padding: EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            "Add Signature",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
