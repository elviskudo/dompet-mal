import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/on_boarding_page_controller.dart';

class OnboardingPageView extends GetView<OnBoardingPageController> {
  const OnboardingPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background carousel
          CarouselSlider(
            carouselController: controller.carouselController,
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height,
              viewportFraction: 1.0,
              onPageChanged: controller.onPageChanged,
            ),
            items: controller.slides.map((slide) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(slide["image"]!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),

          // Logo
          Positioned(
            top: 50,
            left: 16,
            child: Image.asset(
              'assets/images/splash.png',
              height: 32,
            ),
          ),

          // Content section
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(24.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(() => Text(
                        controller.slides[controller.currentSlide.value]["title"]!,
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      )),
                  const SizedBox(height: 8),
                  Obx(() => Text(
                        controller.slides[controller.currentSlide.value]["description"]!,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      )),
                  const SizedBox(height: 16),
                  Obx(() => DotsIndicator(
                        dotsCount: controller.slides.length,
                        position: controller.currentSlide.value,
                        decorator: const DotsDecorator(
                          activeColor: Color(0xff4B76D9),
                          size: Size(8.0, 8.0),
                          activeSize: Size(8.0, 8.0),
                        ),
                      )),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 55,
                    child: ElevatedButton(
                      onPressed: controller.navigateToLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff4B76D9),
                        minimumSize: const Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Masuk dengan ID Email',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 55,
                    child: OutlinedButton.icon(
                      onPressed: controller.loginWithGoogle,
                      icon: Image.asset(
                        'assets/images/google.png',
                        height: 24,
                      ),
                      label: Text(
                        'Masuk dengan akun Google',
                        style: GoogleFonts.poppins(
                          color: const Color(0xff313036),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Belum punya akun?',
                          style: GoogleFonts.poppins(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                        TextButton(
                          onPressed: controller.navigateToRegister,
                          child: Text(
                            'DAFTAR',
                            style: GoogleFonts.poppins(
                              color: const Color(0xff4B76D9),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}