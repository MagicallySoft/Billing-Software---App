import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class SignatureControllerX extends GetxController {
  var galleryImages = <File>[].obs;

  var defaultImageIndex = RxnInt();

  Future<void> pickImageFromGallery() async {
    try {
      final ImagePicker _picker = ImagePicker();
      final List<XFile>? pickedFiles = await _picker.pickMultiImage();
      if (pickedFiles != null && pickedFiles.isNotEmpty) {
        for (var pickedFile in pickedFiles) {
          File imageFile = File(pickedFile.path);
          galleryImages.add(imageFile);
        }
        if (defaultImageIndex.value == null && galleryImages.isNotEmpty) {
          defaultImageIndex.value = 0;
        }
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  void removeImage(int index) {
    if (index >= 0 && index < galleryImages.length) {
      galleryImages.removeAt(index);

      if (defaultImageIndex.value == index) {
        defaultImageIndex.value = null;
      } else if (defaultImageIndex.value != null &&
          defaultImageIndex.value! > index) {
        defaultImageIndex.value = defaultImageIndex.value! - 1;
      }
    }
  }

  void setDefaultImage(int index) {
    if (index >= 0 && index < galleryImages.length) {
      defaultImageIndex.value = index;
    }
  }

  File? get defaultImage {
    if (defaultImageIndex.value != null &&
        defaultImageIndex.value! < galleryImages.length) {
      return galleryImages[defaultImageIndex.value!];
    }
    return null;
  }
}
