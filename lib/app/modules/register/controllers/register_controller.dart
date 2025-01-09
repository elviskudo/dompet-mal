import 'package:dompet_mal/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:convert'; // untuk JSON encode/decode

class RegisterController extends GetxController {
  final formKey = GlobalKey<FormState>();
  late SharedPreferences prefs;

  final namaController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();

  final isPasswordHidden = true.obs;
  final isConfirmPasswordHidden = true.obs;
  final isAgreed = false.obs;

  @override
  void onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
  }

  void togglePasswordVisibility() =>
      isPasswordHidden.value = !isPasswordHidden.value;
  void toggleConfirmPasswordVisibility() =>
      isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;
  void toggleAgreement() => isAgreed.value = !isAgreed.value;

  void register() async {
    if (!formKey.currentState!.validate()) return;

    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$';
    if (!RegExp(pattern).hasMatch(passwordController.text)) {
      Get.snackbar(
        'Error',
        'Password minimal 6 karakter dan harus mengandung huruf besar, huruf kecil, angka, dan simbol',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar(
        'Error',
        'Password dan konfirmasi password tidak cocok',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (!isAgreed.value) {
      Get.snackbar(
        'Error',
        'Anda harus menyetujui Syarat & Ketentuan',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      final userData = {
        'nama': namaController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'phone': phoneController.text,
        'isVerified': false,
      };

      await prefs.setString('userData', jsonEncode(userData));
      await prefs.setBool('isLoggedIn', false);

      Get.snackbar(
        'Sukses',
        'Registrasi berhasil! Silahkan verifikasi email Anda',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Redirect ke halaman OTP
      Get.offAllNamed(
        Routes.EMAIL_VERIFICATION,
        arguments: {
          'email': emailController.text,
          'nama': namaController.text,
        },
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan saat mendaftar',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    namaController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
