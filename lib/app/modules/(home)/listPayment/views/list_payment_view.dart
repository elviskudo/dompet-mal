import 'package:dompet_mal/app/modules/(admin)/transactions/controllers/transactions_controller.dart';
import 'package:dompet_mal/models/BankModel.dart';
import 'package:dompet_mal/models/TransactionModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ListPaymentView extends GetView<TransactionsController> {
  ListPaymentView({super.key}) {
    Get.put(TransactionsController());
  }

  String formatToRupiah(double? amount) {
    if (amount == null) return 'Rp 0';
    final formatCurrency = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatCurrency.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    print('userid :${controller.userId}');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'List Pembayaran',
          style: GoogleFonts.poppins(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Obx(() {
        // Filter transaksi berdasarkan userId
        final userTransactions = controller.transactions
            .where((transaction) =>
                transaction.userId == controller.userId.value &&
                transaction.status == 3)
            .toList();

        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (userTransactions.isEmpty) {
          return const Center(child: Text("Tidak ada transaksi."));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: userTransactions.length,
          itemBuilder: (context, index) {
            final Transaction transaction = userTransactions[index];
            final Bank bank = controller.banks.firstWhere(
              (b) => b.id == transaction.bankId,
              orElse: () => Bank(id: '', name: 'Unknown Bank'),
            );

            return Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ID Transaksi: ${transaction.transactionNumber ?? 'Tidak ada ID'}',
                      style: GoogleFonts.openSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Bank: ${bank.name}',
                      style: GoogleFonts.openSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      formatToRupiah(transaction.donationPrice),
                      style: GoogleFonts.openSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      DateFormat('d MMMM yyyy', 'id_ID')
                          .format(transaction.updatedAt ?? DateTime.now()),
                      style: GoogleFonts.openSans(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
