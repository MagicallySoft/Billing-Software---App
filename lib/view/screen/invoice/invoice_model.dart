import 'dart:io';

class InvoiceData {
  final int id;
  final String address;
  final String bankName;
  final String accountNumber;
  final String reference;
  final String ifscCode;
  final String notes;
  final String terms;
  final String paymentMethod;
  final File? signatureImage;
  final String customerName;
  final DateTime date;
  final DateTime due;

  InvoiceData({
    required this.id,
    required this.address,
    required this.bankName,
    required this.accountNumber,
    required this.reference,
    required this.ifscCode,
    required this.notes,
    required this.terms,
    required this.paymentMethod,
    required this.signatureImage,
    required this.customerName,
    required this.date,
    required this.due,
  });
}
