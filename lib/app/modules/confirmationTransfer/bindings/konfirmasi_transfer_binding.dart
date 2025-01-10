import 'package:get/get.dart';

import '../controllers/konfirmasi_transfer_controller.dart';

class ConfirmationTransferBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConfirmationTransferController>(
      () => ConfirmationTransferController(),
    );
  }
}
