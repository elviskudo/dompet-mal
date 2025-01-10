import 'package:get/get.dart';

import '../controllers/kirim_uang_controller.dart';

class SendMoneyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SendMoneyController>(
      () => SendMoneyController(),
    );
  }
}
