import 'package:dompet_mal/app/modules/(admin)/admin_panel/controllers/admin_panel_controller.dart';
import 'package:dompet_mal/app/modules/(admin)/categories/views/categories_view.dart';
import 'package:dompet_mal/app/modules/(admin)/list_user/controllers/list_user_controller.dart';
import 'package:dompet_mal/app/modules/(admin)/list_user/views/list_user_view.dart';
import 'package:dompet_mal/app/modules/(admin)/upload/controllers/upload_controller.dart';
import 'package:dompet_mal/app/modules/(admin)/upload/views/upload_view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class AdminPanelView extends GetView<AdminPanelController> {
  const AdminPanelView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ListUserController());
    Get.put(UploadController());
    return Scaffold(
      body: Stack(
        children: [
          // Main Content
          Obx(() => _getPage(controller.selectedIndex.value)),

          // Menu Button
          Positioned(
            top: 20,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.more_horiz),
              onPressed: controller.toggleSidebar,
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
                    color: Colors.blue,
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: const Icon(Icons.close, color: Colors.white),
                            onPressed: controller.closeSidebar,
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
          child: Icon(Icons.person, size: 40, color: Colors.blue),
        ),
        const SizedBox(height: 20),
        const Text(
          'Admin Panel',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 30),
        _buildMenuItem(0, 'Dashboard', Icons.dashboard),
        _buildMenuItem(1, 'Category', Icons.people),
        _buildMenuItem(2, 'Upload', Icons.camera),
      ],
    );
  }

  Widget _buildMenuItem(int index, String title, IconData icon) {
    return Obx(() => ListTile(
          leading: Icon(
            icon,
            color: controller.selectedIndex.value == index
                ? Colors.white
                : Colors.white70,
          ),
          title: Text(
            title,
            style: TextStyle(
              color: controller.selectedIndex.value == index
                  ? Colors.white
                  : Colors.white70,
              fontWeight: controller.selectedIndex.value == index
                  ? FontWeight.bold
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
      default:
        return ListUserView();
    }
  }
}
