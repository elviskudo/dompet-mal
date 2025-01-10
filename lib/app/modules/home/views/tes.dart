import 'package:dompet_mal/component/CategoryGridIcon.dart';
import 'package:dompet_mal/component/TotalDonation.dart';
import 'package:dompet_mal/component/bottomBar.dart';
import 'package:dompet_mal/component/chat.dart';
import 'package:dompet_mal/component/logo.dart';
import 'package:dompet_mal/component/notifcation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 226,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/bgbatik.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: (Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Logo(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [notification(), Gap(14), chat()],
                        )
                      ],
                    ),
                    Gap(20),
                    SearchBar(),
                    Gap(12),
                    TotalDanaDonasi(
                        danaDonasiLangsung: DanaDonasiLangsung(
                            totalBudgets: 12000, totalDonaturs: 10000),
                        onAddPressed: () {}),
                    Gap(24),
                    CATEGORYGridIcon()
                  ],
                )),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Bottombar(),
    );
  }
}
