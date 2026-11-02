import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import 'onboarding_controller.dart';

class OnboardingScreen extends GetView<OnboardingController> {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OnboardingController());
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: AppColors.primaryTeal,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Stack(
                    children: [
                      PageView.builder(
                        controller: controller.pageController,
                        onPageChanged: controller.onPageChanged,
                        itemCount: controller.onboardingData.length,
                        itemBuilder: (context, index) {
                          final data = controller.onboardingData[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.08,
                                vertical: size.height * 0.03),
                            child: Center(
                              child: SvgPicture.asset(
                                data['image']!,
                                height: constraints.maxHeight * 0.38,
                                placeholderBuilder: (context) =>
                                    FlutterLogo(size: size.width * 0.25),
                              ),
                            ),
                          );
                        },
                      ),
                      // Optional avatar badge on Screen 2 (Online Shopping)
                      Obx(() => controller.currentIndex.value == 1
                          ? Positioned(
                              top: size.height * 0.02,
                              left: size.width * 0.08,
                              child: Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.15),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: const Center(
                                  child: Text(
                                    'J',
                                    style: TextStyle(
                                      color: Color(0xFF6A1B9A),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox.shrink()),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.08,
                      vertical: size.height * 0.035,
                    ),
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(36),
                        topRight: Radius.circular(36),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Title and Description
                        Obx(() {
                          final data = controller
                              .onboardingData[controller.currentIndex.value];
                          return Column(
                            children: [
                              Text(
                                data['title']!,
                                style: TextStyle(
                                  fontSize: size.width * 0.05,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.accentAmber,
                                  letterSpacing: 1.2,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: constraints.maxHeight * 0.02),
                              Text(
                                data['desc']!,
                                style: TextStyle(
                                  fontSize: size.width * 0.035,
                                  color: AppColors.greyText,
                                  height: 1.45,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          );
                        }),
                        // Bottom buttons: Skip and Next Arrow with outer ring
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: controller.skip,
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(50, 30),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text(
                                AppStrings.skip,
                                style: TextStyle(
                                  fontSize: size.width * 0.042,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.accentAmber,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.accentAmber.withOpacity(0.35),
                                  width: 1.5,
                                ),
                              ),
                              child: GestureDetector(
                                onTap: controller.nextPage,
                                child: Container(
                                  width: 52,
                                  height: 52,
                                  decoration: const BoxDecoration(
                                    color: AppColors.accentAmber,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.arrow_forward,
                                    color: AppColors.white,
                                    size: 24,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
