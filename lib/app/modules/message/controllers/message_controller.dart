import 'package:get/get.dart';

class MessageController extends GetxController {
  // Daftar pesan yang akan ditampilkan
  final List<Map<String, dynamic>> messages = [
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

  // Fungsi untuk menambah pesan baru
  void addMessage(String username, String avatar, String body, String createdAt) {
    messages.add({
      "username": username,
      "avatar": avatar,
      "body": body,
      "created_at": createdAt
    });
    update(); // Memperbarui tampilan
  }

  // Fungsi untuk menghapus pesan berdasarkan index
  void deleteMessage(int index) {
    if (index >= 0 && index < messages.length) {
      messages.removeAt(index);
      update(); // Memperbarui tampilan
    }
  }

  // Fungsi untuk mendapatkan pesan berdasarkan index
  Map<String, dynamic> getMessage(int index) {
    if (index >= 0 && index < messages.length) {
      return messages[index];
    }
    return {}; // Mengembalikan objek kosong jika index tidak valid
  }
}
