// File: app/views/upload_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/upload_controller.dart';

class UploadView extends GetView<UploadController> {
  const UploadView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Image'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Show selected image preview
              Obx(() => controller.imageUrl.isNotEmpty
                  ? Image.network(
                      controller.imageUrl.value,
                      height: 200,
                    )
                  : const SizedBox.shrink()),

              const SizedBox(height: 20),

              // Upload button
              Obx(() => controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: controller.pickAndUploadImage,
                      child: const Text('Pick and Upload Image'),
                    )),

              // Error message
              Obx(() => controller.errorMessage.isNotEmpty
                  ? Text(
                      controller.errorMessage.value,
                      style: const TextStyle(color: Colors.red),
                    )
                  : const SizedBox.shrink()),
            ],
          ),
        ),
      ),
    );
  }
}
