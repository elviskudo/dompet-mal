// admin_panel_controller.dart

import 'package:dompet_mal/app/modules/(admin)/admin_panel/controllers/admin_panel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminPanelView extends GetView<AdminPanelController> {
  const AdminPanelView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main Content
          _buildContent(controller.selectedIndex.value),

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
                        // Close button
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
        _buildMenuItem(1, 'Users', Icons.people),
        _buildMenuItem(2, 'Products', Icons.inventory),
        _buildMenuItem(3, 'Orders', Icons.shopping_cart),
        _buildMenuItem(4, 'Settings', Icons.settings),
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

  Widget _buildContent(int index) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(_getTitle(controller.selectedIndex.value))),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: _getPageContent(index),
      ),
    );
  }

  // ... rest of the content methods remain the same ...

  String _getTitle(int index) {
    switch (index) {
      case 0:
        return 'Dashboard';
      case 1:
        return 'Users';
      case 2:
        return 'Products';
      case 3:
        return 'Orders';
      case 4:
        return 'Settings';
      default:
        return 'Dashboard';
    }
  }

  Widget _getPageContent(int index) {
    switch (index) {
      case 0:
        return _buildDashboardContent();
      case 1:
        return _buildUsersContent();
      default:
        return Center(
          child: Text(
            'Content for ${_getTitle(index)}',
            style: const TextStyle(fontSize: 24),
          ),
        );
    }
  }

  Widget _buildDashboardContent() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: [
        _buildDashboardCard('Users', '1,234', Icons.people, Colors.blue),
        _buildDashboardCard('Products', '567', Icons.inventory, Colors.green),
        _buildDashboardCard('Orders', '89', Icons.shopping_cart, Colors.orange),
        _buildDashboardCard(
            'Revenue', '\$12,345', Icons.attach_money, Colors.purple),
      ],
    );
  }

  Widget _buildDashboardCard(
      String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: color),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                  fontSize: 24, color: color, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUsersContent() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Users Management',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Text('User list will be displayed here'),
      ],
    );
  }
}
