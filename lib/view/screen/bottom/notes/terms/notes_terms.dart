import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../colors/colours.dart';
import 'note_controller.dart';

class NotesTerms extends StatelessWidget {
  const NotesTerms({super.key});

  final List<Map<String, dynamic>> notesList = const [
    {'title': 'Invoice', 'icon': Icons.receipt_long_rounded},
    {'title': 'Purchase', 'icon': Icons.shopping_cart},
    {'title': 'Quotation', 'icon': Icons.assignment},
    {'title': 'Sales Return / Credit Note', 'icon': Icons.upload},
    {'title': 'Purchase Return / Debit Note', 'icon': Icons.download},
    {'title': 'Purchase Order', 'icon': Icons.inventory_2},
    {'title': 'Pro Form Invoice', 'icon': Icons.calculate},
    {'title': 'Delivery Challan', 'icon': Icons.local_shipping},
  ];

  @override
  Widget build(BuildContext context) {
    NoteController noteController = Get.put(NoteController());
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: black,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios_new_rounded, color: white),
          ),
          backgroundColor: black,
          title: Text("Notes & Terms", style: TextStyle(color: white)),
          bottom: TabBar(
            labelColor: white,
            unselectedLabelColor: Colors.grey,
            indicatorColor: white,
            tabs: const [Tab(text: "Notes"), Tab(text: "Terms")],
          ),
        ),
        body: TabBarView(
          children: [
            ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: notesList.length,
              itemBuilder: (context, index) {
                final item = notesList[index];
                return GestureDetector(
                  onTap: () {
                    TextEditingController getController(String title) {
                      switch (title) {
                        case 'Invoice':
                          return noteController.invoicenotesController;
                        case 'Purchase':
                          return noteController.purchesenotesController;
                        case 'Quotation':
                          return noteController.quotesnotesController;
                        case 'Sales Return / Credit Note':
                          return noteController.salesnotesController;
                        case 'Purchase Return / Debit Note':
                          return noteController.purchesnotesController;
                        case 'Purchase Order':
                          return noteController.purchesOrdernotesController;
                        case 'Pro Form Invoice':
                          return noteController.proFormnotesController;
                        case 'Delivery Challan':
                          return noteController.deliverynotesController;
                        default:
                          return TextEditingController();
                      }
                    }

                    final TextEditingController textController = getController(
                      item['title'],
                    );

                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                      ),
                      backgroundColor: const Color(0xFF1F1F1F),
                      builder: (context) {
                        return Padding(
                          padding: MediaQuery.of(context).viewInsets,
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            height: 250.h,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['title'],
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 16.h),
                                TextField(
                                  controller: textController,
                                  style: TextStyle(color: white),
                                  decoration: InputDecoration(
                                    hintText: 'Enter your note here...',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    filled: true,
                                    fillColor: Colors.black26,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 50.h),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      noteController.updateNoteInput(
                                        textController.text,
                                      );
                                      log(
                                        '${item['title']} terms saved: ${textController.text}',
                                      );
                                      Get.back();
                                      Get.snackbar(
                                        "Saved",
                                        "Terms for '${item['title']}' saved.",
                                        backgroundColor: Colors.green,
                                        colorText: Colors.white,
                                        snackPosition: SnackPosition.BOTTOM,
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.indigo,
                                      padding: EdgeInsets.symmetric(
                                        vertical: 16,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Add ${item['title']} Notes",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1F1F1F),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Icon(item['icon'], color: white),
                        SizedBox(width: 16.w),
                        Text(
                          item['title'],
                          style: TextStyle(
                            color: white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            //=======================tabBAR===============================//
            ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: notesList.length,
              itemBuilder: (context, index) {
                final item = notesList[index];
                TextEditingController getTermsController(String title) {
                  switch (title) {
                    case 'Invoice':
                      return noteController.invoicetermsController;
                    case 'Purchase':
                      return noteController.purchesetermsController;
                    case 'Quotation':
                      return noteController.quotestermsController;
                    case 'Sales Return / Credit Note':
                      return noteController.salestermsController;
                    case 'Purchase Return / Debit Note':
                      return noteController.purchestermsController;
                    case 'Purchase Order':
                      return noteController.purchesOrdertermsController;
                    case 'Pro Form Invoice':
                      return noteController.proFormtemsController;
                    case 'Delivery Challan':
                      return noteController.deliverytermsController;
                    default:
                      return TextEditingController();
                  }
                }

                return GestureDetector(
                  onTap: () {
                    final TextEditingController textController =
                        getTermsController(item['title']);

                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                      ),
                      backgroundColor: const Color(0xFF1F1F1F),
                      builder: (context) {
                        return Padding(
                          padding: MediaQuery.of(context).viewInsets,
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            height: 250,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['title'],
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                TextField(
                                  controller: textController,
                                  style: TextStyle(color: white),
                                  decoration: InputDecoration(
                                    hintText: 'Enter your terms here...',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    filled: true,
                                    fillColor: Colors.black26,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 30.h),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      noteController.updateNoteInput(
                                        textController.text,
                                      );
                                      log(
                                        '${item['title']} terms saved: ${textController.text}',
                                      );
                                      Get.back();
                                      Get.snackbar(
                                        "Saved",
                                        "Terms for '${item['title']}' saved.",
                                        backgroundColor: Colors.green,
                                        colorText: Colors.white,
                                        snackPosition: SnackPosition.BOTTOM,
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.indigo,
                                      padding: EdgeInsets.symmetric(
                                        vertical: 16,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Add ${item['title']} Terms",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1F1F1F),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Icon(item['icon'], color: white),
                        const SizedBox(width: 16),
                        Text(
                          item['title'],
                          style: TextStyle(
                            color: white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
