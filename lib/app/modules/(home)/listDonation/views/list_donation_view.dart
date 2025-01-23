import 'package:dompet_mal/component/bannerCategoryChoice.dart';
import 'package:dompet_mal/component/customAppBarCategory.dart';
import 'package:dompet_mal/models/pilihanKategoriModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListDonationView extends StatelessWidget {
  ListDonationView({super.key});

  // Menggunakan RxList langsung di view
  final RxList<CharityByCategory> charities = dummyDataListCategoryBanner.obs;
  final RxList<CharityByCategory> filteredCharities = <CharityByCategory>[].obs;

  // Dialog functions
  void showSearchDialog(BuildContext context,
      List<CharityByCategory> currentCharities, Category? categoryId) {
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
                        if (categoryId?.id != null) {
                          filteredCharities.value = currentCharities
                              .where((charity) =>
                                  charity.category.id == categoryId!.id)
                              .toList();
                        } else {
                          filteredCharities.value = currentCharities;
                        }
                      } else {
                        var filtered = currentCharities.where((charity) =>
                            charity.title
                                .toLowerCase()
                                .contains(value.toLowerCase()));

                        if (categoryId?.id != null) {
                          filtered = filtered.where((charity) =>
                              charity.category.id == categoryId?.id);
                        }

                        filteredCharities.value = filtered.toList();
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
                  filteredCharities.sort((a, b) {
                    DateTime dateA = DateTime.parse(a.createdAt.toString());
                    DateTime dateB = DateTime.parse(b.createdAt.toString());
                    return dateB.compareTo(dateA);
                  });
                  Get.back();
                }),
            ListTile(
                leading: Icon(Icons.arrow_downward),
                title: Text('Tanggal Terlama'),
                onTap: () {
                  filteredCharities.sort((a, b) {
                    DateTime dateA = DateTime.parse(a.createdAt.toString());
                    DateTime dateB = DateTime.parse(b.createdAt.toString());
                    return dateA.compareTo(dateB);
                  });
                  Get.back();
                }),
            ListTile(
                leading: Icon(Icons.sort_by_alpha),
                title: Text('Nama A-Z'),
                onTap: () {
                  filteredCharities.sort((a, b) => a.title.compareTo(b.title));
                  Get.back();
                }),
            ListTile(
                leading: Icon(Icons.sort_by_alpha),
                title: Text('Nama Z-A'),
                onTap: () {
                  filteredCharities.sort((a, b) => b.title.compareTo(a.title));
                  Get.back();
                }),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Category? categoryId = Get.arguments as Category?;

    // Initial filtering
    if (categoryId?.id != null) {
      filteredCharities.value = charities
          .where((charity) => charity.category.id == categoryId!.id)
          .toList();
    } else {
      filteredCharities.value = charities;
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: categoryId != null ? 'Donasi ${categoryId.name}' : 'Donasi',
        onSortPressed: () => showSortDialog(context),
        onFilterPressed: () => showSearchDialog(context, charities, categoryId),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsetsDirectional.all(24),
              child: Obx(() {
                if (filteredCharities.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 100),
                      child: Text('Tidak ada data ditemukan'),
                    ),
                  );
                }
                return BannerKategori(
                  banners: filteredCharities,
                  maxItems: 0,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
