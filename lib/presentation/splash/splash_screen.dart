import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';
import 'splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.1),
          child: SvgPicture.asset(
            'assets/images/logo.svg',
            width: size.width * 0.25,
            height: size.width * 0.25,
            placeholderBuilder: (context) => FlutterLogo(size: size.width * 0.3),
          ),
        ),
      ),
    );
  }
}