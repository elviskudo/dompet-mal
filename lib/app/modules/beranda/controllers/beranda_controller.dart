import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BerandaController extends GetxController {
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

  void increment() => count.value++;
}
