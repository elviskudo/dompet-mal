import 'package:get/get.dart';

import '../controllers/list_payment_controller.dart';

class ListPaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListPaymentController>(
      () => ListPaymentController(),
    );
  }
}
