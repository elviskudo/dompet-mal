import 'package:get/get.dart';

import '../controllers/my_donation_controller.dart';

class MyDonationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyDonationController>(
      () => MyDonationController(),
    );
  }
}
