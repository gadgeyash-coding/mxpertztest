import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import 'home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: AppColors.black),
          onPressed: () {},
        ),
        title: SvgPicture.asset(
          'assets/images/logo.svg',
          height: 24,
          placeholderBuilder: (context) => const Text(
            AppStrings.appName,
            style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryTeal),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'assets/images/Search.svg',
              height: 22,
              colorFilter: const ColorFilter.mode(AppColors.black, BlendMode.srcIn),
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: SvgPicture.asset(
              'assets/images/scanner.svg',
              height: 22,
              colorFilter: const ColorFilter.mode(AppColors.black, BlendMode.srcIn),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.015),
              // Greeting
              const Text(
                AppStrings.greeting,
                style: TextStyle(fontSize: 14, color: AppColors.greyText),
              ),
              const SizedBox(height: 4),
              const Text(
                AppStrings.homeTitle,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              SizedBox(height: size.height * 0.02),
              // Promotional Banner
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SvgPicture.asset(
                  'assets/images/banner.svg',
                  width: double.infinity,
                  height: size.height * 0.22,
                  fit: BoxFit.cover,
                  placeholderBuilder: (context) => Container(
                    height: size.height * 0.22,
                    decoration: BoxDecoration(
                      color: AppColors.accentAmber,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Carousel Indicator Dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(width: 6, height: 6, decoration: BoxDecoration(color: AppColors.greyText.withOpacity(0.4), shape: BoxShape.circle)),
                  const SizedBox(width: 4),
                  Container(width: 16, height: 6, decoration: BoxDecoration(color: AppColors.accentAmber, borderRadius: BorderRadius.circular(3))),
                  const SizedBox(width: 4),
                  Container(width: 6, height: 6, decoration: BoxDecoration(color: AppColors.greyText.withOpacity(0.4), shape: BoxShape.circle)),
                ],
              ),
              SizedBox(height: size.height * 0.02),
              // Tab Bar Filter
              SizedBox(
                height: 36,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.tabs.length,
                  itemBuilder: (context, index) {
                    final tab = controller.tabs[index];
                    return Obx(() {
                      final isSelected = controller.selectedTab.value == tab;
                      return GestureDetector(
                        onTap: () => controller.changeTab(tab),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tab,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                  color: isSelected ? AppColors.black : AppColors.greyText,
                                ),
                              ),
                              const Spacer(),
                              if (isSelected)
                                Container(
                                  width: 25,
                                  height: 3,
                                  decoration: BoxDecoration(
                                    color: AppColors.accentAmber,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    });
                  },
                ),
              ),
              SizedBox(height: size.height * 0.02),
              // Categories Header & See More
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox.shrink(),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      AppStrings.seeMore,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.accentAmber,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Category Grid (2 rows x 4 columns)
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.85,
                ),
                itemCount: controller.categories.length,
                itemBuilder: (context, index) {
                  final cat = controller.categories[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.lightGrey),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(cat['icon'] as IconData, color: AppColors.primaryTeal, size: 28),
                        const SizedBox(height: 8),
                        Text(
                          cat['title'] as String,
                          style: const TextStyle(fontSize: 12, color: AppColors.black, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: size.height * 0.03),
              // Product Grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.72,
                ),
                itemCount: controller.products.length,
                itemBuilder: (context, index) {
                  final product = controller.products[index];
                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.lightGrey),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(Icons.favorite_border, size: 18, color: AppColors.greyText),
                          ],
                        ),
                        Expanded(
                          child: Center(
                            child: Icon(Icons.shopping_bag_outlined, size: 54, color: AppColors.primaryTeal.withOpacity(0.5)),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          product['title']!,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.black),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              product['price']!,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.black),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.accentAmber,
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                minimumSize: const Size(55, 30),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () => controller.addToCart(product['title']!),
                              child: const Text(
                                AppStrings.add,
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.white),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.star, size: 14, color: AppColors.accentAmber),
                            const SizedBox(width: 4),
                            Text(
                              product['rating']!,
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              product['reviews']!,
                              style: const TextStyle(fontSize: 10, color: AppColors.greyText),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: size.height * 0.05),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            currentIndex: controller.currentBottomNavIndex.value,
            onTap: controller.changeBottomNav,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColors.accentAmber,
            unselectedItemColor: AppColors.greyText,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: AppStrings.navHome),
              BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: AppStrings.navCategory),
              BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: AppStrings.navMessage),
              BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: AppStrings.navCart),
              BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: AppStrings.navPrivate),
            ],
          )),
    );
  }
}
