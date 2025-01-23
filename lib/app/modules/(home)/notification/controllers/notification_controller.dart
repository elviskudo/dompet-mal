import 'package:get/get.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class NotificationController extends GetxController {
  final notifications = <Map<String, dynamic>>[].obs;

  RxMap<String, List<Map<String, dynamic>>> notificationsByMonth =
      <String, List<Map<String, dynamic>>>{}.obs;

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  void loadNotifications() {
    const jsonData = '''
    [
      {"title": "Pembayaran Sukses", "userAvatar": "images/avatar1.png", "created_at": "2025-01-13", "amount": 100000},
      {"title": "Donasi Diterima", "userAvatar": "images/avatar2.png", "created_at": "2025-01-12", "amount": 150000},
      {"title": "Pembayaran Gagal", "userAvatar": "images/avatar3.png", "created_at": "2025-02-11", "amount": 50000}
    ]
    ''';

    List<Map<String, dynamic>> loadedNotifications =
        List<Map<String, dynamic>>.from(json.decode(jsonData));

    // Sorting notifications by created_at descending
    loadedNotifications.sort((a, b) {
      DateTime dateA = DateTime.parse(a['created_at']);
      DateTime dateB = DateTime.parse(b['created_at']);
      return dateB.compareTo(dateA);
    });

    // Grouping by month and year
    Map<String, List<Map<String, dynamic>>> groupedNotifications = {};
    for (var notification in loadedNotifications) {
      String month = DateFormat('MMMM yyyy').format(
          DateTime.parse(notification['created_at'])); // Format bulan dan tahun
      if (!groupedNotifications.containsKey(month)) {
        groupedNotifications[month] = [];
      }
      groupedNotifications[month]!.add(notification);
    }

    // Update the notificationsByMonth with the grouped and sorted data
    notificationsByMonth.value = groupedNotifications;
  }
}
