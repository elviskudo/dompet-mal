import 'package:dompet_mal/models/pilihanKategoriModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

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

  void showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true, // Klik di luar dialog untuk menutup
      builder: (BuildContext context) {
        return Material(
          // Tambahkan widget Material di sini
          type: MaterialType.transparency, // Material transparan
          child: Align(
            alignment: Alignment.topCenter, // Posisi di atas
            child: Container(
              margin: EdgeInsets.only(top: 50), // Jarak dari atas
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
              width: MediaQuery.of(context).size.width * 0.9, // Lebar 90% layar
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    onChanged: (value) {
                      filterCharities(value);
                    },
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
                        return ListTile(
                          title: Text(filteredCharities[index].title),
                          onTap: () {
                            Get.back();
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

  void increment() => count.value++;
}
