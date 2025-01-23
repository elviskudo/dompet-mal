import 'dart:io';

import 'package:get/get.dart';

class SendMoney2Controller extends GetxController {
  //TODO: Implement SendMoney2Controller
  final selectedImage = Rx<File?>(null);


  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }
  void setSelectedImage(File image) {
    selectedImage.value = image;
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
