import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/charity_admin_controller.dart';

class CharityAdminView extends GetView<CharityAdminController> {
  const CharityAdminView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CharityAdminView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CharityAdminView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
