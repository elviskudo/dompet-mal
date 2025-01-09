import 'package:dompet_mal/app/modules/onBoardingPage/views/on_boarding_page_view.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  //TODO: Implement SplashScreenController
  void _navigateToOnboarding() async {
    await Future.delayed(const Duration(seconds: 2));
    Get.offAllNamed("on-boarding-page"); // Menggunakan offAll agar tidak bisa kembali ke splash
  }

 @override
void onInit() {
  super.onInit();
  print("SplashScreenController initialized");
  _navigateToOnboarding();
}


  final count = 0.obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
