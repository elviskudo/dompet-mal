// ignore_for_file: unused_field, file_names, use_key_in_widget_constructors, library_private_types_in_public_api
import 'package:dompet_mal/app/modules/home/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Bottombar extends StatefulWidget {
  @override
  _BottombarState createState() => _BottombarState();
}

class _BottombarState extends State<Bottombar> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  static final List<Widget> _pages = <Widget>[
    HomeView(),
    Center(child: Text('Donasiku')),
    Center(child: Text('Favorit')),
    Center(child: Text('Profile')),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border),
            label: 'Donasiku',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favorit',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF4B76D9),
        unselectedItemColor: Colors.black.withOpacity(0.5),
        onTap: _onItemTapped,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        iconSize: 30,
        selectedLabelStyle: GoogleFonts.quicksand(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        unselectedLabelStyle: GoogleFonts.quicksand(
          fontWeight: FontWeight.w600,
          color: Color(0xFF000000),
        ),
      ),
    );
  }
}
