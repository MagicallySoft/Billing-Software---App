import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:invoice_generator/colors/colours.dart';
import '../../../../routes/routes.dart';
import 'add_customer.dart';
import 'add_customer_controller.dart';

class AllCustomers extends StatefulWidget {
  const AllCustomers({super.key});

  @override
  State<AllCustomers> createState() => _CustomerFormState();
}

class _CustomerFormState extends State<AllCustomers> {
  final controller = Get.put(CustomerController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: black,
        appBar: AppBar(
          backgroundColor: black,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded, color: white),
          ),

          title: Text(
            'Customers',
            style: TextStyle(
              color: white,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            children: [
              Expanded(
                child: Obx(() {
                  if (controller.customers.isEmpty) {
                    return Center(
                      child: Text(
                        'No customers added yet.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: controller.customers.length,
                      itemBuilder: (_, index) {
                        final customer = controller.customers[index];
                        return Dismissible(
                          key: Key(customer.hashCode.toString()),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          onDismissed: (_) {
                            controller.deletCustomer(index: index);
                            Get.snackbar(
                              "Deleted",
                              "Customer removed",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.grey[900],
                              colorText: Colors.white,
                            );
                          },
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.invoice, arguments: customer);
                            },
                            child: Card(
                              color: grey900,
                              elevation: 4,
                              margin: EdgeInsets.symmetric(vertical: 8.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor:
                                      Colors.primaries[index %
                                          Colors.primaries.length],
                                  child: Text(
                                    customer['name']
                                        .toString()[0]
                                        .toUpperCase(),
                                    style: TextStyle(color: white),
                                  ),
                                ),
                                title: Text(
                                  customer['name'] ?? '',
                                  style: TextStyle(
                                    color: white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp,
                                  ),
                                ),
                                subtitle: Text(
                                  customer['email'] ?? '',
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 14.sp,
                                  ),
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    controller.loadCustomerForEdit(index);
                                    Get.to(() => AddCustomer());
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.green,
                                    size: 20.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                }),
              ),
            ],
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
              Get.toNamed(Routes.Add_customers);
            },
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
      ),
    );
  }
}
