import 'package:get/get.dart';

import '../controllers/forgotpass_verification_controller.dart';

class ForgotpassVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotpassVerificationController>(
      () => ForgotpassVerificationController(),
    );
  }
}
