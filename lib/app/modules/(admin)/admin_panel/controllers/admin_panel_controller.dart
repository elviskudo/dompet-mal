import 'package:get/get.dart';

class AdminPanelController extends GetxController {
  final RxInt selectedIndex = 0.obs;
  final RxBool isSidebarVisible = false.obs;

  void toggleSidebar() {
    isSidebarVisible.value = !isSidebarVisible.value;
  }

  void closeSidebar() {
    isSidebarVisible.value = false;
  }

  void changeIndex(int index) {
    selectedIndex.value = index;
    // Optionally close sidebar after selection on mobile
    if (Get.width < 600) {
      closeSidebar();
    }
  }
}