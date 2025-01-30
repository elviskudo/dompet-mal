import 'package:get/get.dart';

import '../controllers/my_favorite_controller.dart';

class MyFavoriteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyFavoriteController>(
      () => MyFavoriteController(),
    );
  }
}
