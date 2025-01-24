import 'package:dompet_mal/app/modules/(admin)/charityAdmin/controllers/charity_admin_controller.dart';
import 'package:dompet_mal/component/bannerCategoryChoice.dart';
import 'package:dompet_mal/component/customAppBarCategory.dart';
import 'package:dompet_mal/models/Category.dart';
import 'package:dompet_mal/models/CharityModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListDonationView extends StatelessWidget {
  ListDonationView({super.key});

  // Use the CharityAdminController to fetch charities
  CharityAdminController charityController = Get.put(CharityAdminController());

  @override
  Widget build(BuildContext context) {
    final Category? categoryId = Get.arguments as Category?;

    return Scaffold(
      appBar: CustomAppBar(
        title: categoryId != null ? 'Donasi ${categoryId.name}' : 'Donasi',
        onSortPressed: () => showSortDialog(context),
        onFilterPressed: () => showSearchDialog(context),
      ),
      backgroundColor: Colors.white,
      body: Obx(() {
        // Check if charities are loading
        if (charityController.isCharitiesLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        // Filter charities if a category is selected
        final filteredCharities = categoryId?.id != null
            ? charityController.charities
                .where((charity) =>
                    charity.categoryId == categoryId!.id.toString())
                .toList()
            : charityController.charities;

        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsetsDirectional.all(24),
                child: filteredCharities.isEmpty
                    ? Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 100),
                          child: Text('Tidak ada data ditemukan'),
                        ),
                      )
                    : BannerKategori(
                        category: charityController.categories.value,
                        banners: filteredCharities,
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
