import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
              icon: Icon(Icons.add, color: white),
              onPressed: () {
                Get.toNamed(Routes.product_add);
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
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),

                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child:
                            imagePath != null && File(imagePath).existsSync()
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
                      title: Text(
                        product["Product Name"]?.toString() ?? "No Title",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product["Selling Price"]?.toString() ?? "No Price",
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.white70),
                            onPressed: () {
                              controller.editProduct(index);
                              Get.toNamed(Routes.product_add);
                            },
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
      ),
    );
  }
}
