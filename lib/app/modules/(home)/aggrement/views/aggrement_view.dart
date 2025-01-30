import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/aggrement_controller.dart';

class AggrementView extends GetView<AggrementController> {
  const AggrementView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AggrementView'),
        centerTitle: true,
      ),
      body:  Center(
        child: Text(
          'AggrementView is working',
          style: GoogleFonts.poppins(fontSize: 20),
        ),
      ),
    );
  }
}
