import 'package:dompet_mal/app/modules/(admin)/charityAdmin/controllers/charity_admin_controller.dart';
import 'package:get/get.dart';

import '../controllers/on_boarding_page_controller.dart';

class OnBoardingPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnBoardingPageController>(
      () => OnBoardingPageController(),
    );
    Get.lazyPut<CharityAdminController>(
      () => CharityAdminController(),
    );
  }
}
