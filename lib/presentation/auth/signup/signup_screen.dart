import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import 'signup_controller.dart';

class SignupScreen extends GetView<SignupController> {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignupController());
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
                    children: [
                      // Back Button
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.primaryTeal.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.chevron_left, color: AppColors.primaryTeal),
                            onPressed: () => Get.back(),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      // Title
                      Text(
                        AppStrings.createAccount,
                        style: TextStyle(
                          fontSize: size.width * 0.065,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                      SizedBox(height: size.height * 0.005),
                      Text(
                        AppStrings.signUpSubtitle,
                        style: TextStyle(
                          fontSize: size.width * 0.038,
                          color: AppColors.greyText,
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      // Email Field
                      TextField(
                        controller: controller.emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email_outlined, color: AppColors.greyText),
                          hintText: AppStrings.emailHint,
                          hintStyle: const TextStyle(color: AppColors.greyText),
                          filled: true,
                          fillColor: AppColors.lightGrey,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      // Password Field
                      Obx(() => TextField(
                            controller: controller.passwordController,
                            obscureText: controller.obscurePassword.value,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock_outline, color: AppColors.greyText),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  controller.obscurePassword.value
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: AppColors.greyText,
                                ),
                                onPressed: controller.togglePasswordVisibility,
                              ),
                              hintText: AppStrings.passwordHint,
                              hintStyle: const TextStyle(color: AppColors.greyText),
                              filled: true,
                              fillColor: AppColors.lightGrey,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          )),
                      SizedBox(height: size.height * 0.02),
                      // Repeat Password Field
                      Obx(() => TextField(
                            controller: controller.confirmPasswordController,
                            obscureText: controller.obscureConfirmPassword.value,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock_outline, color: AppColors.greyText),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  controller.obscureConfirmPassword.value
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: AppColors.greyText,
                                ),
                                onPressed: controller.toggleConfirmPasswordVisibility,
                              ),
                              hintText: AppStrings.repeatPasswordHint,
                              hintStyle: const TextStyle(color: AppColors.greyText),
                              filled: true,
                              fillColor: AppColors.lightGrey,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          )),
                      SizedBox(height: size.height * 0.02),
                      // Mobile Number Field
                      TextField(
                        controller: controller.mobileController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          prefixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(width: 12),
                              const Text('🇦🇴', style: TextStyle(fontSize: 20)),
                              const SizedBox(width: 6),
                              const Text('+244', style: TextStyle(color: AppColors.black, fontWeight: FontWeight.w500)),
                              const Icon(Icons.keyboard_arrow_down, color: AppColors.greyText),
                              const SizedBox(width: 8),
                            ],
                          ),
                          hintText: AppStrings.mobileHint,
                          hintStyle: const TextStyle(color: AppColors.greyText),
                          filled: true,
                          fillColor: AppColors.lightGrey,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      // NEXT Button (Matching Login button style)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryTeal,
                          minimumSize: Size(double.infinity, size.height * 0.065),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        onPressed: controller.next,
                        child: Text(
                          AppStrings.next,
                          style: TextStyle(
                            fontSize: size.width * 0.045,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.025),
                      // Or Continue With
                      Text(
                        AppStrings.orContinueWith,
                        style: TextStyle(fontSize: size.width * 0.038, color: AppColors.greyText),
                      ),
                      SizedBox(height: size.height * 0.02),
                      // Social Login Buttons (Apple, Google, Facebook using SVGs)
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
                              onPressed: () => controller.socialLogin('Apple'),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset('assets/images/apple.svg', height: 20),
                                  const SizedBox(width: 6),
                                  Text('Apple', style: TextStyle(color: AppColors.black, fontSize: size.width * 0.035)),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: size.width * 0.03),
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
                                  SvgPicture.asset('assets/images/google.svg', height: 20),
                                  const SizedBox(width: 6),
                                  Text('Google', style: TextStyle(color: AppColors.black, fontSize: size.width * 0.035)),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: size.width * 0.03),
                          Expanded(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: size.height * 0.015),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                side: const BorderSide(color: AppColors.lightGrey),
                              ),
                              onPressed: () => controller.socialLogin('Facebook'),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.facebook, color: Colors.blue, size: 20),
                                  const SizedBox(width: 6),
                                  Text('Facebook', style: TextStyle(color: AppColors.black, fontSize: size.width * 0.032)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.02),
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
