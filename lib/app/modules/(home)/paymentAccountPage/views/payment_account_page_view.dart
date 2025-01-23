import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/payment_account_page_controller.dart';

class PaymentAccountPageView extends GetView<PaymentAccountPageController> {
  const PaymentAccountPageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: const Color(0xff4B76D9),
        // leading:
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          alignment: Alignment.bottomLeft,
          padding: const EdgeInsets.only(left: 20, bottom: 16),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Get.back(),
              ),
              // SizedBox(
              //   width: 16,
              // ),
              const Text(
                'Kirim Donasi',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Pilih Rekening Pembayaran',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                Obx(() => Column(
                      children: controller.bankAccounts
                          .map((account) => GestureDetector(
                                onTap: () =>
                                    controller.selectBankAccount(account),
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 16),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.all(16),
                                  child: Row(
                                    children: [
                                      Image.asset('assets/images/mandiri.png'),
                                      const SizedBox(width: 24),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            account.accountName,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(account.accountNumber),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ))
                          .toList(),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
