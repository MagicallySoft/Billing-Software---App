import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../colors/colours.dart';
import 'add_customer_controller.dart';

class AddCustomer extends StatefulWidget {
  const AddCustomer({super.key});

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  final controller = Get.put(CustomerController());

  bool isChange = false;
  bool isChange2 = false;
  String? selectedPriceList;
  bool isTdsApplicable = false;
  bool isTcsApplicable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: black,
        leading: IconButton(
          onPressed: () {
            Get.back();
            controller.clearFields();
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: white),
        ),
        title: Text(
          "Add Customer",
          style: lato(
            color: white,
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
        iconTheme: IconThemeData(color: white),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Company Details",
                style: lato(
                  color: white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(height: 6.h),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: grey900,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Business Details",
                      style: lato(
                        color: white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(height: 20.h),

                    Text(
                      "GST Number",
                      style: lato(
                        color: white.withOpacity(0.8),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    TextFormField(
                      controller: controller.gstController,
                      style: lato(
                        color: white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                      decoration: InputDecoration(
                        hintText: "Enter GST number",
                        hintStyle: lato(
                          color: white.withOpacity(0.6),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade800,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 18.h,
                        ),
                        suffixIconConstraints: BoxConstraints(
                          minHeight: 40.h,
                          minWidth: 80.w,
                        ),
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(right: 8.w),
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 60.w,
                              decoration: BoxDecoration(
                                color: blue,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  "Fetch",
                                  style: lato(
                                    color: white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20.h),

                    Text(
                      "Company Name",
                      style: lato(
                        color: white.withOpacity(0.8),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    TextFormField(
                      controller: controller.companyController,
                      style: lato(
                        color: white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                      decoration: inputDecoration("Enter company name"),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15.h),

              Text(
                "Basic Details",
                style: lato(
                  color: white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12.h),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: grey900,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Personal Details",
                      style: lato(
                        color: white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "Full Name *",
                      style: lato(
                        color: white.withOpacity(0.8),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    TextFormField(
                      controller: controller.nameController,
                      style: lato(
                        color: white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                      decoration: inputDecoration("Enter your name"),
                      validator:
                          (value) => value!.isEmpty ? 'Enter name' : null,
                    ),

                    SizedBox(height: 16.h),

                    Text(
                      "Phone Number",
                      style: lato(
                        color: white.withOpacity(0.8),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    IntlPhoneField(
                      style: lato(
                        color: white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                      decoration: inputDecoration("Enter phone number"),
                      initialCountryCode: 'IN',
                      onChanged: (phone) {
                        controller.numberController.text = phone.completeNumber;
                      },
                    ),

                    SizedBox(height: 16.h),

                    Text(
                      "Email",
                      style: lato(
                        color: white.withOpacity(0.8),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    TextFormField(
                      controller: controller.emailController,
                      style: lato(
                        color: white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                      decoration: inputDecoration("Enter your email"),
                      validator:
                          (value) => value!.isEmpty ? 'Enter email' : null,
                    ),
                  ],
                ),
              ),

              Row(
                children: [
                  Text(
                    "Billing Address (Optional)",
                    style: lato(
                      color: white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              (controller.addressController1.text.isNotEmpty ||
                      controller.addressController2.text.isNotEmpty ||
                      controller.cityController.text.isNotEmpty ||
                      controller.stateController.text.isNotEmpty ||
                      controller.pinecodeController.text.isNotEmpty ||
                      controller.countryController.text.isNotEmpty)
                  ? Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: grey900,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                            Spacer(),
                            TextButton.icon(
                              onPressed: () {
                                final address =
                                    "${controller.addressController1.text}, "
                                    "${controller.addressController2.text}, "
                                    "${controller.cityController.text}, "
                                    "${controller.stateController.text} - "
                                    "${controller.pinecodeController.text}, "
                                    "${controller.countryController.text}";
                                Share.share("Billing Address:\n$address");
                              },
                              icon: Icon(
                                Icons.share,
                                color: white70,
                                size: 18.sp,
                              ),
                              label: Text(
                                "Share",
                                style: lato(
                                  color: white70,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "${controller.addressController1.text}, "
                          "${controller.addressController2.text}, "
                          "${controller.cityController.text}, "
                          "${controller.stateController.text} - "
                          "${controller.pinecodeController.text}, "
                          "${controller.countryController.text}",
                          style: lato(
                            color: white70,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton.icon(
                              onPressed: () {
                                setState(() {
                                  controller.clearFields();
                                });
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.redAccent,
                                size: 18.sp,
                              ),
                              label: Text(
                                "Delete",
                                style: lato(
                                  color: Colors.redAccent,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                  : Container(
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
                                    MediaQuery.of(context).viewInsets.bottom,
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
                                    padding: const EdgeInsets.only(bottom: 24),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 16,
                                            left: 10,
                                            right: 10,
                                          ),
                                          child: Row(
                                            children: [
                                              Text(
                                                "Enter Address",
                                                style: lato(
                                                  color: white,
                                                  fontWeight: FontWeight.bold,
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
                                          controller.pinecodeController,
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
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            onPressed: () {
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
                  ),

              SizedBox(height: 8.h),
              Row(
                children: [
                  Text(
                    "Shipping Address (Optional)",
                    style: lato(
                      color: white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Container(
                height: 150.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: grey900,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: GetBuilder<CustomerController>(
                  builder: (controller) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        (controller.shippingadd1.text.isNotEmpty ||
                                controller.shippingadd2.text.isNotEmpty ||
                                controller.shippingcity.text.isNotEmpty ||
                                controller.shippingstate.text.isNotEmpty ||
                                controller.shippingpincode.text.isNotEmpty ||
                                controller.shippingcountry.text.isNotEmpty)
                            ? Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: grey900,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
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
                                      Spacer(),
                                      TextButton.icon(
                                        onPressed: () {
                                          final address =
                                              "${controller.shippingadd1.text}, "
                                              "${controller.shippingadd2.text}, "
                                              "${controller.shippingcity.text}, "
                                              "${controller.shippingstate.text} - "
                                              "${controller.shippingpincode.text}, "
                                              "${controller.shippingcountry.text}";
                                          Share.share(
                                            "Shipping Address:\n$address",
                                          );
                                        },
                                        icon: Icon(
                                          Icons.share,
                                          color: white70,
                                          size: 18.sp,
                                        ),
                                        label: Text(
                                          "Share",
                                          style: lato(
                                            color: white70,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    "${controller.shippingadd1.text}, "
                                    "${controller.shippingadd2.text}, "
                                    "${controller.shippingcity.text}, "
                                    "${controller.shippingstate.text} - "
                                    "${controller.shippingpincode.text}, "
                                    "${controller.shippingcountry.text}",
                                    style: lato(
                                      color: white70,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton.icon(
                                        onPressed: () {
                                          controller.shippingadd1.clear();
                                          controller.shippingadd2.clear();
                                          controller.shippingcity.clear();
                                          controller.shippingstate.clear();
                                          controller.shippingpincode.clear();
                                          controller.shippingcountry.clear();
                                          controller.isSameAsBilling.value =
                                              false;
                                          controller.update();
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.redAccent,
                                          size: 18.sp,
                                        ),
                                        label: Text(
                                          "Delete",
                                          style: lato(
                                            color: Colors.redAccent,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                            : Row(
                              children: [
                                IconButton(
                                  onPressed: () {
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
                                              physics: BouncingScrollPhysics(),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  bottom: 24,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                            top: 16,
                                                            left: 10,
                                                            right: 10,
                                                          ),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "Enter Shipping Address",
                                                            style: lato(
                                                              color: white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
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
                                                    Divider(
                                                      color: grey,
                                                      thickness: 1,
                                                    ),
                                                    textInputFields(
                                                      "Address Line 1",
                                                      controller.shippingadd1,
                                                    ),
                                                    textInputFields(
                                                      "Address Line 2",
                                                      controller.shippingadd2,
                                                    ),
                                                    textInputFields(
                                                      "Pincode",
                                                      controller
                                                          .shippingpincode,
                                                      isNumber: true,
                                                    ),
                                                    textInputFields(
                                                      "City",
                                                      controller.shippingcity,
                                                    ),
                                                    textInputFields(
                                                      "State",
                                                      controller.shippingstate,
                                                    ),
                                                    textInputFields(
                                                      "Country",
                                                      controller
                                                          .shippingcountry,
                                                    ),
                                                    const SizedBox(height: 20),
                                                    Center(
                                                      child: ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                          backgroundColor: blue,
                                                          padding:
                                                              EdgeInsets.symmetric(
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
                                                          controller.update();
                                                          Get.back();
                                                        },
                                                        child: Text(
                                                          "Add Shipping Address",
                                                          style: lato(
                                                            color: white,
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                    fontSize: 14.sp,
                                  ),
                                ),
                                Spacer(),
                                IconButton(
                                  onPressed: () {
                                    controller.copyBillingToShipping();
                                    controller.update();
                                  },
                                  icon: Icon(
                                    Icons.copy,
                                    color: white,
                                    size: 16.sp,
                                  ),
                                ),
                              ],
                            ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Text(
                    'Customer Preferences (Optional)',
                    style: lato(
                      color: white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                  Spacer(),
                  Transform.scale(
                    scale: 0.8,
                    child: Switch(
                      activeColor: blue,
                      value: isChange,
                      onChanged: (value) {
                        setState(() {
                          isChange = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Visibility(
                visible: isChange,
                child: Container(
                  decoration: BoxDecoration(
                    color: grey900,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 20.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Credit Limit",
                        style: lato(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      textInputFields(
                        "Enter credit limit",
                        controller.creditLimitController,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        "Price List",
                        style: lato(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Obx(
                        () => DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            hintText: "Select Price List",
                            hintStyle: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade800,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 14.w,
                              vertical: 14.h,
                            ),
                          ),
                          dropdownColor: grey900,
                          style: TextStyle(color: Colors.white),
                          value:
                              controller.selectedPriceList.value.isEmpty
                                  ? null
                                  : controller.selectedPriceList.value,
                          items:
                              controller.priceListOptions.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                );
                              }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              controller.selectedPriceList.value = newValue;
                            }
                          },
                        ),
                      ),

                      SizedBox(height: 24.h),

                      /// TDS Switch
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'TDS applicable?',
                            style: lato(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Switch(
                            value: isTdsApplicable,
                            onChanged: (bool value) {
                              setState(() {
                                isTdsApplicable = value;
                              });
                            },
                            activeColor: Colors.blueAccent,
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),

                      /// TCS Switch
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'TCS applicable?',
                            style: lato(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Switch(
                            value: isTcsApplicable,
                            onChanged: (bool value) {
                              setState(() {
                                isTcsApplicable = value;
                              });
                            },
                            activeColor: Colors.blueAccent,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              Row(
                children: [
                  Text(
                    'Other Details (Optional)',
                    style: lato(
                      color: white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                  Spacer(),
                  Transform.scale(
                    scale: 0.8,
                    child: Switch(
                      activeColor: blue,
                      value: isChange2,
                      onChanged: (value) {
                        setState(() {
                          isChange2 = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: isChange2,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Container(
                    padding: EdgeInsets.all(16.w),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: grey900,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.account_balance_wallet_outlined,
                                  color: blue,
                                  size: 18.sp,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  "Opening Balance",
                                  style: lato(
                                    color: white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Obx(
                                  () => DropdownButton<String>(
                                    value: controller.balanceType.value,
                                    dropdownColor: grey900,
                                    underline: SizedBox(),
                                    style: TextStyle(color: white),
                                    items:
                                        ['Credit', 'Debit'].map((type) {
                                          return DropdownMenuItem(
                                            value: type,
                                            child: Text(type),
                                          );
                                        }).toList(),
                                    onChanged: (val) {
                                      controller.balanceType.value = val!;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Obx(
                              () => TextField(
                                controller: controller.openingBalance,
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                  color:
                                      controller.balanceType.value == 'Debit'
                                          ? Colors.red
                                          : Colors.green,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: InputDecoration(
                                  hintText: "Enter Amount",
                                  hintStyle: TextStyle(color: Colors.grey[600]),
                                  filled: true,
                                  fillColor: grey900,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

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
                                  (context) => Container(
                                    height: 250.h,
                                    decoration: BoxDecoration(
                                      color: grey900,
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(12),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(16.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: Text(
                                              "Add Notes",
                                              style: lato(
                                                color: white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.sp,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 16.h),
                                          textInputFields(
                                            "Enter Your Notes",
                                            controller.notesController,
                                          ),
                                          SizedBox(height: 20.h),
                                          Center(
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: blue,
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 32.w,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                              onPressed: () {
                                                Get.back();
                                              },
                                              child: Text(
                                                "Save",
                                                style: lato(
                                                  color: white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14.sp,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                            );
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.note_add_outlined,
                                color: blue,
                                size: 18.sp,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                "Notes",
                                style: lato(
                                  color: white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 20.h),

                        textInputFields("PAN", controller.panController),
                        SizedBox(height: 6.h),
                        Text(
                          "ex. CTYPS1234R",
                          style: lato(
                            color: white70,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        ),

                        SizedBox(height: 24.h),

                        Text(
                          "CC E-mail",
                          style: lato(
                            color: white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          "E-mail to be added as CC in all outgoing emails.",
                          style: lato(
                            color: white70,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        textInputFields(
                          "CC E-mail",
                          controller.ccemailController,
                        ),

                        SizedBox(height: 20.h),

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
                                  (context) => Container(
                                    height: 250.h,
                                    decoration: BoxDecoration(
                                      color: grey900,
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(12),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(16.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: Text(
                                              "Add Tag",
                                              style: lato(
                                                color: white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.sp,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 16.h),
                                          textInputFields(
                                            "Enter Your Tag",
                                            controller.addTageController,
                                          ),
                                          SizedBox(height: 20.h),
                                          Center(
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: blue,
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 32.w,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                              onPressed: () {
                                                Get.back();
                                              },
                                              child: Text(
                                                "Save",
                                                style: lato(
                                                  color: white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14.sp,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                            );
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.tag_outlined,
                                color: blue,
                                size: 18.sp,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                "Add Tag",
                                style: lato(
                                  color: white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp,
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
          onPressed: controller.addOrUpdateCustomer,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            padding: EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            "Add Customer",
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

  InputDecoration inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: lato(
        color: white70,
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
      ),
      filled: true,
      fillColor: Colors.transparent,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: white24),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(10),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.redAccent),
        borderRadius: BorderRadius.circular(10),
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
    );
  }
}
