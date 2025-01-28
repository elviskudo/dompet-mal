import 'package:dompet_mal/app/modules/(admin)/bankAdmin/controllers/bank_admin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

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
              Text(
                'Kirim Donasi',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
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
                Text(
                  'Pilih Rekening Pembayaran',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 24),
                // Menggunakan Obx untuk mendengarkan perubahan data
                Obx(() {
                  // Menunggu hingga data bank ter-load
                  if (controller.bankList.isEmpty) {
                    return const PaymentAccountShimmerLoader();
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
                                account.image! ??
                                    'https://via.placeholder.com/150',
                                fit: BoxFit.cover,
                                width: 60,
                                height: 42,
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
                                    account.name ?? 'No Name', // Nama bank
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.55,
                                    child: Text(
                                      account.accountNumber ??
                                          'No Account Number',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: GoogleFonts.poppins(),
                                    ),
                                  ), // Nomor rekening
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

class PaymentAccountShimmerLoader extends StatelessWidget {
  final int itemCount;

  const PaymentAccountShimmerLoader({Key? key, this.itemCount = 3})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(itemCount, (index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(16),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Row(
              children: [
                // Bank logo placeholder
                Container(
                  width: 60,
                  height: 42,
                  color: Colors.white,
                ),
                const SizedBox(width: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Bank name placeholder
                    Container(
                      width: 150,
                      height: 20,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 8),
                    // Account number placeholder
                    Container(
                      width: 200,
                      height: 15,
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
