import 'package:get/get.dart';

import '../controllers/payment_account_page_controller.dart';

class PaymentAccountPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentAccountPageController>(
      () => PaymentAccountPageController(),
    );
  }
}
