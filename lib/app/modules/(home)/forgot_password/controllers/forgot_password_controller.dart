import 'package:dompet_mal/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  final isEmailValid = false.obs;
  final isLoading = false.obs;

  void validateEmail(String value) {
    isEmailValid.value = value.isNotEmpty && value.contains('@');
  }

  Future<void> submitForgotPassword() async {
    if (!isEmailValid.value) return;

    try {
      isLoading.value = true;
      // Implementasi POST ke /api/forgot-password
      await Future.delayed(
          Duration(seconds: 2)); // Ganti dengan actual API call

      Get.toNamed(Routes.FORGOTPASS_VERIFICATION, arguments: {
        'email': emailController.text,
      });
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan, silakan coba lagi',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
