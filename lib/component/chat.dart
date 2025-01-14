import 'package:dompet_mal/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class chat extends StatelessWidget {
  const chat({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(Routes.MESSAGE),
      child: Image.asset('images/chat.png'),
    );
  }
}
