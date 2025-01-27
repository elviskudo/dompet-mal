import 'package:dompet_mal/app/modules/(admin)/charityAdmin/controllers/charity_admin_controller.dart';
import 'package:dompet_mal/app/modules/(home)/listDonation/views/list_donation_view.dart';
import 'package:dompet_mal/app/routes/app_pages.dart';
import 'package:dompet_mal/component/CategoryGridIcon.dart';
import 'package:dompet_mal/component/StraightCharityCard.dart';
import 'package:dompet_mal/component/TotalDonation.dart';
import 'package:dompet_mal/component/bannerCategoryChoice.dart';
import 'package:dompet_mal/component/bannerOperatonalFunds.dart';
import 'package:dompet_mal/component/bannerSliderMorningCharity.dart';
import 'package:dompet_mal/component/bantuanDanaCard.dart';
import 'package:dompet_mal/component/chat.dart';
import 'package:dompet_mal/component/logo.dart';
import 'package:dompet_mal/component/notifcation.dart';
import 'package:dompet_mal/component/search.dart';
import 'package:dompet_mal/component/sectionHeader.dart';
import 'package:dompet_mal/component/shareButton.dart';
// import 'package:dompet_mal/models/HelpDonationCharity.dart';
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
    CharityAdminController charityController =
        Get.put(CharityAdminController());
    var lebar = MediaQuery.of(context).size.width;
    var tinggi = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: RefreshIndicator(
        onRefresh: () async {
          await charityController.fetchCharitiesWithContributors();
          await charityController.fetchCategories();
          await charityController.fetchCompanies();
          await charityController.calculateCharitySummary();
        },
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    width: lebar,
                    height: 226,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/bgbatik.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    width: lebar,
                    height: tinggi * 0.58,
                    color: Colors.white,
                  )
                ],
              ),
              // Content
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
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
                            children: [
                              notification(),
                              Gap(14),
                              chat(),
                            ],
                          )
                        ],
                      ),
                    ),
                    Gap(21),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child:
                          SearchBars(controller: controller.searchController),
                    ),
                    Gap(6),
                    Obx(() {
                      if (charityController.charities.value.isNotEmpty) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: TotalDanaDonasi(
                              danaDonasiLangsung: DanaDonasiLangsung(
                                totalBudgets: charityController
                                    .charitySummary.value.totalDonations,
                                totalDonaturs: charityController
                                    .charitySummary.value.totalDonors,
                              ),
                              onAddPressed: () =>
                                  Get.toNamed(Routes.KONFIRMASI_TRANSFER)),
                        );
                      } else {
                        return TotalDanaDonasiSkeleton();
                      }
                    }),
                    Gap(24),
                    Obx(() {
                      if (charityController.charities.value.isNotEmpty) {
                        return BannerSlider(
                          banners: charityController.charities.value,
                          category: charityController.categories.value,
                        );
                      } else {
                        return BannerSliderSkeleton();
                      }
                    }),
                    Gap(24),
                    CATEGORYGrid(),

                    Obx(() {
                      if (charityController.charities.value.isNotEmpty) {
                        return Padding(
                          padding: EdgeInsets.only(top: 40),
                          child: BannerDanaOperasional(),
                        );
                      } else {
                        return BannerDanaOperasionalSkeleton();
                      }
                    }),

                    Gap(18),

                    // Donasi Langsung

                    Section(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SectionHeader(
                            title: 'Donasi Langsung',
                            actionText: 'Lihat lainnya',
                            onActionPressed: () {
                              Get.toNamed(Routes.ListDonation);
                            },
                          ),
                          Obx(
                            () {
                              if (charityController
                                  .charities.value.isNotEmpty) {
                                return StraightCharityComponent(
                                  banners: charityController.charities.value,
                                  category: charityController.categories.value,
                                  maxItems: 3,
                                );
                              } else {
                                return StraightCharitySkeleton();
                              }
                            },
                          ),
                        ],
                      ),
                    ),

                    //Bantuan Dana Darurat

                    Obx(
                      () {
                        if (charityController.charities.value.isNotEmpty) {
                          return EmergencyFundSection(
                            banners: charityController.charities.value,
                            maxItems: 3,
                            category: charityController.categories,
                          );
                        } else {
                          return EmergencyFundSkeleton();
                        }
                      },
                    ),

                    // Pilihan CATEGORY
                    Container(
                      height: 10,
                      color: Color(0xfff7f7f7),
                      width: lebar,
                    ),
                    Gap(0),
                    Container(
                      padding: EdgeInsetsDirectional.only(
                        start: 24,
                        end: 24,
                        bottom: 16,
                      ),
                      color: Colors.white,
                      child: Column(
                        children: [
                          SectionHeader(
                            title: 'Pilihan Kategori',
                            actionText: '',
                            onActionPressed: () {
                              // Handle navigation to "Lihat lainnya"
                            },
                          ),
                          Obx(
                            () {
                              if (charityController
                                  .charities.value.isNotEmpty) {
                                return BannerKategori(
                                  banners: charityController.charities.value,
                                  maxItems: 4,
                                  category: charityController.categories.value,
                                );
                              } else {
                                return BannerSkeletonLoader();
                              }
                            },
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            width: 190,
                            height: 40,
                            child: ElevatedButton(
                                onPressed: () {
                                  Get.to(ListDonationView());
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xffD6E1FF),
                                    foregroundColor: Color(0xff4B76D9)),
                                child: Text("Lihat lainnya")),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
