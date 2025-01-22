import 'package:get/get.dart';

import '../controllers/contributor_admin_controller.dart';

class ContributorAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContributorAdminController>(
      () => ContributorAdminController(),
    );
  }
}
