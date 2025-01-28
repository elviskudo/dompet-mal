import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../controllers/message_controller.dart';

class MessageView extends StatefulWidget {
  const MessageView({super.key});

  @override
  _MessageViewState createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  late MessageController controller;
  bool isNewestFirst = true;

  @override
  void initState() {
    super.initState();
    controller = Get.put(MessageController());
    controller.sortMessages();
  }

  // Fungsi untuk mengubah urutan filter (terbaru atau terlama)
  void toggleSortOrder() {
    setState(() {
      isNewestFirst = !isNewestFirst;
    });

    if (isNewestFirst) {
      controller.sortMessages(); // Urutkan pesan terbaru (descending)
    } else {
      controller.messages.sort((a, b) {
        DateTime dateA =
            DateFormat("yyyy-MM-dd hh:mm a").parse(a["created_at"]);
        DateTime dateB =
            DateFormat("yyyy-MM-dd hh:mm a").parse(b["created_at"]);
        return dateA.compareTo(dateB); // Urutkan pesan terlama (ascending)
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pesan',
          style: GoogleFonts.poppins(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isNewestFirst ? Icons.sort : Icons.sort_outlined,
              color: Colors.black,
            ),
            onPressed:
                toggleSortOrder, // Menambahkan aksi saat ikon sort di-klik
          ),
        ],
      ),
      body: GetBuilder<MessageController>(
        builder: (controller) {
          return ListView.builder(
            itemCount: controller.messages.length,
            itemBuilder: (context, index) {
              final message = controller.messages[index];
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
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage(message['avatar']),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              message['username'],
                              style: GoogleFonts.openSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              message['body'],
                              style: GoogleFonts.openSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              message['created_at'],
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
          );
        },
      ),
    );
  }
}
