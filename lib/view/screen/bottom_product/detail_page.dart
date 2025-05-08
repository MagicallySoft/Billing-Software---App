import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../../colors/colours.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final data = Get.arguments;
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: white),
        ),
        backgroundColor: black,
        title: Text("Product Details", style: TextStyle(color: white)),
      ),
      body: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: grey900,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['Product Name'] ?? 'Sample Product',
                    style: lato(
                      color: white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  buildDetailTile(
                    'Selling Price',
                    '${data['Selling Price'] ?? '0.00'}',
                  ),
                  buildDetailTile('Tax Rate', '${data['Tax Rate'] ?? '0.0%'}'),
                  buildDetailTile(
                    'Purchase Price',
                    '${data['Purchase Price'] ?? '0.00'}',
                  ),
                  buildDetailTile(
                    'Quantity',
                    '${data['quantity'] ?? '0.00'}',
                    valueColor: Colors.green,
                  ),
                  buildDetailTile('Unit', data['Unit'] ?? 'OTH'),
                  buildDetailTile('Category', data['category'] ?? 'ADD'),
                  buildDetailTile('HSN/SAC Code', data['hsn'] ?? '00000000'),
                  buildDetailTile('Barcode', data['Barcode'] ?? '00000000'),
                  SizedBox(height: 12.h),
                  Text(
                    'Product Description',
                    style: lato(
                      color: white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    data['Description'] ??
                        'Create your first invoice with ease using our sample product!',
                    style: lato(
                      color: white.withOpacity(0.8),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          Share.share(
            ""
            "Product Name: ${data['Product Name'] ?? 'Sample Product'}\n"
            "Selling Price: ${data['Selling Price'] ?? '0.00'}\n"
            "Tax Rate: ${data['Tax Rate'] ?? '0.0%'}\n"
            "Purchase Price: ${data['Purchase Price'] ?? '0.00'}\n"
            "Unit: ${data['Unit'] ?? 'OTH'}\n"
            "Category: ${data['category'] ?? 'ADD'}\n",
          );
        },
        child: Icon(Icons.share, color: Colors.white),
      ),
    );
  }

  Widget buildDetailTile(String title, String value, {Color? valueColor}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: lato(
              color: white,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: lato(
              color: valueColor ?? white,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
