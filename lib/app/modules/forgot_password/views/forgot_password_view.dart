import 'package:dompet_mal/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    final isEmailValid = false.obs;
    var lebar = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back),
          ),
          title: Text('Lupa Kata Sandi',
              style: GoogleFonts.openSans(
                  fontWeight: FontWeight.w600, fontSize: 18)),
        ),
        body: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: lebar,
                height: 226,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/bgFg.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Masukan Email anda',
                    style: GoogleFonts.openSans(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Gap(19),
                  Text('Email',
                      style: GoogleFonts.openSans(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600)),
                  Gap(8),
                  TextField(
                    controller: controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: controller.validateEmail,
                    decoration: InputDecoration(
                      hintText: 'email@gmail.com',
                      hintStyle: GoogleFonts.montserratAlternates(
                          fontSize: 14,
                          color: Color(0xFFC7C9D9),
                          fontWeight: FontWeight.w400),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Color(0xFFC7C9D9).withOpacity(0.5),
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  Gap(28),
                  Obx(() => ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: controller.isEmailValid.value
                              ? const Color(0xFF4B76D9)
                              : const Color(0xFFD0D0D0),
                          minimumSize: const Size(double.infinity, 45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: controller.isEmailValid.value
                            ? controller.submitForgotPassword
                            : null,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: controller.isLoading.value
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text(
                                  'Ubah kata sandi',
                                  style: GoogleFonts.openSans(
                                      color: controller.isEmailValid.value
                                          ? Colors.white
                                          : const Color(0xFF6A6A6A),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                        ),
                      )),
                ],
              ),
            ),
          ],
        ));
  }
}
