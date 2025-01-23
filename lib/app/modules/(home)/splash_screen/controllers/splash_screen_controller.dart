import 'package:dompet_mal/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  void _navigateToOnboarding() async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      print("Attempting to navigate to onboarding"); // Debug print
      await Get.offAllNamed(
          Routes.ON_BOARDING_PAGE); // Tambahkan await dan slash di depan
      print("Navigation completed"); // Debug print
    } catch (e) {
      print("Navigation error: $e"); // Debug print untuk error
    }
  }

  @override
  void onInit() {
    super.onInit();
    print("SplashScreenController initialized");
    _navigateToOnboarding();
  }
}
