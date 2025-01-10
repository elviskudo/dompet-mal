import 'package:get/get.dart';

import '../controllers/list_donasi_controller.dart';

class ListDonasiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListDonasiController>(
      () => ListDonasiController(),
    );
  }
}
