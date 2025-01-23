import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  final TextEditingController searchController = TextEditingController();
  final RxString donationAmount = '10000'.obs;
  final RxBool isLoading = false.obs;

  void setDonationAmount(String amount) {
    if (amount.isEmpty) {
      donationAmount.value = '0';
      return;
    }

    // Remove non-numeric characters
    final numericValue = amount.replaceAll(RegExp(r'[^0-9]'), '');

    // Prevent value from being too large
    if (numericValue.length > 12) {
      return;
    }

    donationAmount.value = numericValue;
  }

  // Getter for numeric value
  int get numericAmount {
    return int.tryParse(donationAmount.value) ?? 0;
  }

  // Validate donation amount
  bool get isValidAmount {
    return numericAmount >= 10000;
  }

  Future<void> processDonation() async {
    if (!isValidAmount) {
      Get.snackbar(
        'Error',
        'Minimal donasi Rp 10.000',
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    try {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 2)); // Simulated API call
      Get.back(); // Close bottom sheet
      Get.snackbar(
        'Sukses',
        'Donasi berhasil diproses',
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan saat memproses donasi',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
