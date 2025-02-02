import 'package:dompet_mal/app/modules/(admin)/charityAdmin/controllers/charity_admin_controller.dart';
import 'package:dompet_mal/app/modules/(admin)/list_user/controllers/list_user_controller.dart';
import 'package:dompet_mal/app/modules/(admin)/transactions/controllers/transactions_controller.dart';
import 'package:dompet_mal/app/modules/(home)/home/controllers/home_controller.dart';
import 'package:dompet_mal/app/modules/(home)/myFavorite/controllers/my_favorite_controller.dart';
import 'package:dompet_mal/app/modules/(home)/participantPage/controllers/participant_page_controller.dart';
import 'package:dompet_mal/app/modules/(home)/profile/controllers/profile_controller.dart';
import 'package:dompet_mal/service/cron_service.dart';
import 'package:get/get.dart';

import '../controllers/navigation_controller.dart';

class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavigationController>(() => NavigationController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<ListUserController>(() => ListUserController());
    Get.lazyPut<TransactionsController>(() => TransactionsController());
    Get.lazyPut<ParticipantPageController>(() => ParticipantPageController());
    Get.lazyPut<CharityAdminController>(() => CharityAdminController());
    Get.put(MyFavoriteController());
    // Get.lazyPut<CronService>(() => CronService());
  }
}
