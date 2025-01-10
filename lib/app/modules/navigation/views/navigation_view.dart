import 'package:dompet_mal/app/modules/home/views/home_view.dart';
import 'package:dompet_mal/app/modules/myDonation/views/my_donation_view.dart';
import 'package:dompet_mal/app/modules/myFavorite/views/my_favorite_view.dart';
import 'package:dompet_mal/app/modules/participants/views/participants_view.dart';
import 'package:dompet_mal/app/modules/profile/views/profile_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/navigation_controller.dart';

class NavigationView extends GetView<NavigationController> {
  const NavigationView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.tabIndex.value,
          children: [
            HomeView(),
            MyDonationView(),
            MyFavoriteView(),
            ProfileView(),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Beranda',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bookmark_border),
                label: 'Donasiku',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border),
                label: 'Favorit',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'Profile',
              ),
            ],
            currentIndex: controller.tabIndex.value,
            selectedItemColor: Color(0xFF4B76D9),
            unselectedItemColor: Colors.black.withOpacity(0.5),
            onTap: controller.changeTabIndex,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            iconSize: 30,
            selectedLabelStyle: GoogleFonts.quicksand(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            unselectedLabelStyle: GoogleFonts.quicksand(
              fontWeight: FontWeight.w600,
              color: Color(0xFF000000),
            ),
          ),
        ),
      ),
    );
  }
}
