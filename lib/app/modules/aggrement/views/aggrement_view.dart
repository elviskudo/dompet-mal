import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/aggrement_controller.dart';

class AggrementView extends GetView<AggrementController> {
  const AggrementView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AggrementView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AggrementView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
