import 'package:dompet_mal/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileController extends GetxController {
  final formKey = GlobalKey<FormState>();
  RxString userId = ''.obs;
  RxString userEmail = ''.obs;
  RxString userName = ''.obs;
  RxString userPhone = ''.obs;
  RxBool isLoading = false.obs;
  final supabase = Supabase.instance.client;

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

  Future<void> updateProfile({
    required String name,
    required String phone,
  }) async {
    if (name.isEmpty || phone.isEmpty) {
      Get.snackbar(
        'Error',
        'Semua bidang harus diisi',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (name == userName.value && phone == userPhone.value) {
      Get.snackbar(
        'Gagal',
        'Tidak ada perubahan yang dibuat pada profil',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: EdgeInsets.symmetric(vertical: 20),
        snackPosition: SnackPosition.BOTTOM,
        snackStyle: SnackStyle.FLOATING,
        forwardAnimationCurve: Curves.easeOut,
        reverseAnimationCurve: Curves.easeIn,
      );
      return;
    }

    try {
      isLoading.value = true;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userName', name);
      await prefs.setString('userPhone', phone);

      userName.value = name;
      userPhone.value = phone;

      await Get.defaultDialog(
        title: 'Sukses',
        middleText: 'Profil berhasil diperbarui',
        textConfirm: 'OK',
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.back();
          Get.offNamed(Routes.NAVIGATION);
        },
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal memperbarui profil: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadUserData() async {
    try {
      isLoading.value = true;
      final prefs = await SharedPreferences.getInstance();

      String? email = prefs.getString('userEmail');
      String? name = prefs.getString('userName');
      String? phone = prefs.getString('userPhone');
      String? id = prefs.getString('userId');

      if (email != null && email.isNotEmpty) {
        userEmail.value = email;
      }

      if (name != null && name.isNotEmpty) {
        userName.value = name;
      }

      if (phone != null && phone.isNotEmpty) {
        userPhone.value = phone;
      }
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
