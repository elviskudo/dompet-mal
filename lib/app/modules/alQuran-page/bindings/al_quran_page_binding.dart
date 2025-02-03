import 'package:get/get.dart';

import '../controllers/al_quran_page_controller.dart';

class AlQuranPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AlQuranPageController>(
      () => AlQuranPageController(),
    );
  }
}
