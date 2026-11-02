import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  final TextEditingController pinController = TextEditingController();
  var pinError = RxnString();

  void verifyOtp() {
    String otp = pinController.text;
    if (otp.length < 4) {
      pinError.value = 'Please enter complete 4-digit OTP';
      Get.snackbar(
        'Error',
        'Please enter complete 4-digit OTP',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }
    pinError.value = null;
    Get.offAllNamed('/home');
  }

  void goBack() {
    Get.back();
  }

  @override
  void onClose() {
    pinController.dispose();
    super.onClose();
  }
}
