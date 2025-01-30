import 'package:dompet_mal/app/routes/app_pages.dart';
import 'package:dompet_mal/models/pilihanKategoriModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDonationController extends GetxController {
  //TODO: Implement MyDonationController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();

    if (dummyDataListCategoryBanner != null) {
      initCharities(dummyDataListCategoryBanner);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  var charities = <CharityByCategory>[].obs;
  var filteredCharities = <CharityByCategory>[].obs;
  var sortAscending = true.obs;

  void initCharities(List<CharityByCategory> initialData) {
    charities.value = initialData;
    filteredCharities.value = initialData;
  }

  void sortByDate(bool ascending) {
    filteredCharities.sort((a, b) {
      DateTime dateA = DateTime.parse(a.createdAt.toString());
      DateTime dateB = DateTime.parse(b.createdAt.toString());
      return ascending ? dateA.compareTo(dateB) : dateB.compareTo(dateA);
    });
    filteredCharities.refresh();
  }

  void sortByTitle(bool ascending) {
    filteredCharities.sort((a, b) {
      return ascending
          ? a.title.compareTo(b.title)
          : b.title.compareTo(a.title);
    });
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
    } catch (e) {
      print('Error filtering charities: $e');
      filteredCharities.value = charities;
    }
  }

  void navigateToCharity(CharityByCategory charity) {
    // Navigasi ke halaman detail donasi
    Get.toNamed(Routes.DONATION_DETAIL_PAGE, arguments: charity);
    // atau jika menggunakan Routes
    // Get.toNamed(Routes.DONATION_DETAIL, arguments: charity);
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
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.7),
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
                  Expanded(
                    child: Obx(() => ListView.builder(
                          shrinkWrap: true,
                          itemCount: filteredCharities.length,
                          itemBuilder: (context, index) {
                            final charity = filteredCharities[index];
                            return ListTile(
                              title: Text(charity.title),
                              onTap: () {
                                Get.back(); // Tutup dialog
                                navigateToCharity(
                                    charity); // Navigasi ke detail
                              },
                            );
                          },
                        )),
                  ),
                  if (filteredCharities.isEmpty)
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Tidak ada hasil yang ditemukan',
                        style: GoogleFonts.poppins(color: Colors.grey),
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
                  sortByDate(false);
                  Get.back();
                }),
            ListTile(
                leading: Icon(Icons.arrow_downward),
                title: Text('Tanggal Terlama'),
                onTap: () {
                  sortByDate(true);
                  Get.back();
                }),
            ListTile(
                leading: Icon(Icons.sort_by_alpha),
                title: Text('Nama A-Z'),
                onTap: () {
                  sortByTitle(true);
                  Get.back();
                }),
            ListTile(
                leading: Icon(Icons.sort_by_alpha),
                title: Text('Nama Z-A'),
                onTap: () {
                  sortByTitle(false);
                  Get.back();
                }),
          ],
        );
      },
    );
  }

  // void increment() => count.value++;
}
