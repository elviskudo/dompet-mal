import 'package:dompet_mal/app/modules/(admin)/charityAdmin/controllers/charity_admin_controller.dart';
import 'package:dompet_mal/component/bannerCategoryChoice.dart';
import 'package:dompet_mal/component/customAppBarCategory.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/my_donation_controller.dart';

class MyDonationView extends GetView<MyDonationController> {
  MyDonationView({super.key});
  @override
  final charityController = Get.put(CharityAdminController());
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Donasi Ku',
        onSortPressed: () {
          controller.showSortDialog(context);
        },
        onFilterPressed: () {
          controller.showSearchDialog(context);
        },
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsetsDirectional.all(24),
          child: Obx(
            () {
              if (charityController.charities.value.isEmpty) {
                return Center(child: Text('Tidak ada data ditemukan'));
              }
              return BannerKategori(
                category: charityController.categories.value,
                banners: charityController.charities.value,
                maxItems: 0,
              );
              return SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
