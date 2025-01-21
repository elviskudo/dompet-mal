import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/quran_controller.dart';

class QuranView extends GetView<QuranController> {
  const QuranView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QuranView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'QuranView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
