import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice_generator/view/screen/bottom/signature/signature%20controller.dart';
import 'package:signature/signature.dart';
import 'dart:typed_data';
import '../../../../colors/colours.dart';

class AddSignature extends StatelessWidget {
  AddSignature({super.key});

  @override
  Widget build(BuildContext context) {
    SignatureControllerX signatureController = Get.put(SignatureControllerX());
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: white),
        ),
        backgroundColor: black,
        elevation: 0,
        title: Text(
          "Add Signature",
          style: TextStyle(color: white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: black,
                  border: Border.all(color: Colors.white38),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Signature(
                    controller: signatureController.Signaturecontroller,
                    backgroundColor: black,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: signatureController.clearSignature,
                    icon: Icon(Icons.clear, color: Colors.white),
                    label: Text("Clear", style: TextStyle(color: white)),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      signatureController.saveSignature();
                      Get.back();
                    },
                    icon: Icon(Icons.check, color: Colors.white),
                    label: Text("Save", style: TextStyle(color: white)),
                  ),
                ),
              ],
            ),
          ),
          Obx(() {
            final sig = signatureController.signature.value;
            if (sig != null && sig.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Column(
                  children: [
                    Text(
                      'Preview',
                      style: TextStyle(color: white70, fontSize: 16),
                    ),
                    SizedBox(height: 8),
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
                  ],
                ),
              );
            }
            return SizedBox.shrink();
          }),
        ],
      ),
    );
  }
}
