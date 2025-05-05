import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class NoteController extends GetxController {
  TextEditingController invoicenotesController = TextEditingController();
  TextEditingController purchesenotesController = TextEditingController();
  TextEditingController quotesnotesController = TextEditingController();
  TextEditingController salesnotesController = TextEditingController();
  TextEditingController purchesnotesController = TextEditingController();
  TextEditingController purchesOrdernotesController = TextEditingController();
  TextEditingController proFormnotesController = TextEditingController();
  TextEditingController deliverynotesController = TextEditingController();

  TextEditingController invoicetermsController = TextEditingController();
  TextEditingController purchesetermsController = TextEditingController();
  TextEditingController quotestermsController = TextEditingController();
  TextEditingController salestermsController = TextEditingController();
  TextEditingController purchestermsController = TextEditingController();
  TextEditingController purchesOrdertermsController = TextEditingController();
  TextEditingController proFormtemsController = TextEditingController();
  TextEditingController deliverytermsController = TextEditingController();

  final noteInput = ''.obs;

  void updateNoteInput(String value) {
    noteInput.value = value;
  }
}
