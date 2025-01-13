import 'package:dompet_mal/app/modules/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ResetPassController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final isFormValid = false.obs;
  final isPasswordHidden = true.obs;
  final isConfirmPasswordHidden = true.obs;

  void validateInputs() {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$';

    isFormValid.value = RegExp(pattern).hasMatch(passwordController.text) &&
        confirmPasswordController.text.isNotEmpty &&
        passwordController.text == confirmPasswordController.text;
  }

  Future<void> saveNewPassword() async {
    if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$')
        .hasMatch(passwordController.text)) {
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

    try {
      Get.snackbar(
        'Berhasil',
        'Password berhasil diubah',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal mengubah password: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;
  }

  @override
  void onClose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
