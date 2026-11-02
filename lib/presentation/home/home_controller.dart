import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeController extends GetxController {
  var currentBottomNavIndex = 0.obs;
  var selectedTab = 'Cell Phone'.obs;

  var tabs = <String>[
    'Recommend',
    'Cell Phone',
    'Car Products',
    'Department Store',
  ].obs;

  var categories = <Map<String, dynamic>>[
    {'title': 'Beauty', 'icon': Icons.brush},
    {'title': 'Offers', 'icon': Icons.local_offer},
    {'title': 'Fashion', 'icon': Icons.checkroom},
    {'title': 'Home', 'icon': Icons.home},
    {'title': 'Shirt', 'icon': Icons.dry_cleaning},
    {'title': 'Woman Bag', 'icon': Icons.shopping_bag},
    {'title': 'Dress', 'icon': Icons.woman},
    {'title': 'Mobiles', 'icon': Icons.phone_android},
  ].obs;

  var products = <Map<String, dynamic>>[
    {
      'title': 'Multi Kit',
      'price': '\$500',
      'rating': '4.6',
      'reviews': '56 Reviews',
    },
    {
      'title': 'Lipstick',
      'price': '\$400',
      'rating': '4.6',
      'reviews': '56 Reviews',
    },
  ].obs;

  @override
  void onInit() {
    super.onInit();
    fetchHomeData();
  }

  void fetchHomeData() async {
    try {
      var tabsSnapshot = await FirebaseFirestore.instance.collection('tabs').get();
      if (tabsSnapshot.docs.isNotEmpty) {
        tabs.value = tabsSnapshot.docs.map((doc) => doc['name'].toString()).toList();
      }

      var catSnapshot = await FirebaseFirestore.instance.collection('categories').get();
      if (catSnapshot.docs.isNotEmpty) {
        categories.value = catSnapshot.docs.map((doc) => {
          'title': doc['title'] ?? '',
          'icon': Icons.category,
        }).toList();
      }

      var prodSnapshot = await FirebaseFirestore.instance.collection('products').get();
      if (prodSnapshot.docs.isNotEmpty) {
        products.value = prodSnapshot.docs.map((doc) => {
          'title': doc['title'] ?? '',
          'price': doc['price'] ?? '',
          'rating': doc['rating'] ?? '4.6',
          'reviews': doc['reviews'] ?? '56 Reviews',
        }).toList();
      }
    } catch (e) {
      debugPrint('Error fetching data from Firestore: $e');
    }
  }

  void changeTab(String tab) {
    selectedTab.value = tab;
  }

  void changeBottomNav(int index) {
    currentBottomNavIndex.value = index;
  }

  void addToCart(String productName) {
    Get.snackbar(
      'Added to Cart',
      '$productName added successfully!',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
