import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:share_plus/share_plus.dart';
import '../../../colors/colours.dart';
import '../../../routes/routes.dart';
import 'Quotation_controller.dart';

class Quatation extends StatelessWidget {
  const Quatation({super.key});

  @override
  Widget build(BuildContext context) {
    var controllerQuotation = Get.put(QuotationController());
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: black,
        title: Text("Quotation", style: TextStyle(color: white)),
        leading: IconButton(
          onPressed: () {
            controllerQuotation.clearData();
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            controllerQuotation.buildQuotationInfo(context),
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
            GestureDetector(
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
            SizedBox(height: 10.h),
            GestureDetector(
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
            ),
            SizedBox(height: 15.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                          (context) => buildAddAddressModal(
                            context,
                            controllerQuotation,
                          ),
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
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: white,
                          size: 22.sp,
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Obx(
                            () => Text(
                              controllerQuotation.address.value.isEmpty
                                  ? "Select Dispatch Address"
                                  : controllerQuotation.address.value,
                              style: TextStyle(
                                color: white,
                                fontSize: 14.sp,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
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
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder:
                                (context) => buildPaymentMethodSheet(
                                  context,
                                  controllerQuotation,
                                ),
                          );
                        },
                        child: Obx(
                          () => Text(
                            controllerQuotation.paymentMethod.value,
                            style: TextStyle(color: blue, fontSize: 14.sp),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 60.h,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(color: grey900),
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder:
                            (context) => buildInputBottomSheet(
                              context,
                              controllerQuotation,
                              "Add Notes",
                              controllerQuotation.notesController,
                              "Notes",
                            ),
                      );
                    },
                    child: Row(
                      children: [
                        Icon(Icons.notes, color: white, size: 22.sp),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Obx(
                            () => Text(
                              controllerQuotation.notesText.isEmpty
                                  ? "Add Notes"
                                  : controllerQuotation.notesText.value,
                              style: TextStyle(color: white, fontSize: 14.sp),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 60.h,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(color: grey900),
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder:
                            (context) => buildInputBottomSheet(
                              context,
                              controllerQuotation,
                              "Terms & Conditions",
                              controllerQuotation.termsController,
                              "Terms & Conditions",
                            ),
                      );
                    },
                    child: Row(
                      children: [
                        Icon(Icons.description, color: white, size: 22.sp),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Obx(
                            () => Text(
                              controllerQuotation.termsText.isEmpty
                                  ? "Terms & Conditions"
                                  : controllerQuotation.termsText.value,
                              style: TextStyle(color: white, fontSize: 14.sp),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 60.h,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(color: grey900),
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder:
                            (context) => buildInputBottomSheet(
                              context,
                              controllerQuotation,
                              "Delivery Charges",
                              controllerQuotation.dilivryController,
                              "Enter delivery charges",
                              keyboardType: TextInputType.number,
                            ),
                      );
                    },
                    child: Row(
                      children: [
                        Icon(Icons.currency_rupee, color: white, size: 22.sp),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Obx(
                            () => Text(
                              controllerQuotation.deliveryCharges.isEmpty
                                  ? "Delivery Charges"
                                  : "₹${controllerQuotation.deliveryCharges.value}",
                              style: TextStyle(color: white, fontSize: 14.sp),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 60.h,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(color: grey900),
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder:
                            (context) => buildInputBottomSheet(
                              context,
                              controllerQuotation,
                              "Packaging Charges",
                              controllerQuotation.pakageController,
                              "Enter packaging charges",
                              keyboardType: TextInputType.number,
                            ),
                      );
                    },
                    child: Row(
                      children: [
                        Icon(Icons.currency_rupee, color: white, size: 22.sp),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Obx(
                            () => Text(
                              controllerQuotation.packagingCharges.isEmpty
                                  ? "Packaging Charges"
                                  : "₹${controllerQuotation.packagingCharges.value}",
                              style: TextStyle(color: white, fontSize: 14.sp),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 60.h,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(color: grey900),
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder:
                            (context) => buildInputBottomSheet(
                              context,
                              controllerQuotation,
                              "Discount",
                              controllerQuotation.discountController,
                              "Enter discount amount",
                              keyboardType: TextInputType.number,
                            ),
                      );
                    },
                    child: Row(
                      children: [
                        Icon(Icons.discount, color: white, size: 22.sp),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Obx(
                            () => Text(
                              controllerQuotation.discountAmount.isEmpty
                                  ? "Discount"
                                  : "₹${controllerQuotation.discountAmount.value}",
                              style: TextStyle(color: white, fontSize: 14.sp),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 60.h,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(color: grey900),
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder:
                            (context) => Container(
                              height: 300.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: grey900,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                              ),
                              child: Obx(() {
                                return Column(
                                  children: [
                                    SizedBox(height: 16.h),
                                    Text(
                                      (controllerQuotation.signature == null)
                                          ? "Select Signature"
                                          : "Signature Selected",
                                      style: lato(
                                        color: white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                    SizedBox(height: 20.h),
                                    Container(
                                      width: 200.w,
                                      height: 130.h,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: white24),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child:
                                          controllerQuotation.signature.value !=
                                                  null
                                              ? Image.file(
                                                File(
                                                  controllerQuotation
                                                      .signature
                                                      .value!
                                                      .path,
                                                ),
                                                fit: BoxFit.cover,
                                              )
                                              : Center(
                                                child: Icon(
                                                  Icons.image_outlined,
                                                  color: white,
                                                  size: 32.sp,
                                                ),
                                              ),
                                    ),
                                    SizedBox(height: 20.h),
                                    ElevatedButton.icon(
                                      onPressed: () async {
                                        await controllerQuotation
                                            .pickSignature();
                                        if (controllerQuotation
                                                .signature
                                                .value !=
                                            null) {
                                          Get.back();
                                        }
                                      },
                                      icon: Icon(
                                        Icons.photo_library,
                                        color: white,
                                      ),
                                      label: Text(
                                        "Choose from Gallery",
                                        style: lato(
                                          color: white,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: blue,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            ),
                      );
                    },
                    child: Row(
                      children: [
                        Icon(Icons.edit, color: white, size: 22.sp),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Obx(
                            () => Text(
                              controllerQuotation.signature.value != null
                                  ? "Signature Selected ✅"
                                  : "Select Signature",
                              style: TextStyle(color: white, fontSize: 14.sp),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
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
                          decoration: InputDecoration(
                            labelText: "Reference",
                            labelStyle: TextStyle(color: white70),
                            filled: true,
                            fillColor: Colors.transparent,
                            contentPadding: EdgeInsets.symmetric(vertical: 8),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white24),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: white),
                            ),
                          ),
                          style: TextStyle(color: white),
                          onSubmitted: (value) {},
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
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Create Quotation",
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.print, color: white),
                    onPressed: () async {
                      controllerQuotation.QuatationDataAdd();
                      controllerQuotation.QuatationPdf();
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

  Widget buildAddAddressModal(
    BuildContext context,
    QuotationController controller,
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
                                  onPressed: () {
                                    controller.address.value =
                                        controller.addressController.text
                                            .trim();
                                    Get.back();
                                    Get.back();
                                  },
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

  Widget buildInputBottomSheet(
    BuildContext context,
    QuotationController controller,
    String title,
    TextEditingController textController,
    String hint, {
    TextInputType keyboardType = TextInputType.text,
  }) {
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
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(height: 10.h),
              Text(
                title,
                style: lato(
                  color: white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
              Spacer(),
              TextField(
                controller: textController,
                keyboardType: keyboardType,
                decoration: InputDecoration(
                  labelText: hint,
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
                  if (textController.text.trim().isNotEmpty) {
                    if (textController == controller.notesController) {
                      controller.notesText.value = textController.text.trim();
                    } else if (textController == controller.termsController) {
                      controller.termsText.value = textController.text.trim();
                    } else if (textController == controller.dilivryController) {
                      controller.deliveryCharges.value =
                          textController.text.trim();
                    } else if (textController == controller.pakageController) {
                      controller.packagingCharges.value =
                          textController.text.trim();
                    } else if (textController ==
                        controller.discountController) {
                      controller.discountAmount.value =
                          textController.text.trim();
                    }
                    Get.back();
                  } else {
                    Get.snackbar(
                      "Empty Field",
                      "Please enter a value before saving.",
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
    );
  }

  Widget buildPaymentMethodSheet(
    BuildContext context,
    QuotationController controller,
  ) {
    return Container(
      height: controller.paymentMethod.value == 'Bank' ? 400.h : 200.h,
      decoration: BoxDecoration(
        color: grey900,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Payment Method",
              style: lato(
                color: white,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    controller.paymentMethod.value = 'Cash';
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        controller.paymentMethod.value == 'Cash'
                            ? blue
                            : grey900,
                    side: BorderSide(color: white24),
                  ),
                  child: Text("Cash", style: TextStyle(color: white)),
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.paymentMethod.value = 'Bank';
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        controller.paymentMethod.value == 'Bank'
                            ? blue
                            : grey900,
                    side: BorderSide(color: white24),
                  ),
                  child: Text("Bank", style: TextStyle(color: white)),
                ),
              ],
            ),
            Obx(() {
              if (controller.paymentMethod.value == 'Bank') {
                return Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 20.h),
                        TextField(
                          controller: controller.bankName,
                          decoration: InputDecoration(
                            labelText: "Bank Name",
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
                        SizedBox(height: 16.h),
                        TextField(
                          controller: controller.acc,
                          decoration: InputDecoration(
                            labelText: "Account Number",
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
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 16.h),
                        TextField(
                          controller: controller.ifsc,
                          decoration: InputDecoration(
                            labelText: "IFSC Code",
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
                        SizedBox(height: 20.h),
                        ElevatedButton(
                          onPressed: () {
                            if (controller.bankName.text.isNotEmpty &&
                                controller.acc.text.isNotEmpty &&
                                controller.ifsc.text.isNotEmpty) {
                              Get.back();
                            } else {
                              Get.snackbar(
                                "Incomplete Details",
                                "Please fill all bank details",
                                backgroundColor: Colors.redAccent,
                                colorText: white,
                                snackPosition: SnackPosition.BOTTOM,
                                margin: EdgeInsets.all(12),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: blue,
                          ),
                          child: Text(
                            "Save Bank Details",
                            style: TextStyle(color: white),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return SizedBox();
            }),
          ],
        ),
      ),
    );
  }
}
