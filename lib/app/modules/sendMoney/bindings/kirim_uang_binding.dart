import 'package:get/get.dart';

import '../controllers/kirim_uang_controller.dart';

class KirimUangBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KirimUangController>(
      () => KirimUangController(),
    );
  }
}
