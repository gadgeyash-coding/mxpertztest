import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  final TextEditingController phoneController = TextEditingController();
  var phoneError = RxnString();

  void getOtp() {
    String phone = phoneController.text.trim();
    if (phone.isEmpty) {
      phoneError.value = 'Please enter phone number';
      return;
    } else if (phone.length < 10) {
      phoneError.value = 'Please enter a valid 10-digit phone number';
      return;
    }
    phoneError.value = null;
    Get.toNamed('/otp');
  }

  Future<void> socialLogin(String provider) async {
    if (provider == 'Google') {
      await signInWithGoogle();
    } else {
      Get.snackbar(
        'Social Login',
        'Logging in with $provider',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      
      if (userCredential.user != null) {
        Get.snackbar(
          'Success',
          'Logged in as ${userCredential.user!.displayName ?? 'User'}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offAllNamed('/home');
      }
    } catch (e) {
      Get.snackbar(
        'Google Sign-In Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  void signUp() {
    Get.toNamed('/signup');
  }

  @override
  void onClose() {
    phoneController.dispose();
    super.onClose();
  }
}
