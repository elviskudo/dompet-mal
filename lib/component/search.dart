import 'package:dompet_mal/app/modules/(admin)/categories/controllers/categories_controller.dart';
import 'package:dompet_mal/app/modules/(admin)/charityAdmin/controllers/charity_admin_controller.dart';
import 'package:dompet_mal/app/routes/app_pages.dart';
import 'package:dompet_mal/component/animatedSearchHint.dart';
import 'package:dompet_mal/models/Category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchBars extends StatefulWidget {
  final TextEditingController controller;

  const SearchBars({
    super.key,
    required this.controller,
  });

  @override
  State<SearchBars> createState() => _SearchBarsState();
}

class _SearchBarsState extends State<SearchBars> {
  final FocusNode _focusNode = FocusNode();
  final CategoriesController categoriesController =
      Get.put<CategoriesController>(CategoriesController());

  final CharityAdminController charityController =
      Get.put<CharityAdminController>(CharityAdminController());
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  void handleSearch(String searchTerm) {
    if (searchTerm.isEmpty) return;

    final category = findCategoryByTitle(searchTerm);

    if (category != null) {
      Get.toNamed(Routes.ListDonation, arguments: {
        'category': category,
        'searchTerm': searchTerm,
      });
    } else {
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
            controller: widget.controller,
            focusNode: _focusNode,
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
                      onTap: () => handleSearch(widget.controller.text),
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
              hintStyle: GoogleFonts.poppins(
                color: Colors.grey[400],
                fontSize: 14,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16.0,
              ),
              label: (!_isFocused && widget.controller.text.isEmpty)
                  ? AnimatedSearchHint(
                      hintTexts: const [
                        'kemanusiaan',
                        'bencana alam',
                        'pendidikan',
                        'kesehatan',
                      ],
                    )
                  : null,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }
}
