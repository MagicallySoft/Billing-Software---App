import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:invoice_generator/view/screen/bottom/Company_detail/company_controller.dart';
import '../../../../colors/colours.dart';

class CompanyDetail extends StatelessWidget {
  const CompanyDetail({super.key});

  @override
  Widget build(BuildContext context) {
    Company controller = Get.put(Company());
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        title: Text("Company Details", style: TextStyle(color: white)),
        backgroundColor: black,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: grey900,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Company Details",
                      style: lato(
                        color: white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: 14.h),
                    Text(
                      "Company Name",
                      style: lato(
                        color: white.withOpacity(0.8),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    TextFormField(
                      controller: controller.companynameController,
                      style: lato(
                        color: white,
                        fontWeight: FontWeight.w500,
                        fontSize: 13.sp,
                      ),
                      decoration: InputDecoration(
                        labelText: "Enter company name",
                        labelStyle: lato(
                          color: white70,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: white24),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.redAccent),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "GST Number",
                      style: lato(
                        color: white.withOpacity(0.8),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: TextFormField(
                            controller: controller.gstController,
                            style: lato(
                              color: white,
                              fontWeight: FontWeight.w500,
                              fontSize: 13.sp,
                            ),
                            decoration: InputDecoration(
                              hintText: "Enter GST number",
                              hintStyle: lato(
                                color: white.withOpacity(0.6),
                                fontSize: 13.sp,
                                fontWeight: FontWeight.normal,
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade800,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 14.h,
                              ),
                              suffixIconConstraints: BoxConstraints(
                                minHeight: 36.h,
                                minWidth: 60.w,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: 6.w),
                            child: GestureDetector(
                              onTap: () {
                                log("Fetch");
                              },
                              child: Container(
                                height: 45.h,
                                width: 50.w,
                                decoration: BoxDecoration(
                                  color: blue,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Center(
                                  child: Text(
                                    "Fetch",
                                    style: lato(
                                      color: white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "Business Contact No.",
                      style: lato(
                        color: white.withOpacity(0.8),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    TextFormField(
                      controller: controller.contactController,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      style: lato(
                        color: white,
                        fontWeight: FontWeight.w500,
                        fontSize: 13.sp,
                      ),
                      decoration: InputDecoration(
                        labelText: "Enter Contact no.",
                        labelStyle: lato(
                          color: white70,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: white24),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.redAccent),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    Text(
                      "Business E-mail",
                      style: lato(
                        color: white.withOpacity(0.8),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    TextFormField(
                      controller: controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: lato(
                        color: white,
                        fontWeight: FontWeight.w500,
                        fontSize: 13.sp,
                      ),
                      decoration: InputDecoration(
                        labelText: "Enter E-mail address",
                        labelStyle: lato(
                          color: white70,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: white24),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.redAccent),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "Brand Name",
                      style: lato(
                        color: white.withOpacity(0.8),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    TextFormField(
                      controller: controller.brandnameController,
                      keyboardType: TextInputType.name,
                      style: lato(
                        color: white,
                        fontWeight: FontWeight.w500,
                        fontSize: 13.sp,
                      ),
                      decoration: InputDecoration(
                        labelText: "Business Name",
                        labelStyle: lato(
                          color: white70,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: white24),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.redAccent),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Text(
                    "Billing Address",
                    style: lato(
                      color: white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              GetBuilder<Company>(
                builder: (controller) {
                  return (controller.addressController1.text.isEmpty ||
                          controller.addressController2.text.isEmpty ||
                          controller.stateController.text.isEmpty ||
                          controller.cityController.text.isEmpty ||
                          controller.pincoadeController.text.isEmpty ||
                          controller.countryController.text.isEmpty)
                      ? Container(
                        height: 40.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: grey900,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (context) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                    bottom:
                                        MediaQuery.of(
                                          context,
                                        ).viewInsets.bottom,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: grey900,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12),
                                      ),
                                    ),
                                    child: SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 24,
                                          top: 16,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                  ),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Enter Address",
                                                    style: lato(
                                                      color: white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18.sp,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  IconButton(
                                                    onPressed: () {
                                                      Get.back();
                                                    },
                                                    icon: Icon(
                                                      Icons.close,
                                                      color: white,
                                                      size: 16.sp,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Divider(color: grey, thickness: 1),
                                            textInputFields(
                                              "Address Line 1",
                                              controller.addressController1,
                                            ),
                                            textInputFields(
                                              "Address Line 2",
                                              controller.addressController2,
                                            ),
                                            textInputFields(
                                              "Pincode",
                                              controller.pincoadeController,
                                              isNumber: true,
                                            ),
                                            textInputFields(
                                              "City",
                                              controller.cityController,
                                            ),
                                            textInputFields(
                                              "State",
                                              controller.stateController,
                                            ),
                                            textInputFields(
                                              "Country",
                                              controller.countryController,
                                            ),
                                            const SizedBox(height: 20),
                                            Center(
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: blue,
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 24,
                                                    vertical: 12,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10,
                                                        ),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  controller.billing();
                                                  controller.update();
                                                  Get.back();
                                                },
                                                child: Text(
                                                  "Add Billing Address",
                                                  style: lato(
                                                    color: white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16.sp,
                                                  ),
                                                ),
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
                          },
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.add_circle,
                                  color: white,
                                  size: 16.sp,
                                ),
                              ),
                              Text(
                                "Billing Address",
                                style: lato(
                                  color: white70,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      : Container(
                        height: 50.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: grey900,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.all(12.w),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                controller.addressController1.text,
                                style: lato(
                                  color: white70,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16.sp,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.redAccent),
                              onPressed: () {
                                controller.clearAddressFields();
                              },
                            ),
                          ],
                        ),
                      );
                },
              ),

              SizedBox(height: 8.h),
              Row(
                children: [
                  Text(
                    "Shipping Address",
                    style: lato(
                      color: white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              GetBuilder<Company>(
                builder: (controller) {
                  return (controller.shipping1Controller.text.isEmpty ||
                          controller.shipping2Controller.text.isEmpty ||
                          controller.shippingpincodeController.text.isEmpty ||
                          controller.shippingcityController.text.isEmpty ||
                          controller.shippingstateController.text.isEmpty ||
                          controller.shippingcountryController.text.isEmpty)
                      ? Container(
                        height: 40.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: grey900,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (context) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                    bottom:
                                        MediaQuery.of(
                                          context,
                                        ).viewInsets.bottom,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: grey900,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12),
                                      ),
                                    ),
                                    child: SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 24,
                                          top: 16,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                  ),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Enter Address",
                                                    style: lato(
                                                      color: white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18.sp,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  IconButton(
                                                    onPressed: () {
                                                      Get.back();
                                                    },
                                                    icon: Icon(
                                                      Icons.close,
                                                      color: white,
                                                      size: 16.sp,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Divider(color: grey, thickness: 1),
                                            textInputFields(
                                              "Address Line 1",
                                              controller.shipping1Controller,
                                            ),
                                            textInputFields(
                                              "Address Line 2",
                                              controller.shipping2Controller,
                                            ),
                                            textInputFields(
                                              "Pincode",
                                              controller
                                                  .shippingpincodeController,
                                              isNumber: true,
                                            ),
                                            textInputFields(
                                              "City",
                                              controller.shippingcityController,
                                            ),
                                            textInputFields(
                                              "State",
                                              controller
                                                  .shippingstateController,
                                            ),
                                            textInputFields(
                                              "Country",
                                              controller
                                                  .shippingcountryController,
                                            ),
                                            const SizedBox(height: 20),
                                            Center(
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: blue,
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 24,
                                                    vertical: 12,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10,
                                                        ),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  controller.shipping();
                                                  Get.back();
                                                },
                                                child: Text(
                                                  "Add Shipping Address",
                                                  style: lato(
                                                    color: white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16.sp,
                                                  ),
                                                ),
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
                          },
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.add_circle,
                                  color: white,
                                  size: 16.sp,
                                ),
                              ),
                              Text(
                                "Shipping Address",
                                style: lato(
                                  color: white70,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      : Container(
                        height: 50.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: grey900,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.all(12.w),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                controller.shipping1Controller.text,
                                style: lato(
                                  color: white70,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16.sp,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.redAccent),
                              onPressed: () {
                                controller.clearShippingFields();
                              },
                            ),
                          ],
                        ),
                      );
                },
              ),
              SizedBox(height: 20.h),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: grey900,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: controller.panController,
                      keyboardType: TextInputType.name,
                      maxLength: 10,
                      style: lato(
                        color: white,
                        fontWeight: FontWeight.w500,
                        fontSize: 13.sp,
                      ),
                      decoration: InputDecoration(
                        labelText: "PAN",
                        labelStyle: lato(
                          color: white70,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: white24),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.redAccent),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),

                    SizedBox(height: 5.h),
                    TextFormField(
                      controller: controller.alternatecontactController,
                      keyboardType: TextInputType.number,
                      style: lato(
                        color: white,
                        fontWeight: FontWeight.w500,
                        fontSize: 13.sp,
                      ),
                      decoration: InputDecoration(
                        labelText: "Alternate Contact Number",
                        labelStyle: lato(
                          color: white70,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: white24),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.redAccent),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    TextFormField(
                      controller: controller.webController,
                      keyboardType: TextInputType.webSearch,
                      style: lato(
                        color: white,
                        fontWeight: FontWeight.w500,
                        fontSize: 13.sp,
                      ),
                      decoration: InputDecoration(
                        labelText: "Website",
                        labelStyle: lato(
                          color: white70,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: white24),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.redAccent),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
            if (controller.panController.text.isNotEmpty &&
                controller.alternatecontactController.text.isNotEmpty &&
                controller.webController.text.isNotEmpty) {
              controller.saveAllData();
            } else {
              Get.snackbar(
                "Error",
                "Please fill all the fields",
                snackPosition: SnackPosition.TOP,
                backgroundColor: Colors.red,
                colorText: Colors.white,
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            padding: EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            "Add & Update Details",
            style: lato(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget textInputFields(
    String label,
    TextEditingController controller, {
    bool isNumber = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: TextField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: white, fontSize: 14),
          filled: true,
          fillColor: Colors.transparent,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white24),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: white),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        style: TextStyle(color: white, fontSize: 14),
      ),
    );
  }
}
