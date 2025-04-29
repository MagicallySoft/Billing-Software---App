import 'dart:io';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProductController extends GetxController {
  final List<String> units = [
    'Kilogram',
    'Gram',
    'Liter',
    'Piece',
    'Dozen',
    'Meter',
  ];

  var selectedImages = <File>[].obs;
  int? editingIndex;

  RxString selectedType = "Product".obs;

  final TextEditingController unitController = TextEditingController();
  TextEditingController productName = TextEditingController();
  TextEditingController sellingPrice = TextEditingController();
  TextEditingController Tax = TextEditingController();
  TextEditingController purchaseRate = TextEditingController();
  TextEditingController hsn = TextEditingController();
  TextEditingController category = TextEditingController();

  TextEditingController description = TextEditingController();
  var productData = <Map<String, dynamic>>[].obs;

  void submitData() {
    productData.add({
      'productId': generateProductId(),
      'Product Name': productName.text,
      'Selling Price': sellingPrice.text,
      'Tax Rate': Tax.text,
      'Purchase Price': purchaseRate.text,
      'Unit': unitController.text,
      'hsn': hsn.text,
      'category': category.text,
      'description': description.text,
      'images': selectedImages.map((image) => image.path).join(','),
    });
  }

  String generateProductId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return 'PRD-$timestamp';
  }

  void clearFields() {
    productName.clear();
    sellingPrice.clear();
    Tax.clear();
    purchaseRate.clear();
    unitController.clear();
    hsn.clear();
    category.clear();
    description.clear();
  }

  Future<void> pickImages() async {
    final pickedFiles = await ImagePicker().pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      selectedImages.value =
          pickedFiles.map((file) => File(file.path)).toList();
    } else {
      log("No images selected");
    }
  }

  void removeImage(int index) {
    if (index >= 0 && index < selectedImages.length) {
      selectedImages.removeAt(index);
    }
  }

  void addProduct() {
    final newData = {
      'productId': generateProductId(),
      'Product Name': productName.text,
      'Selling Price': sellingPrice.text,
      'Tax Rate': Tax.text,
      'Purchase Price': purchaseRate.text,
      'Unit': unitController.text,
      'hsn': hsn.text,
      'category': category.text,
      'description': description.text,
      'images': selectedImages.map((image) => image.path).join(','),
    };

    log("Product id ${newData['productId']} ");
    if (editingIndex != null &&
        editingIndex! >= 0 &&
        editingIndex! < productData.length) {
      newData['productId'] = productData[editingIndex!]['productId'];
      productData[editingIndex!] = newData;
    } else {
      productData.add(newData);
    }

    editingIndex = null;
    clearFields();
  }

  void editProduct(int index) {
    if (index >= 0 && index < productData.length) {
      editingIndex = index;

      final product = productData[index];
      productName.text = product['Product Name'] ?? '';
      sellingPrice.text = product['Selling Price'] ?? '';
      Tax.text = product['Tax Rate'] ?? '';
      purchaseRate.text = product['Purchase Price'] ?? '';
      unitController.text = product['Unit'] ?? '';
      hsn.text = product['hsn'] ?? '';
      category.text = product['category'] ?? '';
      description.text = product['description'] ?? '';

      selectedImages.value =
          (product['images'] as String)
              .split(',')
              .where((path) => path.isNotEmpty)
              .map((path) => File(path))
              .toList();
    }
  }

  void deleteProduct(int index) {
    if (index >= 0 && index < productData.length) {
      productData.removeAt(index);
    }
  }
}
