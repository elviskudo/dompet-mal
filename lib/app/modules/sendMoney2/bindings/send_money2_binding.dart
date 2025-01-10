import 'package:get/get.dart';

import '../controllers/send_money2_controller.dart';

class SendMoney2Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SendMoney2Controller>(
      () => SendMoney2Controller(),
    );
  }
}
