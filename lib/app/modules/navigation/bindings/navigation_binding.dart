import 'package:dompet_mal/app/modules/home/controllers/home_controller.dart';
import 'package:dompet_mal/app/modules/myDonation/controllers/my_donation_controller.dart';
import 'package:dompet_mal/app/modules/myFavorite/controllers/my_favorite_controller.dart';
import 'package:get/get.dart';

import '../controllers/navigation_controller.dart';

class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavigationController>(() => NavigationController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<MyDonationController>(() => MyDonationController());
    Get.lazyPut<MyFavoriteController>(() => MyFavoriteController());
    // Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
