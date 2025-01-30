import 'package:dompet_mal/models/BankAccountModel.dart';
import 'package:get/get.dart';

class PaymentAccountPageController extends GetxController {
  //TODO: Implement PaymentAccountPageController
  final bankAccounts = <BankAccount>[
    BankAccount(
      id: 1,
      uuid: "",
      name: "BANK MANDIRI",
      accountName: "ELVIS SONATHA",
      accountNumber: "1670003807988",
      status: 1,
      createdAt: "",
      updatedAt: "",
    ),
    // Add more bank accounts as needed
  ].obs;

  final selectedBank = Rx<BankAccount?>(null);

  void selectBankAccount(BankAccount account) {
    selectedBank.value = account;
    print('adad${account}');
    print('adad${account.accountName}');
    print('adadadad${selectedBank.value}');
    Get.back(result: account); 
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
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
