import 'package:dompet_mal/app/modules/(admin)/charityAdmin/controllers/charity_admin_controller.dart';
import 'package:dompet_mal/app/modules/(admin)/transactions/controllers/transactions_controller.dart';
import 'package:dompet_mal/component/bannerCategoryChoice.dart';
import 'package:dompet_mal/component/customAppBarCategory.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/my_donation_controller.dart';
import 'package:dompet_mal/models/CharityModel.dart';

class MyDonationView extends GetView<MyDonationController> {
  MyDonationView({super.key});

  final charityController = Get.put(CharityAdminController());
  final transactionController = Get.put(TransactionsController());

  @override
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
          child: Obx(() {
            // Get user's transactions
            final userTransactions = transactionController.transactionsNoGroup
                .where((transaction) =>
                    transaction.userId == transactionController.userId.value)
                .toList();

            // Get charity IDs from user's transactions
            final userCharityIds = userTransactions
                .map((transaction) => transaction.charityId)
                .toSet()
                .toList();

            // Filter charities based on user's transactions
            final userCharities = charityController.charities
                .where((charity) => userCharityIds.contains(charity.id))
                .toList();

            if (userCharities.isEmpty) {
              return Center(child: Text('Tidak ada donasi ditemukan'));
            }

            return BannerKategori(
              category: charityController.categories.value,
              banners: userCharities,
              maxItems: 0,
            );
          }),
        ),
      ),
    );
  }
}
