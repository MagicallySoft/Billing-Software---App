import 'package:get/get.dart';
import 'package:signature/signature.dart';
import 'dart:typed_data';
import '../../../../colors/colours.dart' as AppColors;

class SignatureControllerX extends GetxController {
  final SignatureController Signaturecontroller = SignatureController(
    penStrokeWidth: 3,
    penColor: AppColors.white,
  );

  Rx<Uint8List?> signature = Rx<Uint8List?>(null);

  void saveSignature() async {
    final sig = await Signaturecontroller.toPngBytes();
    if (sig != null && sig.isNotEmpty) {
      signature.value = sig;
      Get.snackbar('Success', 'Signature saved!');
    } else {
      Get.snackbar('Error', 'No signature detected.');
    }
  }

  void clearSignature() {
    Signaturecontroller.clear();
    signature.value = null;
  }

  @override
  void onClose() {
    Signaturecontroller.dispose();
    super.onClose();
  }
}
