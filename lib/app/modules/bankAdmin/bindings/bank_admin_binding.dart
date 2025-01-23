import 'package:get/get.dart';

import '../controllers/bank_admin_controller.dart';

class BankAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BankAdminController>(
      () => BankAdminController(),
    );
  }
}
