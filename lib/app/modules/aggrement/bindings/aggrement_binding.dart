import 'package:get/get.dart';

import '../controllers/aggrement_controller.dart';

class AggrementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AggrementController>(
      () => AggrementController(),
    );
  }
}
