import 'package:dompet_mal/app/modules/(admin)/categories/controllers/categories_controller.dart';
import 'package:dompet_mal/app/routes/app_pages.dart';
import 'package:dompet_mal/models/Category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CATEGORYGrid extends StatelessWidget {
  final CategoriesController categoriesController =
      Get.put(CategoriesController());

  CATEGORYGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Check if categories are loaded
      if (categoriesController.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }

      // Get first 4 categories
      List<Category> displayCategories =
          categoriesController.categories.value.take(4).toList();

      print('displayCategories: $displayCategories');

      return Container(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display categories
            ...List.generate(
              displayCategories.length,
              (index) {
                Category category = displayCategories[index];
                return InkWell(
                  onTap: () {
                    Get.toNamed(Routes.ListDonation, arguments: category);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Image.network(
                          category.imageUrl ??
                              'https://res.cloudinary.com/dcthljxbl/image/upload/v1737531459/avinntuzxcc9kfrgsahx.png',
                          width: 30,
                          height: 30,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                                'assets/images/default_category.png',
                                width: 30,
                                height: 30);
                          },
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        width: 57,
                        child: Text(
                          category.name ?? 'No Name',
                          maxLines: 3,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            overflow: TextOverflow.ellipsis,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            // "View All" button
            InkWell(
              onTap: () {
                Get.toNamed(Routes.CATEGORY);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.view_list,
                      size: 24,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: 55,
                    child: Text(
                      "Lihat Semua",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        height: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
