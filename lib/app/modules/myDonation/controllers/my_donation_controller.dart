import 'package:dompet_mal/app/modules/routes/app_pages.dart';
import 'package:dompet_mal/models/pilihanKategoriModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDonationController extends GetxController {
  final count = 0.obs;
  var charities = <CharityByCategory>[].obs;
  var filteredCharities = <CharityByCategory>[].obs;
  var selectedSortOption = 'Terbaru'.obs;

  // List of sorting options
  final List<String> sortOptions = [
    'Terbaru',
    'Terlama',
    'Terbesar',
    'Terbanyak',
    'Progress'
  ];

  @override
  void onInit() {
    super.onInit();
    if (dummyDataListCategoryBanner != null) {
      initCharities(dummyDataListCategoryBanner);
    }
  }

  void initCharities(List<CharityByCategory> initialData) {
    charities.value = initialData;
    filteredCharities.value = initialData;
  }

  void sortCharities(String option) {
    selectedSortOption.value = option;

    switch (option) {
      case 'Terbaru':
        filteredCharities.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;

      case 'Terlama':
        filteredCharities.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        break;

      case 'Terbesar':
        filteredCharities.sort((a, b) =>
            b.targetCharityDonation.compareTo(a.targetCharityDonation));
        break;

      case 'Terbanyak':
        filteredCharities
            .sort((a, b) => b.totalCharities.compareTo(a.totalCharities));
        break;

      case 'Progress':
        filteredCharities.sort((a, b) => b.progress.compareTo(a.progress));
        break;
    }

    filteredCharities.refresh();
  }

  void filterCharities(String query) {
    try {
      if (query.isEmpty) {
        filteredCharities.value = charities;
      } else {
        filteredCharities.value = charities
            .where((charity) =>
                charity.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
      sortCharities(selectedSortOption.value);
    } catch (e) {
      print('Error filtering charities: $e');
      filteredCharities.value = charities;
    }
  }

  void showSortDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext bc) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 16),
                width: 40,
                child: Divider(
                  thickness: 4,
                  color: Colors.grey[300],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Text(
                      'Urutkan',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              ...sortOptions
                  .map((option) => ListTile(
                        leading: Obx(() => Radio<String>(
                              value: option,
                              groupValue: selectedSortOption.value,
                              onChanged: (value) {
                                if (value != null) {
                                  sortCharities(value);
                                  Get.back();
                                }
                              },
                            )),
                        title: Text(option),
                        onTap: () {
                          sortCharities(option);
                          Get.back();
                        },
                      ))
                  .toList(),
            ],
          ),
        );
      },
    );
  }

  void showSearchDialog(BuildContext context) {
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
                    onChanged: filterCharities,
                    decoration: InputDecoration(
                      labelText: 'Cari Donasi',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  Obx(
                    () => ListView.builder(
                      shrinkWrap: true,
                      itemCount: filteredCharities.length,
                      itemBuilder: (context, index) {
                        final charity = filteredCharities[index];
                        return ListTile(
                          title: Text(charity.title),
                          onTap: () {
                            Get.back(); // Tutup dialog search
                            // Navigasi ke halaman detail dengan data charity yang dipilih
                            Get.toNamed(Routes.DONATION_DETAIL_PAGE,
                                arguments: charity);
                          },
                        );
                      },
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

  void increment() => count.value++;
}
