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

  @override
  void onInit() {
    super.onInit();
    loadUserData();
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
      var response = await supabase.from("users").update({
        "name": namaController.text,
        "phone": phoneController.text,
      }).eq("id", id);

      if (response.error == null) {
        // Update berhasil: Simpan data baru ke SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("name", namaController.text);
        await prefs.setString("phone", phoneController.text);

        // Tampilkan dialog sukses
        Get.defaultDialog(
          title: "Berhasil",
          middleText: "Profil berhasil diperbarui!",
          textConfirm: "OK",
          onConfirm: () {
            Get.back(); // Tutup dialog
            Get.back(); // Kembali ke halaman sebelumnya
          },
        );
      } else {
        // Jika ada error dari Supabase
        Get.snackbar(
          "Terjadi Kesalahan",
          response.error!.message,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      // Jika ada error umum
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
        userPhone.value = response['phone'] ?? '';

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
}
