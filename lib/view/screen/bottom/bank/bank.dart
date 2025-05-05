import 'package:flutter/material.dart';
import 'package:invoice_generator/colors/colours.dart';
import 'package:get/get.dart';

import '../../../../routes/routes.dart';
import 'bank_controller.dart';

class Bank extends StatelessWidget {
  const Bank({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BankController());

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
        ),
        backgroundColor: Colors.black,
        title: Text("Bank", style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GetBuilder<BankController>(
          builder:
              (c) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Added Accounts",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  if (controller.bankAccounts.isEmpty)
                    Text(
                      "No bank accounts added yet.",
                      style: TextStyle(color: Colors.grey),
                    )
                  else
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.bankAccounts.length,
                        itemBuilder: (context, index) {
                          final account = controller.bankAccounts[index];
                          final isDefault =
                              index == controller.defaultAccountIndex.value;

                          return Dismissible(
                            key: Key(account['accountNo'] ?? index.toString()),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              color: Colors.red,
                              child: Icon(Icons.delete, color: Colors.white),
                            ),
                            onDismissed: (_) {
                              controller.bankAccounts.removeAt(index);
                              // Show snack bar after account removal
                              Get.snackbar(
                                "Deleted",
                                "Bank account removed",
                                backgroundColor: Colors.redAccent,
                                colorText: Colors.white,
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            },
                            child: Card(
                              color: Colors.grey[900],
                              child: ListTile(
                                title: Row(
                                  children: [
                                    Text(
                                      account['bankName'] ?? '',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    if (isDefault)
                                      Icon(
                                        Icons.star,
                                        color: Colors.green,
                                        size: 20,
                                      ),
                                  ],
                                ),
                                subtitle: Text(
                                  "A/C: ${account['accountNo']}",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                trailing: IconButton(
                                  icon: Icon(
                                    Icons.star_border,
                                    color:
                                        isDefault ? Colors.green : Colors.grey,
                                  ),
                                  onPressed:
                                      () => controller.setDefaultAccount(index),
                                ),
                              ),
                            ),
                          );
                        },
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
          onPressed: () => Get.toNamed(Routes.add_bank_acc),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            padding: EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            "Add Bank Account",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
