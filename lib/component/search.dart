import 'package:dompet_mal/app/modules/listDonation/views/list_donation_view.dart';
import 'package:dompet_mal/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchBars extends StatelessWidget {
  final TextEditingController controller;

  const SearchBars({
    super.key,
    required this.controller,
  });

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
            onSubmitted: (value) {
              // Navigate to ListDonationView with search query
              Get.toNamed(Routes.ListDonation, arguments: value);
            },
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6.0, vertical: 0),
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
                    hoverColor: Colors.black45,
                    onTap: () {},
                    child: Image.asset(
                      'icons/search.png',
                      width: 24,
                      color: Colors.black,
                      height: 24,
                    ),
                  )),
                ),
              ),
              hintText: 'Coba cari "Bencana Alam"',
              hintStyle: TextStyle(
                color: Colors.grey[400],
                fontSize: 14,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16.0,
              ),
            ),
            textAlignVertical: TextAlignVertical.center,
          ),
        ),
      ),
    );
  }
}
