import 'package:dompet_mal/app/modules/listDonation/controllers/list_donation_controller.dart';
import 'package:dompet_mal/app/modules/myDonation/controllers/my_donation_controller.dart';
import 'package:dompet_mal/component/bannerCategoryChoice.dart';
import 'package:dompet_mal/component/customAppBarCategory.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListDonationView extends GetView<ListDonationController> {
  ListDonationView({super.key});

  final charityController = Get.put(ListDonationController());

  @override
  Widget build(BuildContext context) {
    final categoryId = Get.arguments; // Ambil categoryId dari arguments

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
        child: Column(
          children: [
            Container(
              padding: EdgeInsetsDirectional.all(24),
              child: Obx(
                () {
                  // Filter data berdasarkan categoryId
                  if (categoryId != null) {
                    charityController.filteredCharities.value =
                        charityController.charities.where((charity) {
                      return charity.category.id == categoryId;
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