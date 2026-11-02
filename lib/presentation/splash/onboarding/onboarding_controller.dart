import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mxpertz_test/core/constants/app_strings.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  var currentIndex = 0.obs;

  final List<Map<String, String>> onboardingData = [
    {
      'title': AppStrings.onboardingTitle1,
      'desc': AppStrings.onboardingDesc,
      'image': 'assets/images/onboard_one.svg',
    },
    {
      'title': AppStrings.onboardingTitle2,
      'desc': AppStrings.onboardingDesc,
      'image': 'assets/images/onboard_two.svg',
      'showAvatar': 'true',
    },
    {
      'title': AppStrings.onboardingTitle3,
      'desc': AppStrings.onboardingDesc,
      'image': 'assets/images/onboard_three.svg',
    },
  ];

  void onPageChanged(int index) {
    currentIndex.value = index;
  }

  void nextPage() {
    if (currentIndex.value < onboardingData.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      navigateToLogin();
    }
  }

  void skip() {
    navigateToLogin();
  }

  void navigateToLogin() {
    Get.offNamed('/login');
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
