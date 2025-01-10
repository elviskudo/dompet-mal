import 'package:dompet_mal/app/modules/listDonation/controllers/list_donation_controller.dart';
import 'package:dompet_mal/component/bannerCategoryChoice.dart';
import 'package:dompet_mal/component/customAppBarCategory.dart';
import 'package:dompet_mal/models/pilihanKategoriModel.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ListDonationView extends GetView<ListDonationController> {
  const ListDonationView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'List Donasi',
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsetsDirectional.all(24),
        child: BannerKategori(banners: dummyDataListCategoryBanner),
      ),
    );
  }
}
