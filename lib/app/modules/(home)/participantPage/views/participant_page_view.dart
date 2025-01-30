import 'package:dompet_mal/app/modules/(home)/participantPage/controllers/participant_page_controller.dart';
import 'package:dompet_mal/models/TransactionModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ParticipantPage extends StatelessWidget {
  final controller = Get.put(ParticipantPageController());

  String formatRupiah(num value) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatter.format(value);
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = Get.arguments ?? {};
    final String charityId = args['charityId'] ?? '';

    // Fetch data when the page loads
    controller.fetchTransactions(charityId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Partisipan', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.transactions.isEmpty) {
          return Center(child: Text('Belum ada transaksi'));
        }

        return ListView.builder(
          itemCount: controller.transactions.length,
          padding: EdgeInsets.all(16.0),
          itemBuilder: (context, index) {
            final data = controller.transactions[index];
            final transaction = data['transaction'] as Transaction;
            final user = data['user'] as Map<String, dynamic>;

            return Container(
              margin: EdgeInsets.only(bottom: 16.0),
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 6.0,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(user['image_url']),
                    onBackgroundImageError: (_, __) {
                      // Handle error loading image
                      Icon(Icons.person);
                    },
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user['name'],
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Donasi: ${formatRupiah(transaction.donationPrice ?? 0)}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          DateFormat('dd MMMM yyyy HH:mm', 'id_ID').format(
                            transaction.createdAt ?? DateTime.now(),
                          ),
                          style: TextStyle(color: Colors.grey, fontSize: 12.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
      backgroundColor: Colors.grey.shade100,
    );
  }
}
