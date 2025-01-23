import 'package:dompet_mal/color/color.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showFilterButtons;
  final Function()? onBackPressed;
  final Function()? onSortPressed;
  final Function()? onFilterPressed;

  CustomAppBar({
    required this.title,
    this.showFilterButtons = true,
    this.onBackPressed,
    this.onSortPressed,
    this.onFilterPressed,
  });
  @override
  Size get preferredSize => Size.fromHeight(130);

  @override
  Widget build(BuildContext context) {
    var lebar = MediaQuery.of(context).size.width;
    return AppBar(
      // automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      // elevation: 0,
      // titleSpacing: 0,
      // leading: IconButton(
      //   icon: Icon(Icons.arrow_back, color: Colors.black),
      //   onPressed: () => Navigator.pop(context),
      // ),
      title: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.withOpacity(0.2),
                width: 3,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Button_filter(lebar, 'assets/icons/icon_sort.png', 'Urutkan',
                  onSortPressed),
              Button_filter(lebar, 'assets/icons/icon_filter.png', 'Filter',
                  onFilterPressed),
            ],
          ),
        ),
      ),
    );
  }

  Container Button_filter(
      double lebar, String img, String name, Function()? onFilterPressed) {
    return Container(
      width: lebar * 0.25,
      child: OutlinedButton(
        onPressed: onFilterPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              img, // Path gambar PNG Anda
              width: 18,
              height: 18,
            ),
            SizedBox(width: 8), // Jarak antara gambar dan teks
            Text(
              name,
              style: TextStyle(
                color: secondary,
                fontSize: 14,
              ),
            ),
          ],
        ),
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          side: BorderSide(color: secondary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
