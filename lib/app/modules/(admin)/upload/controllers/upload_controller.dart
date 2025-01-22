// File: app/controllers/upload_controller.dart
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio; // Menambahkan prefix 'dio'

class UploadController extends GetxController {
  final isLoading = false.obs;
  final imageUrl = ''.obs;
  final errorMessage = ''.obs;
  
  final cloudName = 'dcthljxbl';
  final uploadPreset = 'dompet-mal';

  Future<void> pickAndUploadImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      
      if (image != null) {
        isLoading.value = true;
        
        // Read image as bytes
        final bytes = await image.readAsBytes();
        
        // Create form data
        final formData = dio.FormData.fromMap({
          'file': dio.MultipartFile.fromBytes(
            bytes,
            filename: image.name,
          ),
          'upload_preset': uploadPreset,
        });

        // Make POST request to Cloudinary
        final response = await dio.Dio().post(
          'https://api.cloudinary.com/v1_1/$cloudName/image/upload',
          data: formData,
        );

        if (response.statusCode == 200) {
          imageUrl.value = response.data['secure_url'];
          errorMessage.value = '';
        }
      }
    } catch (e) {
      print('Upload error: $e'); // Untuk debugging
      errorMessage.value = 'Error uploading image: $e';
    } finally {
      isLoading.value = false;
    }
  }
}