import 'package:dompet_mal/app/routes/app_pages.dart';
import 'package:get/get.dart';

class PaymentSuccessController extends GetxController {
  //TODO: Implement PaymentSuccessController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(seconds: 10), () {
      Get.toNamed(Routes.HOME);
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
