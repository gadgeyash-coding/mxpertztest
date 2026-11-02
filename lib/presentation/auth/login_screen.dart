import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import 'login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.08,
                    vertical: size.height * 0.02,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          // Top close button
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              icon: const Icon(Icons.close, color: AppColors.black),
                              onPressed: () => Get.back(),
                            ),
                          ),
                          SizedBox(height: size.height * 0.02),
                          SvgPicture.asset(
                            'assets/images/logo.svg',
                            height: size.height * 0.08,
                            placeholderBuilder: (context) => Text(
                              AppStrings.appName,
                              style: TextStyle(
                                fontSize: size.width * 0.05,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryTeal,
                              ),
                            ),
                          ),
                          SizedBox(height: size.height * 0.06),
                          // Welcome Back Text
                          Text(
                            AppStrings.welcomeBack,
                            style: TextStyle(
                              fontSize: size.width * 0.065,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                            ),
                          ),
                          SizedBox(height: size.height * 0.01),
                          Text(
                            AppStrings.loginToContinue,
                            style: TextStyle(
                              fontSize: size.width * 0.038,
                              color: AppColors.greyText,
                            ),
                          ),
                          SizedBox(height: size.height * 0.04),
                          TextField(
                            controller: controller.phoneController,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10),
                            ],
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.phone_android, color: AppColors.greyText),
                              hintText: AppStrings.phoneHint,
                              hintStyle: const TextStyle(color: AppColors.greyText),
                              filled: true,
                              fillColor: AppColors.lightGrey,
                              counterText: '',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          SizedBox(height: size.height * 0.03),
                          // GET OTP Button
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryTeal,
                              minimumSize: Size(double.infinity, size.height * 0.065),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            onPressed: controller.getOtp,
                            child: Text(
                              AppStrings.getOtp,
                              style: TextStyle(
                                fontSize: size.width * 0.045,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(height: size.height * 0.03),
                          // Or Continue With
                          Text(
                            AppStrings.orContinueWith,
                            style: TextStyle(fontSize: size.width * 0.038, color: AppColors.greyText),
                          ),
                          SizedBox(height: size.height * 0.02),
                          // Social Login Buttons (Google, Facebook)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(vertical: size.height * 0.015),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    side: const BorderSide(color: AppColors.lightGrey),
                                  ),
                                  onPressed: () => controller.socialLogin('Google'),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset('assets/images/google.svg', height: 22),
                                      const SizedBox(width: 8),
                                      Text('Google', style: TextStyle(color: AppColors.black, fontSize: size.width * 0.038)),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: size.width * 0.04),
                              Expanded(
                                child: OutlinedButton.icon(
                                  style: OutlinedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(vertical: size.height * 0.015),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    side: const BorderSide(color: AppColors.lightGrey),
                                  ),
                                  onPressed: () => controller.socialLogin('Facebook'),
                                  icon: const Icon(Icons.facebook, size: 24, color: Colors.blue),
                                  label: Text('Facebook', style: TextStyle(color: AppColors.black, fontSize: size.width * 0.038)),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * 0.03),
                          // Don't have an account? Sign Up
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppStrings.noAccount,
                                style: TextStyle(color: AppColors.greyText, fontSize: size.width * 0.038),
                              ),
                              GestureDetector(
                                onTap: controller.signUp,
                                child: Text(
                                  AppStrings.signUp,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryTeal,
                                    fontSize: size.width * 0.038,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * 0.02),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
