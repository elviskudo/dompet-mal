import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/quran_controller.dart';

class QuranView extends GetView<QuranController> {
  const QuranView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QuranView'),
        centerTitle: true,
      ),
      body:  Center(
        child: Text(
          'QuranView is working',
          style: GoogleFonts.poppins(fontSize: 20),
        ),
      ),
    );
  }
}
