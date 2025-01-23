import 'package:dompet_mal/app/modules/(home)/home/views/home_view.dart';
import 'package:dompet_mal/app/modules/(home)/listPayment/views/list_payment_view.dart';
import 'package:dompet_mal/app/modules/(home)/myDonation/views/my_donation_view.dart';
import 'package:dompet_mal/app/modules/(home)/myFavorite/views/my_favorite_view.dart';
import 'package:dompet_mal/app/modules/(home)/navigation/controllers/navigation_controller.dart';
import 'package:dompet_mal/app/modules/(home)/profile/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
            // QuranView(),
            MyDonationView(),
            MyFavoriteView(),
            ListPaymentView(),
            ProfileView(),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, -5),
              ),
            ],
          ),
          child: Row(
            children: [
              _buildNavItem(0, 'assets/icons/home.png', 'Beranda'),
              // _buildNavItem(1, 'assets/icons/home.png', 'al-Quran'),
              _buildNavItem(1, 'assets/icons/bookmark.png', 'Donasiku'),
              _buildNavItem(2, 'assets/icons/heart.png', 'Favorit'),
              _buildNavItem(3, 'assets/icons/dompet.png', 'Pembayaran'),
              _buildNavItem(4, 'assets/icons/user.png', 'Profile'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String iconPath, String label) {
    bool isSelected = controller.tabIndex.value == index;
    return Expanded(
      child: InkWell(
        onTap: () => controller.changeTabIndex(index),
        child: Container(
          height: 70,
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                iconPath,
                width: 24,
                height: 24,
                color: isSelected
                    ? Color(0xFF4B76D9)
                    : Colors.black.withOpacity(0.5),
              ),
              SizedBox(height: 4),
              Text(
                label,
                style: GoogleFonts.quicksand(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                  color: isSelected
                      ? Color(0xFF4B76D9)
                      : Colors.black.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
