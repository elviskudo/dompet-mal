import 'package:get/get.dart';
import 'dart:convert';

class NotificationController extends GetxController {
  // Menggunakan RxList untuk menyimpan dan mengamati perubahan pada daftar notifikasi
  final notifications = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  // Fungsi untuk memuat dan mengurutkan data notifikasi
  void loadNotifications() {
    const jsonData = '''
    [
      {"title": "Pembayaran Sukses", "userAvatar": "images/avatar1.png", "created_at": "2025-01-13", "amount": 100000},
      {"title": "Donasi Diterima", "userAvatar": "images/avatar2.png", "created_at": "2025-01-12", "amount": 150000},
      {"title": "Pembayaran Gagal", "userAvatar": "images/avatar3.png", "created_at": "2025-01-11", "amount": 50000}
    ]
    ''';

    // Parsing JSON dan mengurutkan berdasarkan title secara descending
    List<Map<String, dynamic>> loadedNotifications =
        List<Map<String, dynamic>>.from(json.decode(jsonData));
    loadedNotifications.sort((a, b) => b['title'].compareTo(a['title']));
    notifications.value = loadedNotifications;
  }

  // Tambahkan fungsi lainnya jika diperlukan
}
