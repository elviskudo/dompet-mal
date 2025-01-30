import 'package:dompet_mal/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static const String ONBOARDING_SHOWN_KEY = 'onboarding_shown';
  late AnimationController animationController;
  late Animation<double> scaleAnimation;
  @override
  void onInit() {
    super.onInit();
    // Inisialisasi AnimationController
    animationController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync:
          this, // Sekarang 'this' valid karena controller memiliki mixin TickerProvider
    );

    // Setup animation
    scaleAnimation = Tween<double>(begin: 0.8, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.elasticOut,
      ),
    );

    // Jalankan animasi
    animationController.forward();
    checkFirstTime();
  }

  void checkFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    bool hasSeenOnboarding = prefs.getBool(ONBOARDING_SHOWN_KEY) ?? false;

    // Wait for 2 seconds to show splash screen
    await Future.delayed(const Duration(seconds: 2));

    if (!hasSeenOnboarding) {
      // If first time, go to onboarding
      Get.offAllNamed('/on-boarding-page');
    } else {
      // Check login status from SharedPreferences
      bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      String? userRole = prefs.getString('userRole');

      if (isLoggedIn) {
        // If user is logged in, check their role and redirect accordingly
        if (userRole == 'admin') {
          Get.offAllNamed(Routes.ADMIN_PANEL);
        } else {
          Get.offAllNamed(Routes.NAVIGATION);
        }
      } else {
        Get.offAllNamed('/login');
      }
    }
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
