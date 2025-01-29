import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(SplashScreenController());
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: CurvedAnimation(
            parent: controller.animationController,
            curve: Curves.elasticOut
          ),
          builder: (context, child) {
            return Transform.scale(
              scale: controller.scaleAnimation.value,
              child: Container(
                width: 155,
                height: 65,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/splash.png")
                  )
                ),
              ),
            );
          },
        ),
      )
    );
  }
}