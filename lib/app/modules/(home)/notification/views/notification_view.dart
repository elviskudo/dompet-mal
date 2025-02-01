import 'package:dompet_mal/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../../models/notification.dart';
import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadNotifications();
    });
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Notifikasi',
          style: GoogleFonts.poppins(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.toNamed(Routes.NAVIGATION),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.notifications.isEmpty) {
          return Center(
            child: Text(
              'Tidak ada notifikasi',
              style: GoogleFonts.poppins(),
            ),
          );
        }

        // Group notifications by month
        final groupedNotifications = controller.groupedNotifications;

        return ListView.builder(
          itemCount: groupedNotifications.length,
          itemBuilder: (context, index) {
            final monthYear = groupedNotifications.keys.elementAt(index);
            final notifications = groupedNotifications[monthYear]!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    monthYear,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                ...notifications
                    .map(
                      (notification) => Dismissible(
                        key: Key(notification.id ?? ''),
                        background: Container(
                          // color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        secondaryBackground: Container(
                          // color: Colors.red,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 20),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        onDismissed: (direction) {
                          controller.deleteNotification(notification);
                        },
                        child: NotificationCard(notification: notification),
                      ),
                    )
                    .toList(),
              ],
            );
          },
        );
      }),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final NotificationModels notification;

  const NotificationCard({
    Key? key,
    required this.notification,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(
          notification.title ?? '',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notification.body ?? '',
              style: GoogleFonts.poppins(),
            ),
            const SizedBox(height: 4),
            Text(
              notification.createdAt != null
                  ? DateFormat('dd MMM yyyy, HH:mm')
                      .format(notification.createdAt!)
                  : '',
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
