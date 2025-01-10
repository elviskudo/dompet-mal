import 'package:dompet_mal/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KategoriController extends GetxController {
  //TODO: Implement BerandaController
  final TextEditingController searchController = TextEditingController();
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

  void handleCategoryTap(int index) {
    if (index == 0) {
      Get.toNamed(Routes.ListDonation); // Navigate using GetX
    }
  }

  void increment() => count.value++;
}
