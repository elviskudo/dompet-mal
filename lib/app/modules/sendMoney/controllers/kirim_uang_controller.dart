import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendMoneyController extends GetxController
    with SingleGetTickerProviderMixin {
  late AnimationController animationController;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Durasi rotasi
    )..repeat(); // Animasi berulang
  }

  @override
  void onClose() {
    animationController.dispose(); // Membersihkan controller
    super.onClose();
  }

  final count = 0.obs;

  @override
  void onReady() {
    super.onReady();
  }

  void increment() => count.value++;
}
