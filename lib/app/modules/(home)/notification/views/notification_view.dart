import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:dompet_mal/app/routes/app_pages.dart';
import '../controllers/notification_controller.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifikasi',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.toNamed(Routes.NAVIGATION),
        ),
      ),
      body: GetBuilder<NotificationController>(
        init: NotificationController(),
        builder: (controller) {
          // Sorting months in chronological order
          List<String> sortedMonths =
              controller.notificationsByMonth.keys.toList()
                ..sort((a, b) {
                  DateTime dateA = DateFormat('MMMM yyyy').parse(a);
                  DateTime dateB = DateFormat('MMMM yyyy').parse(b);
                  return dateB.compareTo(dateA); // Diubah menjadi descending
                });

          return ListView.builder(
            itemCount: sortedMonths.length,
            itemBuilder: (context, index) {
              String monthYear = sortedMonths[index];
              List<Map<String, dynamic>> monthNotifications =
                  controller.notificationsByMonth[monthYear]!;

              // Mengurutkan notifikasi berdasarkan created_at secara descending
              monthNotifications.sort((a, b) {
                DateTime dateA = DateTime.parse(a['created_at']);
                DateTime dateB = DateTime.parse(b['created_at']);
                return dateB.compareTo(dateA);
              });

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Display month and year header
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: Text(
                      monthYear,
                      style: GoogleFonts.openSans(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  // Display notifications for this month
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: monthNotifications.length,
                    itemBuilder: (context, notificationIndex) {
                      final notification =
                          monthNotifications[notificationIndex];
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.green.shade100,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.attach_money,
                                  color: Colors.green,
                                  size: 30,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      notification['title'],
                                      style: GoogleFonts.openSans(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      NumberFormat.currency(
                                        locale: 'id',
                                        symbol: 'Rp ',
                                        decimalDigits: 0,
                                      ).format(notification['amount']),
                                      style: GoogleFonts.openSans(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      notification['created_at'],
                                      style: GoogleFonts.openSans(
                                        fontSize: 12,
                                        color: Colors.grey.shade500,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
