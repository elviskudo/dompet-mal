import 'package:dompet_mal/app/modules/(admin)/upload/controllers/upload_controller.dart';
import 'package:dompet_mal/app/routes/app_pages.dart';
import 'package:dompet_mal/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileController extends GetxController {
  final supabase = Supabase.instance.client;
  final RxList<Users> usersList = <Users>[].obs;
  RxBool isLoading = false.obs;
  RxString roleUser = ''.obs;
  RxString currentUserId = ''.obs;
  RxString userName = ''.obs;
  RxString userPhone = ''.obs;
  RxString userEmail = ''.obs;
  final formKey = GlobalKey<FormState>();
  final namaController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  RxString selectedRoleId = ''.obs;
  final UploadController uploadController = Get.put(UploadController());
  RxString profileImageUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData().then((_) => loadProfileImage()); // Ubah menjadi sequential
  }

  Future<void> logout() async {
    try {
      isLoading.value = true;

      // Sign out from Supabase
      await supabase.auth.signOut();

      // Clear SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear(); // Clears all data
      // Or clear specific keys if you prefer:
      // await prefs.setBool('isLoggedIn', false);
      // await prefs.remove('userEmail');
      // await prefs.remove('userName');
      // await prefs.remove('userPhone');
      // await prefs.remove('userId');
      // await prefs.remove('accessToken');

      Get.snackbar(
        'Sukses',
        'Berhasil logout',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
      );

      // Navigate to login page
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal logout: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProfileWithImage(
      {required String name, required String phone}) async {
    try {
      isLoading.value = true;

      // Update profile info dulu
      await updateProfile(currentUserId.value, name: name, phone: phone);

      // Jika ada image yang dipilih
      if (uploadController.selectedImage.value != null) {
        // Set module class dan ID
        uploadController.selectedModuleClass.value = 'users';
        uploadController.selectedModuleId.value = currentUserId.value;

        // Cek existing file
        try {
          final existingFile = await uploadController.supabase
              .from('files')
              .select()
              .eq('module_class', 'users')
              .eq('module_id', currentUserId.value)
              .single();

          if (existingFile != null) {
            uploadController.existingFileId.value = existingFile['id'];
          } else {
            uploadController.existingFileId.value = '';
          }
        } catch (e) {
          print('No existing file found: $e');
          uploadController.existingFileId.value = '';
        }

        // Upload file ke Cloudinary
        await uploadController
            .uploadFileToCloudinary(uploadController.selectedImage.value!);

        // Save file info menggunakan logika yang sudah ada
        await uploadController.saveFileInfo();

        // Reload profile image
        await loadProfileImage();
      }

      Get.snackbar(
        'Success',
        'Profile updated successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      print('Error updating profile with image: $e');
      Get.snackbar(
        'Error',
        'Failed to update profile: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProfile(String id,
      {required String name, required String phone}) async {
    // Validasi input
    if (id.isEmpty || name.isEmpty || phone.isEmpty) {
      Get.snackbar(
        "Terjadi Kesalahan",
        "Nama dan Nomor Telepon wajib diisi",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      // Ubah cara update ke Supabase
      await supabase.from("users").update({
        "name": namaController.text,
        "phone_number": phoneController.text,
      }).eq("id", id);

      // Jika sampai sini berarti update berhasil
      // Update SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("userName", namaController.text);
      await prefs.setString("userPhone", phoneController.text);

      // Tampilkan dialog sukses
    } catch (e) {
      // Handle error
      Get.snackbar(
        "Terjadi Kesalahan",
        "Tidak dapat memperbarui profil: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> loadUserData() async {
    try {
      isLoading.value = true;
      final prefs = await SharedPreferences.getInstance();

      userEmail.value = prefs.getString('userEmail') ?? '';
      userName.value = prefs.getString('userName') ?? '';
      userPhone.value = prefs.getString('userPhone') ?? '';
      currentUserId.value = prefs.getString('userId') ?? '';

      final response = await supabase
          .from('users')
          .select('*')
          .eq('id', currentUserId.value)
          .single(); // Menggunakan single() untuk mendapatkan satu record

      if (response != null) {
        // Mengakses data menggunakan operator map
        userEmail.value = response['email'] ?? '';
        userName.value = response['name'] ?? '';
        userPhone.value = response['phone_number'] ?? '';

        // Update controller text
        namaController.text = userName.value;
        phoneController.text = userPhone.value;
        emailController.text = userEmail.value;
      }

      print(
          "ID: ${currentUserId.value}, Name: ${userName.value}, Phone: ${userPhone.value}");
    } catch (e) {
      print('Error loading user data: $e');
      Get.snackbar(
        'Error',
        'Gagal memuat data profil: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadProfileImage() async {
    try {
      final response = await uploadController.supabase
          .from('files')
          .select()
          .eq('module_class', 'users')
          .eq('module_id', currentUserId.value)
          .single();

      print('Profile image response: $response');

      if (response != null) {
        profileImageUrl.value = response['file_name'];
        print('Profile image URL: ${profileImageUrl.value}');
      }
    } catch (e) {
      print('Error loading profile image: $e');
      profileImageUrl.value = '';
    }
  }
}
