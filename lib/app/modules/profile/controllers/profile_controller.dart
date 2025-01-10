import 'package:dompet_mal/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  final formKey = GlobalKey<FormState>();
  RxString userEmail = ''.obs;
  RxString userName = ''.obs;
  RxString userPhone = ''.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  Future<void> updateProfile(
      {required String name, required String phone}) async {
    try {
      isLoading.value = true;

      // // Validasi nomor telepon
      // if (!phone.startsWith('0') || phone.length < 10 || phone.length > 13) {
      //   Get.snackbar(
      //     'Error',
      //     'Nomor telepon harus dimulai dengan 0 dan panjang 10-13 digit',
      //     backgroundColor: Colors.red,
      //     colorText: Colors.white,
      //   );
      //   return;
      // }

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userName', name);
      await prefs.setString('userPhone', phone);

      userName.value = name;
      userPhone.value = phone;
      await Get.defaultDialog(
        title: 'Sukses',
        middleText: 'Profile berhasil diperbarui',
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
        'Gagal memperbarui profile: $e',
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
        'Gagal memuat data profile: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
