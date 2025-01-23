import 'package:dompet_mal/app/modules/(home)/home/controllers/home_controller.dart';
import 'package:dompet_mal/app/modules/(home)/profile/controllers/profile_controller.dart';
import 'package:get/get.dart';

import '../controllers/navigation_controller.dart';

class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavigationController>(() => NavigationController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
