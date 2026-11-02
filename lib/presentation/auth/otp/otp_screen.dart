import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import 'otp_controller.dart';

class OtpScreen extends GetView<OtpController> {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OtpController());
    final size = MediaQuery.sizeOf(context);

    final defaultPinTheme = PinTheme(
      width: size.width * 0.16,
      height: size.width * 0.16,
      textStyle: TextStyle(
        fontSize: size.width * 0.06,
        fontWeight: FontWeight.bold,
        color: AppColors.black,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightGrey, width: 1.5),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: AppColors.primaryTeal, width: 2),
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: AppColors.lightGrey.withOpacity(0.3),
        border: Border.all(color: AppColors.primaryTeal, width: 1.5),
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.08,
            vertical: size.height * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Button
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryTeal.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.chevron_left, color: AppColors.primaryTeal),
                  onPressed: controller.goBack,
                ),
              ),
              SizedBox(height: size.height * 0.04),
              // Title
              Center(
                child: Text(
                  AppStrings.otpVerification,
                  style: TextStyle(
                    fontSize: size.width * 0.065,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.015),
              // Subtitle
              Center(
                child: Text(
                  AppStrings.otpSubtitle,
                  style: TextStyle(
                    fontSize: size.width * 0.036,
                    color: AppColors.greyText,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: size.height * 0.05),
              Center(
                child: Pinput(
                  controller: controller.pinController,
                  length: 4,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  submittedPinTheme: submittedPinTheme,
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  showCursor: true,
                  onCompleted: (pin) => controller.verifyOtp(),
                ),
              ),
              SizedBox(height: size.height * 0.06),
              // VERIFY Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryTeal,
                  minimumSize: Size(double.infinity, size.height * 0.065),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: controller.verifyOtp,
                child: Text(
                  AppStrings.verify,
                  style: TextStyle(
                    fontSize: size.width * 0.045,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
