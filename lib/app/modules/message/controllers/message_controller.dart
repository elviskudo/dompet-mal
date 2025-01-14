import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MessageController extends GetxController {
  // Daftar pesan yang akan ditampilkan
  RxList<Map<String, dynamic>> messages = <Map<String, dynamic>>[
    {
      "username": "John Doe",
      "avatar": "assets/images/avatar1.png",
      "body": "Hello, how are you?",
      "created_at": "2025-01-13 10:00 AM"
    },
    {
      "username": "Jane Smith",
      "avatar": "assets/images/avatar2.png",
      "body": "I'm good, thank you!",
      "created_at": "2025-01-13 10:05 AM"
    },
    {
      "username": "Alice Johnson",
      "avatar": "assets/images/avatar3.png",
      "body": "Are we still on for the meeting tomorrow?",
      "created_at": "2025-01-13 10:15 AM"
    },
    {
      "username": "Bob Williams",
      "avatar": "assets/images/avatar4.png",
      "body": "Yes, the meeting is scheduled at 2 PM.",
      "created_at": "2025-01-13 10:20 AM"
    }
  ].obs;

  @override
  void onInit() {
    super.onInit();
    sortMessages();
  }

  // Fungsi untuk menambah pesan baru
  void addMessage(
      String username, String avatar, String body, String createdAt) {
    messages.add({
      "username": username,
      "avatar": avatar,
      "body": body,
      "created_at": createdAt
    });
    sortMessages(); // Urutkan pesan setelah menambahkan
    update();
  }

  // Fungsi untuk menghapus pesan berdasarkan index
  void deleteMessage(int index) {
    if (index >= 0 && index < messages.length) {
      messages.removeAt(index);
      update();
    }
  }

  // Fungsi untuk mendapatkan pesan berdasarkan index
  Map<String, dynamic> getMessage(int index) {
    if (index >= 0 && index < messages.length) {
      return messages[index];
    }
    return {};
  }

  // Fungsi untuk mengurutkan pesan dari yang terbaru
  void sortMessages() {
    messages.sort((a, b) {
      DateTime dateA = DateFormat("yyyy-MM-dd hh:mm a").parse(a["created_at"]);
      DateTime dateB = DateFormat("yyyy-MM-dd hh:mm a").parse(b["created_at"]);
      return dateB.compareTo(dateA);
    });
  }

  List<Map<String, dynamic>> getOldestMessages() {
    // Urutkan pesan berdasarkan tanggal dan ambil pesan terakhir (terlama)
    messages.sort((a, b) {
      DateTime dateA = DateFormat("yyyy-MM-dd hh:mm a").parse(a["created_at"]);
      DateTime dateB = DateFormat("yyyy-MM-dd hh:mm a").parse(b["created_at"]);
      return dateA.compareTo(dateB); // Urutkan berdasarkan tanggal terlama
    });
    return [messages.first]; // Mengembalikan pesan pertama setelah diurutkan
  }

  // Fungsi untuk memfilter pesan berdasarkan username
  List<Map<String, dynamic>> filterMessages(String username) {
    return messages
        .where((message) => message["username"] == username)
        .toList();
  }
}
