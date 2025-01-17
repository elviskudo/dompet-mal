import 'package:dompet_mal/app/routes/app_pages.dart';
import 'package:dompet_mal/component/AppBar.dart';
import 'package:dompet_mal/models/pilihanKategoriModel.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/category_controller.dart';

class CategoryView extends GetView<CategoryController> {
  CategoryView({super.key});

  void handleCategoryTap(int index) {
    Category selectedCategory = categories[index];
    print('dadada ${selectedCategory.id}');
    print('dadada ${selectedCategory.name}');
    Get.toNamed(Routes.ListDonation, arguments: selectedCategory);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar2(
        title: 'Category',
        color: Colors.white,
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 0.8,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  Get.toNamed(Routes.ListDonation,
                      arguments: categories[index]);
                },
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(
                        0.1), // Anda bisa menambahkan logika untuk mengganti warna berdasarkan kategori
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.asset(
                    categories[index].categoryImage,
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text(
                categories[index].name,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 10,
                  overflow: TextOverflow.ellipsis,

                  // height: 1.2,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
