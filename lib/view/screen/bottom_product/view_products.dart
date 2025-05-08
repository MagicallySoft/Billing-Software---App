import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../../../colors/colours.dart';
import '../../../routes/routes.dart';
import '../invoice/product/product_controller.dart';

class productView extends StatelessWidget {
  const productView({super.key});

  @override
  Widget build(BuildContext context) {
    ProductController controller = Get.put(ProductController());
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
        ),
        backgroundColor: Colors.black,
        title: Text(
          "Product",
          style: lato(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          PopupMenuButton<SortOption>(
            color: Colors.black,
            icon: Icon(Icons.sort, color: Colors.white),
            onSelected: (option) {
              controller.sortProducts(option);
            },
            itemBuilder:
                (context) => [
                  PopupMenuItem(
                    value: SortOption.lowToHigh,
                    child: Text(
                      'Price: Low to High',
                      style: lato(
                        color: white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    value: SortOption.highToLow,
                    child: Text(
                      'Price: High to Low',
                      style: lato(
                        color: white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    value: SortOption.aToZ,
                    child: Text(
                      'Name: A to Z',
                      style: lato(
                        color: white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    value: SortOption.zToA,
                    child: Text(
                      'Name: Z to A',
                      style: lato(
                        color: white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ],
          ),
        ],
      ),
      body: Obx(() {
        return Column(
          children: [
            Visibility(
              visible: controller.selectedIndexes.isNotEmpty,
              child: CheckboxListTile(
                title: const Text(
                  "Select All",
                  style: TextStyle(color: Colors.white),
                ),
                value: controller.isAllSelected,
                onChanged: (bool? value) {
                  if (value != null) {
                    controller.toggleSelectAll(value);
                  }
                },
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: Colors.indigo,
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: controller.productData.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> product = controller.productData[index];
                  String imagePath = product["images"];
                  return Dismissible(
                    key: Key(product.hashCode.toString()),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      padding: const EdgeInsets.only(right: 20),
                      alignment: Alignment.centerRight,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (direction) {
                      controller.deleteProduct(index);
                      Get.snackbar(
                        'Deleted',
                        'Product removed',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.grey[900],
                        colorText: Colors.white,
                      );
                    },
                    child: GestureDetector(
                      onTap: () {
                        if (controller.selectedIndexes.isNotEmpty) {
                          controller.toggleSelection(index);
                          HapticFeedback.vibrate();
                        }
                      },
                      onDoubleTap: () {
                        Get.toNamed(Routes.product_detail, arguments: product);
                      },
                      onLongPress: () {
                        controller.toggleSelection(index);
                        HapticFeedback.vibrate();
                      },
                      child: Card(
                        color:
                            controller.selectedIndexes.contains(index)
                                ? Colors.indigo.withOpacity(0.5)
                                : grey900,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        margin: EdgeInsets.only(bottom: 12),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child:
                                    File(imagePath).existsSync()
                                        ? Image.file(
                                          File(imagePath),
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover,
                                        )
                                        : Container(
                                          width: 50,
                                          height: 50,
                                          color: Colors.grey,
                                          child: const Icon(
                                            Icons.image_not_supported,
                                            color: Colors.white,
                                          ),
                                        ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product["Product Name"]?.toString() ??
                                          "No Title",
                                      style: lato(
                                        color: Colors.white,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      "₹ ${product["Selling Price"]?.toString() ?? "No Price"}",
                                      style: lato(
                                        color: Colors.white70,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),
      bottomNavigationBar: Obx(() {
        if (controller.selectedIndexes.isNotEmpty) {
          return BottomAppBar(
            color: Colors.grey[900],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${controller.selectedIndexes.length} selected',
                    style: lato(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          controller.deleteSelectedProducts();
                          Get.snackbar(
                            'Deleted',
                            'Selected products removed',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.grey[900],
                            colorText: Colors.white,
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.share, color: Colors.blue),
                        onPressed: () {
                          String message = controller.selectedIndexes
                              .map((index) {
                                return ''' 
                                       📦 NAME :${controller.productData[index]['Product Name'] ?? 'N/A'}
                                       💰 Price = ₹${controller.productData[index]['Selling Price'] ?? 'N/A'}
                                       🛍️ Unit = ${controller.productData[index]['Unit'] ?? 'N/A'}
                                       🔢 Qty: ${controller.productData[index]['quantity'] ?? 1}
                                       ''';
                              })
                              .join('\n-------------------\n');
                          Share.share(message);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        } else {
          return Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom + 8,
            ),
            child: ElevatedButton(
              onPressed: () {
                Get.toNamed(Routes.bills);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                padding: const EdgeInsets.symmetric(vertical: 16),
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
          );
        }
      }),
    );
  }
}
