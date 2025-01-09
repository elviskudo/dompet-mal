import 'package:get/get.dart';

import '../controllers/on_boarding_page_controller.dart';

class OnBoardingPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnBoardingPageController>(
      () => OnBoardingPageController(),
    );
  }
}
