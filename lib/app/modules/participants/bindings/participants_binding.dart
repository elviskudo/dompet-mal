import 'package:get/get.dart';

import '../controllers/participants_controller.dart';

class ParticipantsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ParticipantsController>(
      () => ParticipantsController(),
    );
  }
}
