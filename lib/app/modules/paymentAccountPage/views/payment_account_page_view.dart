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
        // leading: const Icon(
        //   Icons.arrow_back,
        //   color: Colors.white,
        // ),
        flexibleSpace: Container(
          alignment: Alignment.bottomLeft,
          padding: const EdgeInsets.only(left: 16, bottom: 16),
          child: Row(
            children: [
              const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              const SizedBox(width: 8), // Space between icon and text
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
          Container(
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
                Container(
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
                      Image.asset('images/mandiri.png'), // Replace with your image path
                      const SizedBox(width: 24),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'ELVIS SONATHA',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text('1670003807988'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
