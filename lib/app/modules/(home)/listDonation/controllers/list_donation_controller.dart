import 'package:dompet_mal/models/pilihanKategoriModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListDonationController extends GetxController {
  // Observable variables
   RxList<CharityByCategory> charities = <CharityByCategory>[].obs;
  RxList<CharityByCategory> filteredCharities = <CharityByCategory>[].obs;
  var sortAscending = true.obs;
  final count = 0.obs;
  final categoryId = Get.arguments;

  @override
  void onInit() {
    super.onInit();
    // Initialize data only once
    print('Initializing with category ID: $categoryId');

    initializeData();
  }
  

  void initializeData() {
    charities.value = dummyDataListCategoryBanner;

    // Get category ID from arguments
    print('Initializing with category ID: $categoryId');

    if (categoryId != null) {
      // Filter by category if ID is provided
      filterByCategory(categoryId);
    } else {
      // Show all charities if no category ID
      filteredCharities.value = charities;
    }
  }

  void filterByCategory(int categoryId) {
    print('Filtering for category ID: $categoryId');
    if (charities.isNotEmpty) {
      filteredCharities.value = charities.where((charity) {
        print('Charity ID: ${charity.id}, Category ID: ${charity.category.id}');
        return charity.category.id == categoryId;
      }).toList();
      print(
          'Found ${filteredCharities.length} charities for category $categoryId');
    }
  }

  // Sort functions
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

  // Search function
  void filterCharities(String query) {
    try {
      if (query.isEmpty) {
        // If query is empty, show all charities for current category
        final categoryId = Get.arguments;
        if (categoryId != null) {
          filterByCategory(categoryId);
        } else {
          filteredCharities.value = charities;
        }
      } else {
        // Filter by query within current category
        final currentCategory = Get.arguments;
        var filtered = charities.where((charity) =>
            charity.title.toLowerCase().contains(query.toLowerCase()));

        if (currentCategory != null) {
          filtered = filtered
              .where((charity) => charity.category.id == currentCategory);
        }

        filteredCharities.value = filtered.toList();
      }
    } catch (e) {
      print('Error filtering charities: $e');
      filteredCharities.value = charities;
    }
  }

  // Dialog functions
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

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
