import 'package:dompet_mal/app/modules/(admin)/bankAdmin/controllers/bank_admin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentAccountPageView extends GetView<BankAdminController> {
  const PaymentAccountPageView({super.key});

  @override
  Widget build(BuildContext context) {
    // Inisialisasi controller untuk BankAdminController
    final controller = Get.put(BankAdminController());

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: const Color(0xff4B76D9),
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
                // Menggunakan Obx untuk mendengarkan perubahan data
                Obx(() {
                  // Menunggu hingga data bank ter-load
                  if (controller.bankList.isEmpty) {
                    return const CircularProgressIndicator();
                  }

                  // Menampilkan list bank
                  return Column(
                    children: controller.bankList.map((account) {
                      return GestureDetector(
                        onTap: () {
                          controller.selectBankAccount(
                              account); // Fungsi untuk memilih rekening bank
                        },
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
                              Image.network(
                                account.image ??
                                    'https://via.placeholder.com/150',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey[300],
                                    child: const Icon(Icons.image, size: 50),
                                  );
                                },
                              ), // Pastikan ada image yang valid
                              const SizedBox(width: 24),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.username.value ??
                                        'No Name', // Nama bank
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(account.accountNumber ??
                                      'No Account Number'), // Nomor rekening
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
