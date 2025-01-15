import 'package:dompet_mal/app/modules/listDonation/controllers/list_donation_controller.dart';
import 'package:dompet_mal/component/bannerCategoryChoice.dart';
import 'package:dompet_mal/component/customAppBarCategory.dart';
import 'package:dompet_mal/models/pilihanKategoriModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListDonationView extends GetView<ListDonationController> {
  ListDonationView({super.key});

  final charityController = Get.put(ListDonationController());

  @override
  Widget build(BuildContext context) {
    Category? categoryId = Get.arguments as Category?;
    return Scaffold(
      appBar: CustomAppBar(
        title:  categoryId != null ? 'Donasi ${categoryId.name}' : 'Donasi',
        onSortPressed: () {
          charityController.showSortDialog(context);
        },
        onFilterPressed: () {
          charityController.showSearchDialog(context);
        },
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsetsDirectional.all(24),
              child: Obx(
                () {
                  // Filter data berdasarkan categoryId
                  if (categoryId?.id != null) {
                    charityController.filteredCharities.value =
                        charityController.charities.where((charity) {
                      return charity.category.id == categoryId?.id;
                    }).toList();
                  } else {
                    charityController.filteredCharities.value =
                        charityController.charities;
                  }

                  if (charityController.filteredCharities.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 100),
                        child: Text('Tidak ada data ditemukan'),
                      ),
                    );
                  }
                  return BannerKategori(
                    banners: charityController.filteredCharities,
                    maxItems: 0,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}