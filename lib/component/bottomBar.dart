// ignore_for_file: unused_field, file_names, use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:dompet_mal/app/modules/home/views/home_view.dart';
import 'package:dompet_mal/app/modules/profile/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Bottombar extends StatefulWidget {
  @override
  _BottombarState createState() => _BottombarState();
}

class _BottombarState extends State<Bottombar> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    HomeView(),
    Center(child: Text('Donasiku')),
    Center(child: Text('Favorit')),
    ProfileView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.white,
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
