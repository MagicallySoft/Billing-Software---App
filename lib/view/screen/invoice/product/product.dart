import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:invoice_generator/view/screen/invoice/product/product_controller.dart';
import '../../../../colors/colours.dart';
import '../../../../routes/routes.dart';

class Product extends StatefulWidget {
  const Product({super.key});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: black,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.toNamed(Routes.invoice);
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded, color: white),
          ),
          title: Text(
            "Product List",
            style: lato(
              color: white,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.black,
          actions: [
            IconButton(
              icon: const Icon(Icons.share, color: Colors.white),
              onPressed: () {
                final message = controller.generateAllProductShareMessage();
                Share.share(message);
              },
            ),
          ],
        ),
        body: Obx(() {
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: controller.productData.length,
            itemBuilder: (context, index) {
              final product = controller.productData[index];
              final imagePath = product["images"];
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
                  controller.productData.removeAt(index);
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
                    Get.toNamed(Routes.invoice, arguments: product);
                  },
                  child: Card(
                    color: grey900,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Product Image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child:
                                imagePath != null &&
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
                          const SizedBox(width: 12),

                          /// Details + Actions
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      product["Product Name"]?.toString() ??
                                          "No Title",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "₹ ${product["Selling Price"]?.toString() ?? "No Price"}",
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          onPressed:
                                              () =>
                                                  controller.decreaseQty(index),
                                          icon: const Icon(
                                            Icons.remove_circle_outline,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          controller
                                                  .productData[index]['quantity']
                                                  ?.toString() ??
                                              '1',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed:
                                              () =>
                                                  controller.increaseQty(index),
                                          icon: const Icon(
                                            Icons.add_circle_outline,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton.icon(
                                          onPressed: () {
                                            log("edit called");
                                            Get.toNamed(Routes.product_add);
                                            controller.editProduct(index);
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            size: 16,
                                            color: blue,
                                          ),
                                          label: Text(
                                            "Edit",
                                            style: lato(
                                              color: blue,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
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
              Get.toNamed(Routes.product_add);
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
}
