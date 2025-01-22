import 'package:get/get.dart';

import '../controllers/charity_admin_controller.dart';

class CharityAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CharityAdminController>(
      () => CharityAdminController(),
    );
  }
}
