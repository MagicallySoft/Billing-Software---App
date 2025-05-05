import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:invoice_generator/view/screen/bottom/signature/signature%20controller.dart';
import '../../../../colors/colours.dart';

class SignatureScreen extends StatelessWidget {
  const SignatureScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final SignatureControllerX signatureController = Get.put(
      SignatureControllerX(),
    );
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
          "Signatures",
          style: lato(
            color: white,
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
      ),
      body: Obx(() {
        final images = signatureController.galleryImages;
        final defaultIndex = signatureController.defaultImageIndex.value;
        if (images.isEmpty) {
          return Center(
            child: Text(
              "No signatures picked yet.",
              style: lato(
                color: white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }

        return ListView.separated(
          itemCount: images.length,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final image = images[index];
            final isDefault = index == defaultIndex;
            return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color:
                          isDefault ? Colors.greenAccent : Colors.transparent,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      image,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                if (isDefault)
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Chip(
                      backgroundColor: Colors.green.withOpacity(0.9),
                      label: Text(
                        "Default",
                        style: lato(
                          color: white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      signatureController.setDefaultImage(index);
                      log(
                        "default index: ${signatureController.defaultImageIndex.value}",
                      );
                    },
                    icon: Icon(
                      isDefault ? Icons.check_circle : Icons.star_border,
                      size: 16,
                      color: white,
                    ),
                    label: Text(
                      isDefault ? "Default" : "Set Default",
                      style: lato(
                        color: white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDefault ? Colors.grey : Colors.indigo,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
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
            showModalBottomSheet(
              context: context,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              backgroundColor: Colors.black,
              builder: (_) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        "Add Signature",
                        style: lato(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Divider(thickness: 1),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.indigo.shade50,
                          child: Icon(
                            Icons.photo_library,
                            color: Colors.indigo,
                          ),
                        ),
                        title: Text(
                          'Pick from Gallery',
                          style: lato(
                            color: white,
                            fontWeight: FontWeight.normal,
                            fontSize: 14.sp,
                          ),
                        ),
                        onTap: () {
                          Get.back();
                          signatureController.pickImageFromGallery();
                        },
                      ),

                      SizedBox(height: 8),
                    ],
                  ),
                );
              },
            );
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
            style: lato(
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
