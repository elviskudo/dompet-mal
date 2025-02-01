import 'package:dompet_mal/app/modules/(admin)/transactions/controllers/transactions_controller.dart';
import 'package:get/get.dart';

class ConfirmationTransferController extends GetxController {
  //TODO: Implement ConfirmationTransferController
  TransactionsController transactionController =
        Get.put(TransactionsController());

  final count = 0.obs;
  @override
  void onInit() async {
    super.onInit();
    await transactionController.getTransactionsWithNoGrouping();

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
