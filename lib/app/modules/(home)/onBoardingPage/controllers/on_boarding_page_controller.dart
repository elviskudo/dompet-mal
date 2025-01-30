import 'package:dompet_mal/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';

class OnBoardingPageController extends GetxController {
  static const String ONBOARDING_SHOWN_KEY = 'onboarding_shown';

  final CarouselSliderController carouselController =
      CarouselSliderController();
  final currentSlide = 0.obs;

  // Slide data
  final List<Map<String, String>> slides = [
    {
      "image": "https://picsum.photos/id/237/400/600",
      "title": "Exercitation veniam consequat sunt nostrud",
      "description":
          "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat"
    },
    {
      "image": "https://picsum.photos/id/238/400/600",
      "title": "Slide 2 Title",
      "description": "Description for slide 2"
    },
    {
      "image": "https://picsum.photos/id/239/400/600",
      "title": "Slide 3 Title",
      "description": "Description for slide 3"
    },
  ];

  @override
  void onInit() {
    super.onInit();
    checkOnboardingStatus();
  }

  void checkOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    bool hasSeenOnboarding = prefs.getBool(ONBOARDING_SHOWN_KEY) ?? false;

    if (hasSeenOnboarding) {
      Get.offAllNamed(Routes.LOGIN);
    }
  }

  void onPageChanged(int index, CarouselPageChangedReason reason) {
    currentSlide.value = index;
  }

  void navigateToLogin() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(ONBOARDING_SHOWN_KEY, true); // Mark onboarding as shown
    Get.offAllNamed(Routes.LOGIN);
  }

  void navigateToRegister() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(ONBOARDING_SHOWN_KEY, true); // Mark onboarding as shown
    Get.offAllNamed(Routes.REGISTER);
  }

  void loginWithGoogle() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(ONBOARDING_SHOWN_KEY, true); // Mark onboarding as shown
    // Implement Google login logic here
    Get.offAllNamed(Routes.LOGIN);
  }

  @override
  void onClose() {
    super.onClose();
  }
}
