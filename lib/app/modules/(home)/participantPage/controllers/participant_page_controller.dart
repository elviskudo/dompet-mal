import 'package:get/get.dart';

class ParticipantPageController extends GetxController {
  //TODO: Implement ParticipantPageController
final participants = [
    {
      "name": "Shane",
      "amount": "Rp10.000",
      "date": "23 Desember 2021",
      "image": "assets/images/participant1.jpg", // Ganti dengan path gambar Anda
    },
    {
      "name": "Mitchell",
      "amount": "Rp50.000",
      "date": "23 Desember 2021",
      "image": "assets/images/participant2.jpg",
    },
    {
      "name": "Colleen",
      "amount": "Rp10.000",
      "date": "23 Desember 2021",
      "image": "assets/images/participant3.jpg",
    },
    {
      "name": "Anonim",
      "amount": "Rp100.000",
      "date": "23 Desember 2021",
      "image": "assets/images/participant4.jpg",
    },
    {
      "name": "Max",
      "amount": "Rp10.000",
      "date": "23 Desember 2021",
      "image": "assets/images/participant5.jpg",
    },
    {
      "name": "Angel",
      "amount": "Rp10.000",
      "date": "23 Desember 2021",
      "image": "assets/images/participant6.jpg",
    },
  ].obs;
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
