import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:invoice_generator/colors/colours.dart';
import '../../../routes/routes.dart';
import 'invoice_controller.dart';

class Invoice extends StatefulWidget {
  const Invoice({super.key});

  @override
  State<Invoice> createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  Widget buildAddAddressModal(
    BuildContext context,
    InvoiceController controller,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        height: 230.h,
        decoration: BoxDecoration(
          color: grey900,
          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SizedBox(height: 10.h),
                Text(
                  "Add Address",
                  style: lato(
                    color: white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
                Spacer(),
                TextField(
                  controller: controller.addressController,
                  decoration: InputDecoration(
                    labelText: "Address",
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
                  ),
                  style: TextStyle(color: white),
                ),
                Spacer(),
                SizedBox(height: 10.h),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: blue),
                  onPressed: () {
                    if (controller.addressController.text.trim().isNotEmpty) {
                      controller.dispatchAddress.value =
                          controller.addressController.text.trim();
                      Get.defaultDialog(
                        title: "Confirm Address",
                        titleStyle: lato(
                          color: white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                        ),
                        backgroundColor: grey900,
                        radius: 16,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.location_on, color: blue, size: 32.sp),
                            SizedBox(height: 12.h),
                            Text(
                              "Is this your address?",
                              style: lato(
                                color: white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: grey900.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.white12),
                              ),
                              child: Text(
                                controller.addressController.text.trim(),
                                textAlign: TextAlign.center,
                                style: lato(
                                  color: white,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Wrap(
                              spacing: 12,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    Share.share(
                                      controller.addressController.text.trim(),
                                    );
                                    Get.back();
                                    Get.back();
                                  },
                                  icon: Icon(Icons.share, color: white),
                                  label: Text(
                                    "Share",
                                    style: lato(
                                      color: white,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: blue,
                                  ),
                                ),
                                OutlinedButton(
                                  onPressed: () => Get.back(),
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(color: white24),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    "Ok",
                                    style: lato(
                                      color: white,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    } else {
                      Get.snackbar(
                        "Empty Address",
                        "Please enter an address before saving.",
                        backgroundColor: Colors.redAccent,
                        colorText: white,
                        snackPosition: SnackPosition.BOTTOM,
                        margin: EdgeInsets.all(12),
                      );
                    }
                  },
                  child: Text(
                    "Save",
                    style: lato(
                      color: white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    InvoiceController controller = Get.put(InvoiceController());
    dynamic data = Get.arguments;
    dynamic product = Get.arguments;
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: black,
        title: Text(
          "Create Invoice",
          style: lato(
            color: white,
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            controller.clearData();
            Get.toNamed(Routes.home);
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            controller.buildInvoiceInfo(context),
            SizedBox(height: 8.h),
            Text(
              "Customer",
              style: lato(
                color: white,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 8.h),
            (data == null)
                ? GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.form_customers);
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: grey900,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.all(10),

                    child: Text(
                      " +  Add Customers",
                      style: lato(
                        color: blue,
                        fontWeight: FontWeight.normal,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                )
                : GetBuilder<InvoiceController>(
                  builder: (controller) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.form_customers);
                      },
                      child: Card(
                        color: Colors.grey[900],
                        elevation: 4,
                        margin: EdgeInsets.symmetric(vertical: 8.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          title:
                              (data['name'] == null)
                                  ? Text(
                                    "Name",
                                    style: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 14.sp,
                                    ),
                                  )
                                  : Text(
                                    data['name'],
                                    style: TextStyle(
                                      color: white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                          subtitle:
                              (data['email'] == null)
                                  ? Text(
                                    "email",
                                    style: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 14.sp,
                                    ),
                                  )
                                  : Text(
                                    data['email'],
                                    style: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 14.sp,
                                    ),
                                  ),
                        ),
                      ),
                    );
                  },
                ),
            SizedBox(height: 10.h),
            Text(
              "Products",
              style: lato(
                color: white,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 8.h),
            (product == null)
                ? GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.product);
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: grey900,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Text(
                      " +  Add Product",
                      style: lato(
                        color: blue,
                        fontWeight: FontWeight.normal,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                )
                : GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.product);
                  },
                  child: Card(
                    color: grey900,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),

                      title:
                          (product["Product Name"] == null)
                              ? Text(
                                "No Name",
                                style: TextStyle(color: white, fontSize: 14.sp),
                              )
                              : Text(
                                product["Product Name"],
                                style: TextStyle(color: white),
                              ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          (product["quantity"] == null)
                              ? Text(
                                "1",
                                style: TextStyle(color: white, fontSize: 14.sp),
                              )
                              : Text(
                                "Quantity: ${product["quantity"]?.toString()}",
                                style: TextStyle(color: white),
                              ),
                        ],
                      ),
                    ),
                  ),
                ),
            SizedBox(height: 15.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Dispatch Address Selector
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                      ),
                      builder:
                          (context) =>
                              buildAddAddressModal(context, controller),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    height: 60.h,
                    decoration: BoxDecoration(
                      color: grey900,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Obx(
                      () => Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: white,
                            size: 22.sp,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              controller.dispatchAddress.value.isEmpty
                                  ? "Select Dispatch Address"
                                  : controller.dispatchAddress.value,
                              style: TextStyle(
                                color: white,
                                fontSize: 14.sp,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Obx(() {
                  return Container(
                    height: 60.h,
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    decoration: BoxDecoration(color: grey900),
                    child: Row(
                      children: [
                        Icon(Icons.payment, color: white, size: 22.sp),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Text(
                            "Payment Method",
                            style: TextStyle(color: white, fontSize: 14.sp),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            log("Clicked");
                            controller.dropDown(context: context);
                          },
                          child: Text(
                            controller.paymentMethod.value,
                            style: TextStyle(color: blue, fontSize: 14.sp),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    color: grey900,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(12),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.people_outline, color: white, size: 22.sp),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: TextField(
                          controller: controller.refrenceController,
                          decoration: InputDecoration(
                            labelText: "Reference",
                            labelStyle: TextStyle(color: white70),
                            filled: true,
                            fillColor: Colors.transparent,
                            isDense: true, // Reduces the height
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 10.h,
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white24),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white24),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: white),
                            ),
                          ),
                          style: TextStyle(color: white, fontSize: 14.sp),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Text(
              "Signature",
              style: lato(
                color: white,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  GetBuilder<InvoiceController>(
                    builder: (controller) {
                      return GestureDetector(
                        onTap: () async {
                          await controller.pickSignatureFromGallery();
                        },
                        child: Container(
                          height: 120.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: grey900,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.white24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child:
                              controller.signatureImage == null
                                  ? Center(
                                    child: Text(
                                      "Tap to import signature",
                                      style: TextStyle(
                                        color: Colors.white54,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  )
                                  : ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.file(
                                      controller.signatureImage!,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                  ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20.h),
                  // Notes
                  Text(
                    "Notes",
                    style: lato(
                      color: white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  GetBuilder<InvoiceController>(
                    builder: (controller) {
                      return TextField(
                        controller: controller.notesController,
                        maxLines: 4,
                        decoration: inputDecoration(
                          "Additional notes (optional)",
                        ),
                        style: TextStyle(color: white),
                      );
                    },
                  ),
                  SizedBox(height: 20.h),
                  // Terms
                  Text(
                    "Terms",
                    style: lato(
                      color: white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  TextField(
                    controller: controller.termsController,
                    maxLines: 4,
                    decoration: inputDecoration("Terms & Conditions"),
                    style: TextStyle(color: white),
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Total Amount", style: TextStyle(color: Colors.white)),
              Row(
                children: [
                  Text("100.00", style: TextStyle(color: white)),
                  IconButton(
                    icon: Icon(Icons.print, color: white),
                    onPressed: () {
                      generateInvoicePDF(
                        controller: controller,
                        data: data,
                        discount: "23",
                        name: "Taksh",
                        qty: "3",
                        total: "4674",
                        unit: "2",
                        signature: controller.signatureImage!,
                      );
                      controller.saveInvoiceData();
                      log("Data ${controller.invoiceList}");
                      log("Data ${controller.invoiceList.length}");
                      log(data['name'].toString());
                      log(data['email'].toString());
                      log(data['address'].toString());
                      log(data['country'].toString());
                      log(data['gst'].toString());
                      log(data['address1'].toString());
                      log(data['address2'].toString());
                      log(data['pincode'].toString());
                      log(data['city'].toString());
                      log(data['state'].toString());
                      log(data['country'].toString());
                      log(data['discount'].toString());
                      log(data['creditLimit'].toString());
                      log(data['priceList'].toString());
                      log(data['pan'].toString());
                      log(data['ccemail'].toString());
                      log(data['shippingadd1'].toString());
                      log(data['shippingadd2'].toString());
                      log(data['shippingcity'].toString());
                      log(data['shippingstate'].toString());
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.white70),
      filled: true,
      fillColor: grey900,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white24),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  Future<void> generateInvoicePDF({
    required InvoiceController controller,
    required Map<String, dynamic> data,
    required String name,
    required String qty,
    required String unit,
    required String discount,
    required String total,
    required File signature,
  }) async {
    final pdf = pw.Document();
    final imageBytes = await File(signature.path).readAsBytes();
    final signatureImage = pw.MemoryImage(imageBytes);
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(32),
        build:
            (context) => [
              pw.Container(
                padding: pw.EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                decoration: pw.BoxDecoration(
                  border: pw.Border(
                    bottom: pw.BorderSide(color: PdfColors.grey300, width: 1),
                  ),
                ),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text(
                          "TAX INVOICE",
                          style: pw.TextStyle(
                            fontSize: 28,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.blue800,
                          ),
                        ),
                        pw.SizedBox(width: 5),
                        pw.Row(
                          children: [
                            pw.Text(
                              'INV-0001',
                              style: pw.TextStyle(
                                fontSize: 12,
                                color: PdfColors.grey600,
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(width: 150),
                        pw.SizedBox(height: 10),
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              "${data['company']}",
                              style: pw.TextStyle(
                                fontSize: 12,
                                color: PdfColors.black,
                              ),
                            ),
                            pw.Text(
                              "${data['email']}",
                              style: pw.TextStyle(
                                fontSize: 12,
                                color: PdfColors.black,
                              ),
                            ),
                            pw.Text(
                              "${data['gst']}",
                              style: pw.TextStyle(
                                fontSize: 12,
                                color: PdfColors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 30),
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    child: pw.Container(
                      padding: pw.EdgeInsets.all(20),
                      decoration: pw.BoxDecoration(
                        color: PdfColors.grey100,
                        borderRadius: pw.BorderRadius.circular(5),
                      ),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            "BILL TO",
                            style: pw.TextStyle(
                              fontSize: 10,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.blueGrey800,
                            ),
                          ),
                          pw.SizedBox(height: 10),
                          pw.Text(
                            "Name : ${data['name'].toString()}",
                            style: pw.TextStyle(
                              fontSize: 10,
                              color: PdfColors.blueGrey800,
                            ),
                          ),
                          pw.Text(
                            "Address : ${data['address1'].toString()}",
                            style: pw.TextStyle(
                              fontSize: 10,
                              color: PdfColors.blueGrey800,
                            ),
                          ),
                          pw.SizedBox(height: 5),
                          pw.Text(
                            "Contact: ${data['number']}",
                            style: pw.TextStyle(
                              fontSize: 10,
                              color: PdfColors.blueGrey800,
                            ),
                          ),
                          pw.Text(
                            "GSTIN: ${data['gst']}",
                            style: pw.TextStyle(
                              fontSize: 10,
                              color: PdfColors.blueGrey800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  pw.SizedBox(width: 20),
                  pw.Expanded(
                    child: pw.Container(
                      padding: pw.EdgeInsets.all(20),
                      decoration: pw.BoxDecoration(
                        color: PdfColors.grey100,
                        borderRadius: pw.BorderRadius.circular(5),
                      ),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            "INVOICE DETAILS",
                            style: pw.TextStyle(
                              fontSize: 10,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.blueGrey800,
                            ),
                          ),
                          pw.SizedBox(height: 10),
                          pw.Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Text(
                                "Invoice Date:",
                                style: pw.TextStyle(
                                  fontSize: 10,
                                  color: PdfColors.blueGrey800,
                                ),
                              ),
                              pw.Text(
                                DateTime.now().toString().split(" ").first,
                                style: pw.TextStyle(
                                  fontSize: 10,
                                  color: PdfColors.blueGrey800,
                                ),
                              ),
                            ],
                          ),
                          pw.SizedBox(height: 5),
                          pw.Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Text(
                                "Due Date:",
                                style: pw.TextStyle(
                                  fontSize: 10,
                                  color: PdfColors.blueGrey800,
                                ),
                              ),
                              pw.Text(
                                (controller.dueDate == null)
                                    ? DateTime.now().toString().split(" ").first
                                    : controller.dueDate
                                        .toString()
                                        .split(" ")
                                        .first,
                                style: pw.TextStyle(
                                  fontSize: 10,
                                  color: PdfColors.blueGrey800,
                                ),
                              ),
                            ],
                          ),
                          pw.SizedBox(height: 5),
                          pw.Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Text(
                                "Place of Supply:",
                                style: pw.TextStyle(
                                  fontSize: 10,
                                  color: PdfColors.blueGrey800,
                                ),
                              ),
                              pw.Text(
                                data['state'],
                                style: pw.TextStyle(
                                  fontSize: 10,
                                  color: PdfColors.blueGrey800,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 30),
              pw.Container(
                decoration: pw.BoxDecoration(
                  borderRadius: pw.BorderRadius.circular(5),
                  border: pw.Border.all(color: PdfColors.grey300),
                ),
                child: pw.Table(
                  border: pw.TableBorder.symmetric(
                    inside: pw.BorderSide(color: PdfColors.grey300),
                  ),
                  children: [
                    pw.TableRow(
                      decoration: pw.BoxDecoration(color: PdfColors.blue800),
                      children:
                          [
                            "#",
                            "ITEM NAME",
                            "QTY",
                            "PRICE/UNIT",
                            "DISCOUNT",
                            "AMOUNT",
                          ].map((header) {
                            return pw.Padding(
                              padding: pw.EdgeInsets.all(10),
                              child: pw.Text(
                                header,
                                style: pw.TextStyle(
                                  color: PdfColors.white,
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 10,
                                ),
                                textAlign: pw.TextAlign.center,
                              ),
                            );
                          }).toList(),
                    ),
                    ...[
                      ["1", name, qty, unit, discount, total],
                    ].map((row) {
                      return pw.TableRow(
                        children:
                            row.map((data) {
                              return pw.Padding(
                                padding: pw.EdgeInsets.all(10),
                                child: pw.Text(
                                  data,
                                  style: pw.TextStyle(
                                    fontSize: 10,
                                    color: PdfColors.blueGrey800,
                                  ),
                                  textAlign: pw.TextAlign.center,
                                ),
                              );
                            }).toList(),
                      );
                    }),
                  ],
                ),
              ),
              pw.SizedBox(height: 20),

              // Total Section
              pw.Container(
                width: double.infinity,
                padding: pw.EdgeInsets.all(20),
                decoration: pw.BoxDecoration(
                  color: PdfColors.grey100,
                  borderRadius: pw.BorderRadius.circular(5),
                ),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          "Payment Details",
                          style: pw.TextStyle(
                            fontSize: 10,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.blueGrey800,
                          ),
                        ),
                        pw.SizedBox(height: 10),

                        pw.Text(
                          "Bank: ${controller.bankNameController.text}",
                          style: pw.TextStyle(
                            fontSize: 10,
                            color: PdfColors.blueGrey800,
                          ),
                        ),
                        pw.Text(
                          "Account: ${controller.accountNumberController.text}",
                          style: pw.TextStyle(
                            fontSize: 10,
                            color: PdfColors.blueGrey800,
                          ),
                        ),
                      ],
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Row(
                          children: [
                            pw.Text(
                              "Subtotal:",
                              style: pw.TextStyle(
                                fontSize: 10,
                                color: PdfColors.blueGrey800,
                              ),
                            ),
                            pw.SizedBox(width: 50),
                            pw.Text(
                              " 80,000.00",
                              style: pw.TextStyle(
                                fontSize: 10,
                                color: PdfColors.blueGrey800,
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(height: 5),
                        pw.Row(
                          children: [
                            pw.Text(
                              "GST (0%):",
                              style: pw.TextStyle(
                                fontSize: 10,
                                color: PdfColors.blueGrey800,
                              ),
                            ),
                            pw.SizedBox(width: 50),
                            pw.Text(
                              " 0.00",
                              style: pw.TextStyle(
                                fontSize: 10,
                                color: PdfColors.blueGrey800,
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(height: 5),
                        pw.Container(
                          padding: pw.EdgeInsets.symmetric(vertical: 10),
                          decoration: pw.BoxDecoration(
                            border: pw.Border(
                              top: pw.BorderSide(color: PdfColors.grey300),
                            ),
                          ),
                          child: pw.Row(
                            children: [
                              pw.Text(
                                "Total:",
                                style: pw.TextStyle(
                                  fontSize: 10,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColors.blueGrey800,
                                ),
                              ),
                              pw.SizedBox(width: 50),
                              pw.Text(
                                " 1,20,000.00",
                                style: pw.TextStyle(
                                  fontSize: 14,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColors.blue800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 30),
              pw.Container(
                padding: pw.EdgeInsets.symmetric(vertical: 20),
                decoration: pw.BoxDecoration(
                  border: pw.Border(
                    top: pw.BorderSide(color: PdfColors.grey300),
                  ),
                ),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          "Terms & Conditions",
                          style: pw.TextStyle(
                            fontSize: 10,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.blueGrey800,
                          ),
                        ),
                        pw.SizedBox(height: 5),
                        pw.Text(
                          controller.termsController.text,
                          style: pw.TextStyle(
                            fontSize: 10,
                            color: PdfColors.blueGrey800,
                          ),
                        ),
                      ],
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                      children: [
                        pw.Image(signatureImage, width: 100, height: 50),
                      ],
                    ),
                  ],
                ),
              ),
            ],
      ),
    );
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/invoice.pdf");
    log("Path ${file.path}");
    await file.writeAsBytes(await pdf.save());
    await Printing.layoutPdf(onLayout: (format) => pdf.save());
    await Share.shareXFiles([XFile(file.path)]);
  }
}
