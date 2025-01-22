import 'package:dompet_mal/component/UploadDialog.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/upload_controller.dart';

class UploadView extends GetView<UploadController> {
  const UploadView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UploadView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'UploadView is working',
              style: TextStyle(fontSize: 20),
            ),
            IconButton(
              icon: const Icon(Icons.upload),
              onPressed: () {
                Get.dialog(UploadDialog());
              },
            ),
          ],
        ),
      ),
    );
  }
}
