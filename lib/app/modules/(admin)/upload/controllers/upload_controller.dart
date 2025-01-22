// File: app/controllers/upload_controller.dart
import 'package:dompet_mal/models/file_model.dart';
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
  final existingFileId = ''.obs;
  final imageUrl = ''.obs;
  final selectedImage = Rxn<XFile>();
  final fileType = ''.obs;

  final cloudName = 'dcthljxbl';
  final uploadPreset = 'dompet-mal';

  Future<void> checkExistingFile() async {
    try {
      final response = await supabase
          .from('files')
          .select()
          .eq('module_class', selectedModuleClass.value)
          .eq('module_id', selectedModuleId.value)
          .single(); // Get single record if exists

      if (response != null) {
        existingFileId.value = response['id'];
        imageUrl.value = response['file_name'];
        fileType.value = response['file_type'];
      } else {
        existingFileId.value = '';
        imageUrl.value = '';
        fileType.value = '';
      }
    } catch (e) {
      existingFileId.value = '';
      print('No existing file found: $e');
    }
  }

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

      final fileData = FileModel(
        moduleClass: selectedModuleClass.value,
        moduleId: selectedModuleId.value,
        fileName: imageUrl.value,
        fileType: fileType.value,
      ).toJson();

      if (existingFileId.value.isNotEmpty) {
        // Update existing file
        await supabase
            .from('files')
            .update(fileData)
            .eq('id', existingFileId.value);
        await resetForm();
        Get.back();
        Get.snackbar('Success', 'File updated successfully');
      } else {
        // Insert new file
        await supabase.from('files').insert(fileData);
        await resetForm();
        Get.back();
        Get.snackbar('Success', 'File saved successfully');
      }

      // Close dialog after successful save
    } catch (e) {
      print('Error saving file info: $e');
      Get.snackbar('Error', 'Failed to save file information');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resetForm() async {
    selectedModuleClass.value = '';
    selectedModuleId.value = '';
    existingFileId.value = '';
    imageUrl.value = '';
    fileType.value = '';
    selectedImage.value = null;
  }
}

// Modifikasi UploadDialog
