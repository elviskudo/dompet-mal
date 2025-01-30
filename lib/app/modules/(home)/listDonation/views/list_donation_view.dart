import 'package:dompet_mal/app/modules/(admin)/charityAdmin/controllers/charity_admin_controller.dart';
import 'package:dompet_mal/component/bannerCategoryChoice.dart';
import 'package:dompet_mal/component/customAppBarCategory.dart';
import 'package:dompet_mal/models/Category.dart';
import 'package:dompet_mal/models/CharityModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListDonationView extends StatelessWidget {
  final CharityAdminController charityController =
      Get.find<CharityAdminController>();
  final RxString searchTerm = ''.obs;

  ListDonationView({super.key});

  // Fungsi helper untuk mendapatkan nama kategori
  String? getCategoryName(String? categoryId) {
    return charityController.categories.value
        .firstWhereOrNull((cat) => cat.id.toString() == categoryId)
        ?.name;
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args = Get.arguments as Map<String, dynamic>?;
    final Category? category = args?['category'] as Category?;
    final String? searchText = args?['searchTerm'] as String?;

    if (searchText != null) {
      searchTerm.value = searchText;
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: category != null ? 'Donasi ${category.name}' : 'Donasi',
        onSortPressed: () => showSortDialog(context),
        onFilterPressed: () => showSearchDialog(context),
      ),
      backgroundColor: Colors.white,
      body: Obx(() {
        if (charityController.isCharitiesLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        List<Charity> filtered =
            List<Charity>.from(charityController.charities);

        // Apply category filter if category is selected
        if (category != null) {
          filtered = filtered
              .where((charity) => charity.categoryId == category.id.toString())
              .toList();
        }

        // Apply search term filter if search term exists
        if (searchTerm.value.isNotEmpty) {
          filtered = filtered.where((charity) {
            final String searchLower = searchTerm.value.toLowerCase();
            final String? title = charity.title?.toLowerCase();
            final String? categoryName =
                getCategoryName(charity.categoryId)?.toLowerCase();

            return (title?.contains(searchLower) ?? false) ||
                (categoryName?.contains(searchLower) ?? false);
          }).toList();
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              if (searchTerm.value.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Hasil pencarian untuk "${searchTerm.value}"',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              Container(
                padding: const EdgeInsetsDirectional.all(24),
                child: filtered.isEmpty
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 100),
                          child: Text('Tidak ada data ditemukan'),
                        ),
                      )
                    : BannerKategori(
                        category: charityController.categories.value,
                        banners: filtered,
                        maxItems: 0,
                      ),
              ),
            ],
          ),
        );
      }),
    );
  }

  void showSearchDialog(BuildContext context) {
    final RxList<Charity> filteredCharities =
        charityController.charities.obs as dynamic;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Material(
          type: MaterialType.transparency,
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 50),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              width: MediaQuery.of(context).size.width * 0.9,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    onChanged: (value) {
                      if (value.isEmpty) {
                        filteredCharities.value = charityController.charities;
                      } else {
                        filteredCharities.value = charityController.charities
                            .where((charity) =>
                                charity.title
                                    ?.toLowerCase()
                                    .contains(value.toLowerCase()) ??
                                false)
                            .toList();
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Cari Donasi',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void showSortDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Wrap(
          children: <Widget>[
            ListTile(
              title: Text('Urutkan'),
              tileColor: Colors.grey[200],
            ),
            ListTile(
                leading: Icon(Icons.arrow_upward),
                title: Text('Tanggal Terbaru'),
                onTap: () {
                  charityController.charities.sort((a, b) =>
                      (b.created_at ?? DateTime.now())
                          .compareTo(a.created_at ?? DateTime.now()));
                  Get.back();
                }),
            ListTile(
                leading: Icon(Icons.arrow_downward),
                title: Text('Tanggal Terlama'),
                onTap: () {
                  charityController.charities.sort((a, b) =>
                      (a.created_at ?? DateTime.now())
                          .compareTo(b.created_at ?? DateTime.now()));
                  Get.back();
                }),
            ListTile(
                leading: Icon(Icons.sort_by_alpha),
                title: Text('Nama A-Z'),
                onTap: () {
                  charityController.charities
                      .sort((a, b) => (a.title ?? '').compareTo(b.title ?? ''));
                  Get.back();
                }),
            ListTile(
                leading: Icon(Icons.sort_by_alpha),
                title: Text('Nama Z-A'),
                onTap: () {
                  charityController.charities
                      .sort((a, b) => (b.title ?? '').compareTo(a.title ?? ''));
                  Get.back();
                }),
          ],
        );
      },
    );
  }
}
