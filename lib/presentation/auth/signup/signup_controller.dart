import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignupController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();

  var obscurePassword = true.obs;
  var obscureConfirmPassword = true.obs;

  var emailError = RxnString();
  var passwordError = RxnString();
  var confirmPasswordError = RxnString();
  var mobileError = RxnString();

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
  }

  bool validate() {
    bool isValid = true;
    String email = emailController.text.trim();
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;
    String mobile = mobileController.text.trim();

    if (email.isEmpty || !GetUtils.isEmail(email)) {
      emailError.value = 'Please enter a valid email address';
      isValid = false;
    } else {
      emailError.value = null;
    }

    if (password.isEmpty || password.length < 6) {
      passwordError.value = 'Password must be at least 6 characters';
      isValid = false;
    } else {
      passwordError.value = null;
    }

    if (confirmPassword != password) {
      confirmPasswordError.value = 'Passwords do not match';
      isValid = false;
    } else {
      confirmPasswordError.value = null;
    }

    if (mobile.isEmpty || mobile.length < 9) {
      mobileError.value = 'Please enter a valid mobile number';
      isValid = false;
    } else {
      mobileError.value = null;
    }

    return isValid;
  }

  Future<void> next() async {
    if (validate()) {
      try {
        UserCredential userCred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text,
        );

        await FirebaseFirestore.instance.collection('users').doc(userCred.user?.uid).set({
          'email': emailController.text.trim(),
          'mobile': mobileController.text.trim(),
          'createdAt': FieldValue.serverTimestamp(),
        });

        Get.snackbar(
          'Success',
          'Account created and saved to Firestore successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offAllNamed('/home');
      } catch (e) {
        Get.snackbar(
          'Sign Up Error',
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    }
  }

  Future<void> socialLogin(String provider) async {
    if (provider == 'Google') {
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
          await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
            'email': userCredential.user!.email,
            'name': userCredential.user!.displayName,
            'createdAt': FieldValue.serverTimestamp(),
          }, SetOptions(merge: true));

          Get.snackbar(
            'Success',
            'Signed up as ${userCredential.user!.displayName ?? 'User'} and saved to Firestore!',
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
    } else {
      Get.snackbar(
        'Social Login',
        'Signing up with $provider',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    mobileController.dispose();
    super.onClose();
  }
}
