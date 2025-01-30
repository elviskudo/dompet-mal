import 'package:get/get.dart';

import '../controllers/donation_detail_page_controller.dart';

class DonationDetailPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DonationDetailPageController>(
      () => DonationDetailPageController(),
    );
  }
}
