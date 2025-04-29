import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:invoice_generator/view/screen/invoice/product/product_controller.dart';
import 'package:searchfield/searchfield.dart';
import '../../../../colors/colours.dart';
import '../../../../routes/routes.dart';

class ProductAdd extends StatefulWidget {
  const ProductAdd.product({super.key});

  @override
  State<ProductAdd> createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  @override
  Widget build(BuildContext context) {
    final product = Get.put(ProductController());

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: black,
        appBar: AppBar(
          backgroundColor: black,
          leading: IconButton(
            onPressed: () {
              Get.back();
              product.clearFields();
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded, color: white),
          ),
          title: Text(
            "Add product",
            style: lato(
              color: white,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Product Details",
                    style: lato(
                      color: white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                    ),
                  ),
                  SizedBox(height: 14.h),

                  /// Type Selection
                  Container(
                    decoration: BoxDecoration(
                      color: grey900,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Radio<String>(
                                value: "Product",
                                groupValue: product.selectedType.value,
                                onChanged:
                                    (val) => product.selectedType.value = val!,
                                activeColor: Colors.indigo,
                              ),
                              Text(
                                "Product",
                                style: lato(
                                  color: white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Radio<String>(
                                value: "Service",
                                groupValue: product.selectedType.value,
                                onChanged:
                                    (val) => product.selectedType.value = val!,
                                activeColor: Colors.indigo,
                              ),
                              Text(
                                "Service",
                                style: lato(
                                  color: white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 14.h),

                  /// Name
                  TextField(
                    controller: product.productName,
                    decoration: inputStyle(
                      product.selectedType.value == 'Product'
                          ? "Product Name"
                          : "Service Name",
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),

                  /// Conditional Fields
                  if (product.selectedType.value == "Product") ...[
                    SizedBox(height: 12.h),
                    TextField(
                      controller: product.sellingPrice,
                      decoration: inputStyle("Selling Price"),
                      style: const TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Icon(Icons.info_outline, size: 16, color: Colors.grey),
                        SizedBox(width: 6),
                        Text(
                          "Price includes tax",
                          style: lato(
                            color: Colors.white60,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    TextField(
                      controller: product.Tax,
                      decoration: inputStyleWithSuffix("Tax Rate %", context),
                      style: const TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 8.h),
                    TextField(
                      controller: product.purchaseRate,
                      decoration: inputStyle("Purchase Price"),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                  SizedBox(height: 20.h),

                  /// Unit Selection
                  Text(
                    "Unit",
                    style: lato(
                      color: white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: grey900,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: SearchField<String>(
                      controller: product.unitController,
                      suggestions:
                          product.units.map((unit) {
                            return SearchFieldListItem<String>(
                              unit,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  unit,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                      suggestionState: Suggestion.expand,
                      searchInputDecoration: SearchInputDecoration(
                        hintText: "Search unit...",
                        hintStyle: TextStyle(
                          color: Colors.white60,
                          fontSize: 12.sp,
                        ),
                      ),
                      suggestionStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                      ),
                      suggestionItemDecoration: BoxDecoration(color: grey900),
                      marginColor: grey900,
                      onSuggestionTap:
                          (item) =>
                              product.unitController.text = item.searchKey,
                      maxSuggestionsInViewPort: 5,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "Product Images",
                    style: lato(
                      color: white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                  Obx(() {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children:
                              product.selectedImages.map((file) {
                                return Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.file(
                                        file,
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: GestureDetector(
                                        onTap:
                                            () => product.selectedImages.remove(
                                              file,
                                            ),
                                        child: CircleAvatar(
                                          radius: 10,
                                          backgroundColor: Colors.red,
                                          child: Icon(
                                            Icons.close,
                                            size: 14,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                        ),
                        SizedBox(height: 12),
                        ElevatedButton.icon(
                          onPressed: () => product.pickImages(),
                          icon: Icon(Icons.add_photo_alternate),
                          label: Text("Add Images"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: grey900,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    );
                  }),

                  /// HSN + Description
                  if (product.selectedType.value == "Product") ...[
                    SizedBox(height: 12.h),
                    TextField(
                      controller: product.hsn,
                      decoration: inputStyle("HSN Number"),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                  SizedBox(height: 12.h),
                  TextField(
                    controller: product.description,
                    maxLines: 3,
                    decoration: inputStyle("Product Description"),
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 8,
          ),
          child: ElevatedButton(
            onPressed: () {
              product.addProduct();
              Get.toNamed(Routes.product, arguments: product.productData);
              log("data ${product.productData}");
              product.clearFields();
              product.selectedImages.clear();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              "Add Product",
              style: lato(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration inputStyle(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: white),
      filled: true,
      fillColor: Colors.transparent,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white24),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: white),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  InputDecoration inputStyleWithSuffix(String label, BuildContext context) {
    return inputStyle(label).copyWith(
      suffixIcon: IconButton(
        icon: Icon(Icons.arrow_drop_down, color: white),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            builder:
                (_) => Container(
                  height: 180.h,
                  decoration: BoxDecoration(
                    color: grey900,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                  ),
                  child: Column(
                    children: [
                      Spacer(),
                      Text(
                        "Add GSTIN",
                        style: lato(
                          color: white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: TextField(
                          decoration: inputStyle("Add GSTIN"),
                          style: TextStyle(color: white),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: blue),
                        onPressed: () => Get.back(),
                        child: Text(
                          "Save",
                          style: lato(
                            color: white,
                            fontWeight: FontWeight.normal,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                    ],
                  ),
                ),
          );
        },
      ),
    );
  }
}
