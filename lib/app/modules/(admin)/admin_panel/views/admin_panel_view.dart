import 'package:dompet_mal/app/modules/(admin)/admin_panel/controllers/admin_panel_controller.dart';
import 'package:dompet_mal/app/modules/(admin)/categories/controllers/categories_controller.dart';
import 'package:dompet_mal/app/modules/(admin)/categories/views/categories_view.dart';
import 'package:dompet_mal/app/modules/(admin)/companies/views/companies_view.dart';
import 'package:dompet_mal/app/modules/(admin)/list_user/controllers/list_user_controller.dart';
import 'package:dompet_mal/app/modules/(admin)/list_user/views/list_user_view.dart';
import 'package:dompet_mal/app/modules/(admin)/transactions/controllers/transactions_controller.dart';
import 'package:dompet_mal/app/modules/(admin)/transactions/views/transactions_view.dart';
import 'package:dompet_mal/app/modules/(admin)/upload/controllers/upload_controller.dart';
import 'package:dompet_mal/app/modules/(admin)/upload/views/upload_view.dart';
import 'package:dompet_mal/app/modules/charityAdmin/controllers/charity_admin_controller.dart';
import 'package:dompet_mal/app/modules/charityAdmin/views/charity_admin_view.dart';
import 'package:dompet_mal/app/modules/contributorAdmin/controllers/contributor_admin_controller.dart';
import 'package:dompet_mal/app/modules/contributorAdmin/views/contributor_admin_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminPanelView extends GetView<AdminPanelController> {
  const AdminPanelView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ListUserController());
    Get.put(UploadController());
    Get.put(CategoriesController());
    Get.put(ContributorAdminController());
    Get.put(TransactionsController());
    Get.put(CharityAdminController());
    return Scaffold(
      body: Stack(
        children: [
          // Main Content
          Obx(() {
            return Container(
              padding: EdgeInsets.only(top: 84, left: 16, right: 16),
              child: _getPage(controller.selectedIndex.value),
            );
          }),

          // Menu Button
          Positioned(
            top: 20,
            left: 28,
            child: Row(
              children: [
                Tooltip(
                  message: 'Menu',
                  child: InkWell(
                    onTap: controller.toggleSidebar,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white, // Warna latar belakang
                        borderRadius:
                            BorderRadius.circular(8), // Membuat sudut membulat
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.black.withOpacity(0.2), // Warna bayangan
                            blurRadius: 6, // Tingkat blur bayangan
                            offset: const Offset(0, 3), // Offset bayangan
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.menu, // Ikon hamburger (garis tiga)
                        size: 28,
                        color: Colors.black87, // Warna ikon
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12), // Spasi antara ikon dan teks
                Obx(
                  () => Text(
                    "Welcome, ${controller.username.value}",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87, // Warna teks
                    ),
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            top: 20,
            right: 28, // Menggunakan posisi dari kanan
            child: Tooltip(
              message: 'Logout',
              child: InkWell(
                onTap: controller.logout, // Fungsi logout
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white, // Warna latar belakang
                    borderRadius:
                        BorderRadius.circular(8), // Membuat sudut membulat
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2), // Warna bayangan
                        blurRadius: 6, // Tingkat blur bayangan
                        offset: const Offset(0, 3), // Offset bayangan
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.logout, // Ikon logout
                    size: 28,
                    color: Colors.black87, // Warna ikon
                  ),
                ),
              ),
            ),
          ),

          // Overlay for clicking outside to close
          Obx(() => controller.isSidebarVisible.value
              ? GestureDetector(
                  onTap: controller.closeSidebar,
                  child: Container(
                    color: Colors.black54,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                )
              : const SizedBox()),

          // Sidebar
          Obx(() => AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                left: controller.isSidebarVisible.value ? 0 : -250,
                top: 0,
                bottom: 0,
                width: 250,
                child: Material(
                  elevation: 16,
                  child: Container(
                    // color: Colors.blue,
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: const Icon(Icons.close,
                                  color: Colors.black87),
                              onPressed: controller.closeSidebar,
                            ),
                          ),
                        ),
                        _buildSidebarContent(),
                      ],
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildSidebarContent() {
    return Column(
      children: [
        const CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white,
          child: Icon(Icons.person, size: 40, color: Colors.black87),
        ),
        const SizedBox(height: 20),
        Text(
          'Admin Panel',
          style: GoogleFonts.poppins(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 30),
        _buildMenuItem(0, 'Dashboard', Icons.dashboard),
        _buildMenuItem(1, 'Category', Icons.people),
        _buildMenuItem(2, 'Upload', Icons.camera),
        _buildMenuItem(3, 'Companies', Icons.compare_rounded),
        _buildMenuItem(4, 'Contributor', Icons.shape_line),
        _buildMenuItem(5, 'Charity', Icons.health_and_safety_sharp),
        _buildMenuItem(6, 'Transaction', Icons.wallet),
      ],
    );
  }

  Widget _buildMenuItem(int index, String title, IconData icon) {
    return Obx(() => ListTile(
          leading: Icon(
            icon,
            color: controller.selectedIndex.value == index
                ? Colors.black87
                : Colors.black87,
          ),
          title: Text(
            title,
            style: GoogleFonts.poppins(
              color: controller.selectedIndex.value == index
                  ? Colors.black87
                  : Colors.black87,
              fontWeight: controller.selectedIndex.value == index
                  ? FontWeight.w500
                  : FontWeight.normal,
            ),
          ),
          onTap: () => controller.changeIndex(index),
        ));
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return ListUserView();
      case 1:
        return const CategoriesView();
      case 2:
        return const UploadView();
      case 3:
        return CompaniesView();
      case 4:
        return ContributorAdminView();
      case 5:
        return CharityAdminView();
      case 6:
        return TransactionsView();
      default:
        return ListUserView();
    }
  }
}
