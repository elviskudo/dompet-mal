// File: app/controllers/upload_controller.dart
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
  final existingFileId = ''.obs;
  final imageUrl = ''.obs;
  final selectedImage = Rxn<XFile>();
  final fileType = ''.obs;

  final cloudName = 'dcthljxbl';
  final uploadPreset = 'dompet-mal';
  final RxList<FileModel> fileList = <FileModel>[].obs;
  final RxList<String> moduleClasses =
      <String>['users', 'categories', 'all'].obs; // Contoh data module class
  final RxList<FileModel> filteredFileList = <FileModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchFiles();
  }

  void filterFiles() {
    if (selectedModuleClass.value.isEmpty ||
        selectedModuleClass.value == 'all') {
      filteredFileList.value =
          fileList; // Show all files when no filter is selected
    } else {
      filteredFileList.value = fileList
          .where((file) => file.moduleClass == selectedModuleClass.value)
          .toList();
    }
  }

  Future<List<FileModel>> fetchFiles() async {
    try {
      // isLoading.value = true;
      final response = await supabase.from('files').select('*');
      final data = response as List<dynamic>;

      List<FileModel> files = [];

      for (final file in data) {
        final moduleClass = file['module_class'] as String;
        final moduleId = file['module_id'] as String;
        String? moduleName;

        final userResponse = await supabase
            .from(moduleClass)
            .select('name')
            .eq('id', moduleId)
            .single();
        moduleName = userResponse['name'] as String;

        // Tambahkan data ke dalam list files
        files.add(FileModel(
          id: file['id'] as String?,
          moduleClass: moduleClass,
          moduleId: moduleId,
          moduleName: moduleName ?? 'Unknown', // Nama module atau default
          fileName: file['file_name'] as String,
          fileType: file['file_type'] as String,
          createdAt: file['created_at'] != null
              ? DateTime.parse(file['created_at'] as String)
              : null,
        ));
      }
      fileList.value = files;
      filteredFileList.value = files;
      filterFiles();
      return files;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to fetch files: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return [];
    }
  }

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
