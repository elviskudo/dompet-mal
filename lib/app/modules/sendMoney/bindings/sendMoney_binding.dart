import 'package:dompet_mal/app/modules/sendMoney/controllers/sendMoney_controller.dart';
import 'package:get/get.dart';


class SendMoneyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SendMoneyController>(
      () => SendMoneyController(),
    );
  }
}
