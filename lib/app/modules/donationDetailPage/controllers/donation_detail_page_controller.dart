import 'package:get/get.dart';

class DonationDetailPageController extends GetxController {
  //TODO: Implement DonationDetailPageController
  final RxBool isScrolled = false.obs;
  // final String imageUrl = 'images/foto_bayi_sekarat.png';

  void updateScrollStatus(double offset) {
    isScrolled.value = offset > 0;
  }
 final RxDouble collectedAmount = 151472721.0.obs;
  final double targetAmount = 200000000.0;
  final RxInt participantsCount = 1034.obs;
    var currentSliderIndex = 0.obs;

  final List<String> imageList = [
    'https://picsum.photos/id/237/400/600',
    'https://picsum.photos/id/238/400/600',
    'https://picsum.photos/id/239/400/600',
  ];

  void updateSliderIndex(int index) {
    currentSliderIndex.value = index;
  }
  double get progressPercentage => (collectedAmount.value / targetAmount) * 100;
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
