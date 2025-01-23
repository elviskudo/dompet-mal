import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:get/get.dart';

class OnboardingPageView extends StatefulWidget {
  const OnboardingPageView({Key? key}) : super(key: key);

  @override
  State<OnboardingPageView> createState() => _OnboardingPageViewState();
}

class _OnboardingPageViewState extends State<OnboardingPageView> {
  final CarouselSliderController carouselController =
      CarouselSliderController();
  int currentSlide = 0;

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

  void _navigateToLogin() {
    Get.toNamed('/login');
  }

  void _navigateToRegister() {
    Get.toNamed('/register');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background carousel
          CarouselSlider(
            carouselController: carouselController,
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height,
              viewportFraction: 1.0,
              onPageChanged: (index, reason) {
                setState(() {
                  currentSlide = index;
                });
              },
            ),
            items: slides.map((slide) {
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
              'images/splash.png',
              height: 32,
              // color: Colors.white, // Logo menjadi putih agar kontras
            ),
          ),

          // Content section
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    slides[currentSlide]["title"]!,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    slides[currentSlide]["description"]!,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  DotsIndicator(
                    dotsCount: slides.length,
                    position: currentSlide,
                    decorator: const DotsDecorator(
                      activeColor: Color(0xff4B76D9),
                      size: Size(8.0, 8.0),
                      activeSize: Size(8.0, 8.0),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    height: 55,
                    child: ElevatedButton(
                      onPressed: _navigateToLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff4B76D9),
                        minimumSize: const Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Masuk dengan ID Email',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 55,
                    child: OutlinedButton.icon(
                      onPressed: _navigateToLogin,
                      icon: Image.asset(
                        'images/google.png',
                        height: 24,
                      ),
                      label: const Text('Masuk dengan akun Google', style: TextStyle(
                        color: Color(0xff313036),
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                      ),),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Belum punya akun?', style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                          fontSize: 14
                        ),),
                        TextButton(
                          onPressed: _navigateToRegister,
                          child: const Text(
                            'DAFTAR',
                            style: TextStyle(
                              color: Color(0xff4B76D9),
                              fontWeight: FontWeight.bold,
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
