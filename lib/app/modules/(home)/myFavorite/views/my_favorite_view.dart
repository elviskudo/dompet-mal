import 'package:dompet_mal/app/modules/(admin)/charityAdmin/controllers/charity_admin_controller.dart';
import 'package:dompet_mal/app/modules/(home)/myDonation/controllers/my_donation_controller.dart';
import 'package:dompet_mal/component/bannerCategoryChoice.dart';
import 'package:dompet_mal/component/bottomBar.dart';
import 'package:dompet_mal/component/customAppBarCategory.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/my_favorite_controller.dart';

class MyFavoriteView extends GetView<MyFavoriteController> {
  MyFavoriteView({super.key});

  final charityController = Get.put(CharityAdminController());
  final controller = Get.put(MyFavoriteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Donasi Favorit',
        onSortPressed: () {
          // charityController.showSortDialog(context);
        },
        onFilterPressed: () {
          // charityController.showSearchDialog(context);
        },
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsetsDirectional.all(24),
          child: Obx(
            () {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }

              if (controller.filteredCharities.isEmpty) {
                return Center(child: Text('Tidak ada data favorit'));
              }

              return BannerKategori(
                category: charityController.categories.value,
                banners: controller.filteredCharities,
                maxItems: 0,
              );
            },
          ),
        ),
      ),
    );
  }
}
