import 'package:dompet_mal/app/modules/(admin)/categories/controllers/categories_controller.dart';
import 'package:dompet_mal/app/modules/(admin)/charityAdmin/controllers/charity_admin_controller.dart';
import 'package:dompet_mal/app/modules/(home)/listDonation/views/list_donation_view.dart';
import 'package:dompet_mal/app/routes/app_pages.dart';
import 'package:dompet_mal/component/animatedSearchHint.dart';
import 'package:dompet_mal/models/Category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// First, modify the SearchBars class to handle both title and category searches
class SearchBars extends StatelessWidget {
  final TextEditingController controller;
  final CategoriesController categoriesController =
      Get.put<CategoriesController>(CategoriesController());
  final CharityAdminController charityController =
      Get.put<CharityAdminController>(CharityAdminController());

  SearchBars({
    super.key,
    required this.controller,
  });

  void handleSearch(String searchTerm) {
    if (searchTerm.isEmpty) return;

    // First, try to find a matching category
    final category = findCategoryByTitle(searchTerm);

    if (category != null) {
      // If category is found, navigate to ListDonation with category filter
      Get.toNamed(Routes.ListDonation, arguments: {
        'category': category,
        'searchTerm': searchTerm,
      });
    } else {
      // If no category found, search by title
      Get.toNamed(Routes.ListDonation, arguments: {
        'searchTerm': searchTerm,
      });
    }
  }

  Category? findCategoryByTitle(String title) {
    try {
      return categoriesController.categories.firstWhereOrNull(
        (category) =>
            category.name!.toLowerCase().contains(title.toLowerCase()),
      );
    } catch (e) {
      print('Error finding category: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: 54,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              spreadRadius: 0.5,
            ),
          ],
        ),
        child: Center(
          child: TextField(
            controller: controller,
            onSubmitted: handleSearch,
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: Container(
                  padding: EdgeInsets.all(4),
                  margin: EdgeInsets.only(right: 6),
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: Color(0xffE9EFFF),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: InkWell(
                      onTap: () => handleSearch(controller.text),
                      child: Image.asset(
                        'assets/icons/search.png',
                        width: 24,
                        color: Colors.black,
                        height: 24,
                      ),
                    ),
                  ),
                ),
              ),
              hintText: 'Cari berdasarkan kategori atau judul donasi',
              hintStyle: GoogleFonts.poppins(
                color: Colors.grey[400],
                fontSize: 14,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16.0,
              ),
              label: AnimatedSearchHint(
                hintTexts: const [
                  'kemanusiaan',
                  'bencana alam',
                  'pendidikan',
                  'kesehatan',
                  // Add more hint texts as needed
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
