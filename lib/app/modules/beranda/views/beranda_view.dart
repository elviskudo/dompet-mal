import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/beranda_controller.dart';

class BerandaView extends GetView<BerandaController> {
  const BerandaView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BerandaView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'BerandaView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
