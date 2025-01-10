import 'package:dompet_mal/app/routes/app_pages.dart';
import 'package:dompet_mal/color/color.dart';
import 'package:dompet_mal/component/CategoryGridIcon.dart';
import 'package:dompet_mal/component/StraightCharityCard.dart';
import 'package:dompet_mal/component/TotalDonation.dart';
import 'package:dompet_mal/component/bannerCategoryChoice.dart';
import 'package:dompet_mal/component/bannerOperatonalFunds.dart';
import 'package:dompet_mal/component/bannerSliderMorningCharity.dart';
import 'package:dompet_mal/component/bantuanDanaCard.dart';
import 'package:dompet_mal/component/bottomBar.dart';
import 'package:dompet_mal/component/chat.dart';
import 'package:dompet_mal/component/logo.dart';
import 'package:dompet_mal/component/notifcation.dart';
import 'package:dompet_mal/component/search.dart';
import 'package:dompet_mal/component/sectionHeader.dart';
import 'package:dompet_mal/models/HelpDonationCharity.dart';
import 'package:dompet_mal/models/MorningCharity.dart';
import 'package:dompet_mal/models/pilihanKategoriModel.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    var lebar = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: lebar,
                  height: 226,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/bgbatik.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: lebar,
                  height: 500,
                  color: Colors.white,
                )
              ],
            ),
            // Content
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Logo(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [notification(), Gap(14), chat()],
                        )
                      ],
                    ),
                  ),
                  Gap(21),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: SearchBars(controller: controller.searchController),
                  ),
                  Gap(6),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: TotalDanaDonasi(
                        danaDonasiLangsung: DanaDonasiLangsung(
                            totalBudgets: 12000, totalDonaturs: 10000),
                        onAddPressed: () =>
                            Get.toNamed(Routes.KONFIRMASI_TRANSFER)),
                  ),
                  Gap(24),
                  BannerSlider(banners: dummyMorningCharity),
                  Gap(24),
                  CATEGORYGridIcon(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: BannerDanaOperasional(),
                  ),
                  Gap(26),

                  // Donasi Langsung

                  Section(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SectionHeader(
                          title: 'Donasi Langsung',
                          actionText: 'Lihat lainnya',
                          onActionPressed: () {
                            // Handle navigation to "Lihat lainnya"
                          },
                        ),
                        HorizontalScrollRow(
                          items: charities
                              .map(
                                (charity) => StraightCharityComponent(
                                  charity: charity,
                                  onSeeMorePressed: () => {},
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),

                  //Bantuan Dana Darurat
                  Container(
                    height: 10,
                    color: Color(0xfff2f2f2),
                    width: lebar,
                  ),

                  const EmergencyFundSection(),

                  // Pilihan CATEGORY
                  Container(
                    height: 10,
                    color: Color(0xfff2f2f2),
                    width: lebar,
                  ),
                  Gap(0),
                  Container(
                    padding: EdgeInsetsDirectional.symmetric(
                        horizontal: 24, vertical: 16),
                    color: Colors.white,
                    child: Column(
                      children: [
                        SectionHeader(
                          title: 'Pilihan CATEGORY',
                          actionText: '',
                          onActionPressed: () {
                            // Handle navigation to "Lihat lainnya"
                          },
                        ),
                        BannerCATEGORY(banners: dummyDataListCategoryBanner),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
