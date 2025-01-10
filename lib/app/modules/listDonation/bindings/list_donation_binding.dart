import 'package:get/get.dart';

import '../controllers/list_donasi_controller.dart';

class ListDonationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListDonationController>(
      () => ListDonationController(),
    );
  }
}
