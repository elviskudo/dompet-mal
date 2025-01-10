import 'package:get/get.dart';

import '../controllers/participant_page_controller.dart';

class ParticipantPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ParticipantPageController>(
      () => ParticipantPageController(),
    );
  }
}
