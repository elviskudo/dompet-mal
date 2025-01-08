import 'package:dompet_mal/component/bannerCategoryChoice.dart';
import 'package:dompet_mal/component/bannerOperatonalFunds.dart';
import 'package:dompet_mal/component/bannerSliderMorningCharity.dart';
import 'package:dompet_mal/component/search.dart';
import 'package:dompet_mal/models/MorningCharity.dart';
import 'package:dompet_mal/models/pilihanKategoriModel.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/beranda_controller.dart';

class BerandaView extends GetView<BerandaController> {
  const BerandaView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BerandaView'),
        centerTitle: true,
      ),
      // body: Container(
      //   width: MediaQuery.of(context).size.width,
      //   height: 310,
      //   child: (KategoriGridScreen()),
      // ),
      body: ListView(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 36),
            child: Column(
              children: [
                SearchBars(controller: controller.searchController),
                SizedBox(
                  height: 16,
                ),
                BannerSlider(
                  banners: dummyMorningCharity,
                ),
                SizedBox(
                  height: 12,
                ),
                BannerDanaOperasional(),
                SizedBox(
                  height: 18,
                ),
                BannerKategori(banners: dummyDataListCategoryBanner,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
