import 'package:dompet_mal/app/modules/(admin)/charityAdmin/controllers/charity_admin_controller.dart';
import 'package:get/get.dart';

import '../controllers/my_favorite_controller.dart';

class MyFavoriteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyFavoriteController>(
      () => MyFavoriteController(),
    );
    Get.lazyPut<CharityAdminController>(
      () => CharityAdminController(),
    );
  }
}
