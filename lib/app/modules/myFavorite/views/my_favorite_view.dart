import 'package:dompet_mal/app/modules/myDonation/controllers/my_donation_controller.dart';
import 'package:dompet_mal/component/bannerCategoryChoice.dart';
import 'package:dompet_mal/component/bottomBar.dart';
import 'package:dompet_mal/component/customAppBarCategory.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/my_favorite_controller.dart';

class MyFavoriteView extends GetView<MyFavoriteController> {
  MyFavoriteView({super.key});
  @override
  final charityController = Get.put(MyDonationController());
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Donasi Ku',
        onSortPressed: () {
          charityController.showSortDialog(context);
        },
        onFilterPressed: () {
          charityController.showSearchDialog(context);
        },
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsetsDirectional.all(24),
          child: Obx(
            () {
              if (charityController.filteredCharities.value.isEmpty) {
                return Center(child: Text('Tidak ada data ditemukan'));
              }
              return BannerKategori(
                banners: charityController.filteredCharities.value,
                maxItems: 0,
              );
            },
          ),
        ),
      ),
    );
  }
}
