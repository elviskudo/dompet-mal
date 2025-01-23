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
      child: Container(
        width: 155,
        height: 65,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("images/splash.png"))),
      
      ),
    ));
  }
}
