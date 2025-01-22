// File: app/controllers/upload_controller.dart
import 'package:dompet_mal/app/modules/(admin)/categories/controllers/categories_controller.dart';
import 'package:dompet_mal/models/file_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;
import 'package:supabase_flutter/supabase_flutter.dart'; // Menambahkan prefix 'dio'

// Modifikasi UploadController
class UploadController extends GetxController {
  final SupabaseClient supabase = Supabase.instance.client;
  final isLoading = false.obs;
  final selectedModuleClass = ''.obs;
  final selectedModuleId = ''.obs;
  final imageUrl = ''.obs;
  final selectedImage = Rxn<XFile>();
  final fileType = ''.obs;

  final cloudName = 'dcthljxbl';
  final uploadPreset = 'dompet-mal';

  Future<void> uploadFileToCloudinary(XFile file) async {
    try {
      isLoading.value = true;

      final bytes = await file.readAsBytes();
      fileType.value = file.name.split('.').last;

      final formData = dio.FormData.fromMap({
        'file': dio.MultipartFile.fromBytes(
          bytes,
          filename: file.name,
        ),
        'upload_preset': uploadPreset,
      });

      final response = await dio.Dio().post(
        'https://api.cloudinary.com/v1_1/$cloudName/image/upload',
        data: formData,
      );

      if (response.statusCode == 200) {
        imageUrl.value = response.data['secure_url'];
      }
    } catch (e) {
      print('Upload error: $e');
      Get.snackbar('Error', 'Failed to upload file: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> saveFileInfo() async {
    try {
      isLoading.value = true;
      await supabase.from('files').insert(
            FileModel(
              moduleClass: selectedModuleClass.value,
              moduleId: selectedModuleId.value,
              fileName: imageUrl.value,
              fileType: fileType.value,
            ).toJson(),
          );
      Get.snackbar('Success', 'File saved successfully');
      Get.back(); // Close dialog after successful save
    } catch (e) {
      print('Error saving file info: $e');
      Get.snackbar('Error', 'Failed to save file information');
    } finally {
      isLoading.value = false;
    }
  }
}

// Modifikasi UploadDialog
