import 'dart:io';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

enum SortOption { lowToHigh, highToLow, aToZ, zToA }

class ProductController extends GetxController {
  final List<String> units = [
    'Kilogram',
    'Gram',
    'Liter',
    'Piece',
    'Dozen',
    'Meter',
  ];

  RxList<File> selectedImages = <File>[].obs;
  int? editingIndex;
  RxInt qty = 1.obs;
  RxString selectedType = "Product".obs;
  RxSet<int> selectedIndexes = <int>{}.obs;

  TextEditingController unitController = TextEditingController();
  TextEditingController productName = TextEditingController();
  TextEditingController sellingPrice = TextEditingController();
  TextEditingController Tax = TextEditingController();
  TextEditingController purchaseRate = TextEditingController();
  TextEditingController hsn = TextEditingController();
  TextEditingController category = TextEditingController();

  TextEditingController description = TextEditingController();
  RxList<Map<String, dynamic>> productData = <Map<String, dynamic>>[].obs;
  RxString id = "".obs;

  void generateProductId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    id = 'PRD-$timestamp'.obs;
    update();
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
      'productId': id.value,
      'Product Name': productName.text,
      'Selling Price': sellingPrice.text,
      'Tax Rate': Tax.text,
      'Purchase Price': purchaseRate.text,
      'Unit': unitController.text,
      'hsn': hsn.text,
      'category': category.text,
      'description': description.text,
      'images': selectedImages.map((image) => image.path).join(','),
      'quantity': 1,
    };
    generateProductId();
    log("Product id ${id.value}");
    if (editingIndex != null &&
        editingIndex! >= 0 &&
        editingIndex! < productData.length) {
      newData['productId'] = productData[editingIndex!]['productId'];
      newData['quantity'] = productData[editingIndex!]['quantity'] ?? 1;
      productData[editingIndex!] = newData;
    } else {
      productData.add(newData);
    }

    editingIndex = null;
    clearFields();
  }

  void increaseQty(int index) {
    if (index >= 0 && index < productData.length) {
      final updatedProduct = Map<String, dynamic>.from(productData[index]);
      updatedProduct['quantity'] = (updatedProduct['quantity'] ?? 0) + 1;
      productData[index] = updatedProduct;
    }
  }

  void decreaseQty(int index) {
    if (index >= 0 && index < productData.length) {
      final updatedProduct = Map<String, dynamic>.from(productData[index]);
      int currentQty = updatedProduct['quantity'] ?? 0;
      if (currentQty > 0) {
        updatedProduct['quantity'] = currentQty - 1;
        productData[index] = updatedProduct;
      }
    }
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

  String generateAllProductShareMessage() {
    if (productData.isEmpty) return "📦 No products to share.";
    return "${productData.map((product) {
      return """
🆔 ID: ${id.value}  
📦 Name: ${product['Product Name'] ?? 'N/A'}
💰 Price: ₹${product['Selling Price'] ?? 'N/A'}
🔢 Quantity: ${product['quantity'] ?? 1}
""";
    }).join('\n-----------------------\n')}\n\n🧾 Shared via Invoice Generator 📲";
  }

  void toggleSelection(int index) {
    if (selectedIndexes.contains(index)) {
      selectedIndexes.remove(index);
    } else {
      selectedIndexes.add(index);
    }
  }

  void clearSelection() {
    selectedIndexes.clear();
    update();
  }

  void deleteSelectedProducts() {
    final indexes = selectedIndexes.toList()..sort((a, b) => b.compareTo(a));
    for (var index in indexes) {
      productData.removeAt(index);
    }
    clearSelection();
  }

  void sortProducts(SortOption option) {
    switch (option) {
      case SortOption.lowToHigh:
        productData.sort(
          (a, b) => double.tryParse(
            a['Selling Price'] ?? '0',
          )!.compareTo(double.tryParse(b['Selling Price'] ?? '0')!),
        );
        break;
      case SortOption.highToLow:
        productData.sort(
          (a, b) => double.tryParse(
            b['Selling Price'] ?? '0',
          )!.compareTo(double.tryParse(a['Selling Price'] ?? '0')!),
        );
        break;
      case SortOption.aToZ:
        productData.sort(
          (a, b) => (a['Product Name'] ?? '')
              .toString()
              .toLowerCase()
              .compareTo((b['Product Name'] ?? '').toString().toLowerCase()),
        );
        break;
      case SortOption.zToA:
        productData.sort(
          (a, b) => (b['Product Name'] ?? '')
              .toString()
              .toLowerCase()
              .compareTo((a['Product Name'] ?? '').toString().toLowerCase()),
        );
        break;
    }
    productData.refresh();
  }

  //getter for select all
  bool get isAllSelected =>
      selectedIndexes.length == productData.length && productData.isNotEmpty;

  void toggleSelectAll(bool selectAll) {
    if (selectAll) {
      selectedIndexes.value = Set<int>.from(
        List.generate(productData.length, (index) => index),
      );
    } else {
      selectedIndexes.clear();
    }
  }
}
