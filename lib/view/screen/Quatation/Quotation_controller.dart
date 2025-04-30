import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class QuotationController extends GetxController {
  Rx<DateTime?> QuotationdueDate = Rx<DateTime?>(null);
  RxString address = ''.obs;
  Rx<XFile?> signature = Rx<XFile?>(null);

  RxList Quotation = [].obs;
  var notesText = ''.obs;
  var termsText = ''.obs;
  var deliveryCharges = ''.obs;
  var packagingCharges = ''.obs;
  var discountAmount = ''.obs;
  RxString paymentMethod = 'Cash'.obs;
  RxString paymentTerms = ''.obs;
  RxString paymentBankName = ''.obs;
  RxString paymentAccountNumber = ''.obs;
  RxString paymentIFSC = ''.obs;

  TextEditingController addressController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController termsController = TextEditingController();
  TextEditingController dilivryController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController pakageController = TextEditingController();
  TextEditingController refrenceController = TextEditingController();
  TextEditingController bankName = TextEditingController();
  TextEditingController acc = TextEditingController();
  TextEditingController ifsc = TextEditingController();

  late XFile? image;

  QuatationDataAdd() {
    if (addressController.text.isNotEmpty) {
      Quotation.add({
        'address': addressController.text,
        'notes': notesController.text,
        'terms': termsController.text,
        'deliveryCharges': dilivryController.text,
        'discountAmount': discountController.text,
        'packagingCharges': pakageController.text,
        'refrence': refrenceController.text,
        'bankName': bankName.text,
        'acc': acc.text,
        'ifsc': ifsc.text,
        'signature': signature.value,
        'paymentMethod': paymentMethod.value,
        'paymentTerms': paymentTerms.value,
        'dueDate': QuotationdueDate.value?.toString(),
      });
    }
  }

  void clearData() {
    addressController.clear();
    notesController.clear();
    termsController.clear();
    dilivryController.clear();
    discountController.clear();
    pakageController.clear();
    refrenceController.clear();
    bankName.clear();
    acc.clear();
    ifsc.clear();
    signature.value = null;
    paymentMethod = 'Cash'.obs;
    paymentTerms = ''.obs;
    paymentBankName = ''.obs;
    paymentAccountNumber = ''.obs;
    paymentIFSC = ''.obs;
    QuotationdueDate.value = null;
    update();
  }

  Future<void> selectQuotationdueDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: QuotationdueDate.value ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      QuotationdueDate.value = picked;
      update();
    }
  }

  Future<void> pickSignature() async {
    final ImagePicker picker = ImagePicker();
    image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      signature.value = image;
    }
  }

  Future<void> QuatationPdf() async {
    final pdf = pw.Document();
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
                          "Quotation",
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
                              'EST-0001',
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
                              "",
                              style: pw.TextStyle(
                                fontSize: 12,
                                color: PdfColors.black,
                              ),
                            ),
                            pw.Text(
                              "",
                              style: pw.TextStyle(
                                fontSize: 12,
                                color: PdfColors.black,
                              ),
                            ),
                            pw.Text(
                              "",
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
                            "GST no : dfbdu53536f",
                            style: pw.TextStyle(
                              fontSize: 10,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.blueGrey800,
                            ),
                          ),
                          pw.SizedBox(height: 10),
                          pw.Text(
                            "Bank detail ",
                            style: pw.TextStyle(
                              fontSize: 10,
                              color: PdfColors.blueGrey800,
                            ),
                          ),
                          pw.Text(
                            "ACC no : 123456789",
                            style: pw.TextStyle(
                              fontSize: 10,
                              color: PdfColors.blueGrey800,
                            ),
                          ),
                          pw.SizedBox(height: 5),
                          pw.Text(
                            "Branch : Gujarat",
                            style: pw.TextStyle(
                              fontSize: 10,
                              color: PdfColors.blueGrey800,
                            ),
                          ),
                          pw.Text(
                            "Date : ${DateTime.now().toString().split(' ')[0]}",
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
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                "To ",
                style: pw.TextStyle(fontSize: 10, color: PdfColors.blueGrey800),
              ),
              pw.Text(
                "Customer",
                style: pw.TextStyle(fontSize: 14, color: PdfColors.blueGrey800),
              ),
              pw.SizedBox(height: 20),
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
                      [
                        "1",
                        "Back-end services",
                        "80 hrs",
                        " 2000.00",
                        " 0.00",
                        " 80,000.00",
                      ],
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
                          "",
                          style: pw.TextStyle(
                            fontSize: 10,
                            color: PdfColors.blueGrey800,
                          ),
                        ),
                        pw.Text(
                          "",
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
                          "",
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
                        // pw.Image(signatureImage, width: 100, height: 50),
                      ],
                    ),
                  ],
                ),
              ),
            ],
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/Quotation.pdf");
    log("Path ${file.path}");
    await file.writeAsBytes(await pdf.save());
    await Printing.layoutPdf(onLayout: (format) => pdf.save());
    await Share.shareXFiles([XFile(file.path)]);
  }

  Widget buildQuotationInfo(BuildContext context) {
    DateTime date = DateTime.now();
    return Transform.scale(
      scale: 1,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("EST #", style: TextStyle(color: Colors.grey)),
              const Text(
                "EST-1",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              Row(
                children: [
                  Text(
                    date.toString().split(' ')[0],
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => selectQuotationdueDate(context),
                    child: Row(
                      children: [
                        const SizedBox(width: 55),
                        const Text(
                          "Due Date: ",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Obx(() {
                          return Text(
                            QuotationdueDate.value != null
                                ? QuotationdueDate.value.toString().split(
                                  ' ',
                                )[0]
                                : "Select Date",
                            style: const TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }),
                        const SizedBox(width: 6),
                        const Icon(
                          Icons.calendar_today,
                          color: Colors.grey,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
