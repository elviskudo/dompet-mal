import 'package:dompet_mal/app/modules/(home)/listDonation/controllers/list_donation_controller.dart';
import 'package:get/get.dart';


class ListDonationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListDonationController>(
      () => ListDonationController(),
    );
  }
}
