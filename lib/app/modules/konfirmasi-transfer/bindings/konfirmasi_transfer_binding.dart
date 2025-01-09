import 'package:get/get.dart';

import '../controllers/konfirmasi_transfer_controller.dart';

class KonfirmasiTransferBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KonfirmasiTransferController>(
      () => KonfirmasiTransferController(),
    );
  }
}
