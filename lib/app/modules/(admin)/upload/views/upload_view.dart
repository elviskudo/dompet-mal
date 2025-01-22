// File: app/views/upload_view.dart
import 'package:dompet_mal/component/UploadDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/upload_controller.dart';

class UploadView extends GetView<UploadController> {
  const UploadView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('UploadView'),
            IconButton(
              icon: const Icon(Icons.upload),
              tooltip: 'Upload Foto',
              onPressed: () {
                Get.dialog(UploadDialog());
              },
            ),
          ],
        ),
        // centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.fileList.isEmpty) {
                return const Center(child: Text('No files available'));
              }

              return ListView.builder(
                itemCount: controller.fileList.length,
                itemBuilder: (context, index) {
                  final file = controller.fileList[index];
                  return ListTile(
                    title: Row(
                      children: [
                        Expanded(
                          flex: 1, // Mengatur proporsi lebar dari title
                          child: Container(
                            child: Text(
                              file.fileName ?? 'Unknown File',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Type: ${file.fileType ?? 'Unknown'}'),
                        Text('Module class: ${file.moduleClass ?? 'Unknown'}'),
                      ],
                    ),
                    trailing: IconButton(
                      tooltip: 'copy',
                      icon: Icon(Icons.copy),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: file.fileName));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('File name copied to clipboard!')),
                        );
                      },
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
