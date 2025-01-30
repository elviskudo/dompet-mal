import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/reset_pass_controller.dart';

class ResetPassView extends GetView<ResetPassController> {
  const ResetPassView({super.key});
  @override
  Widget build(BuildContext context) {
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
                  image: AssetImage('assets/images/bgFg.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Tentukan kata sandi baru untuk keamanan akun anda',
                      style: GoogleFonts.openSans(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  Gap(18),
                  Text('Kata Sandi',
                      style: GoogleFonts.openSans(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600)),
                  Gap(8),
                  Obx(() => TextFormField(
                        controller: controller.passwordController,
                        onChanged: (value) => controller.validateInputs(),
                        obscureText: controller.isPasswordHidden.value,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password tidak boleh kosong';
                          }
                          if (value.length < 6) {
                            return 'Password minimal 6 karakter';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Masukan 8 karakter',
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
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isPasswordHidden.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: controller.togglePasswordVisibility,
                          ),
                        ),
                      )),
                  Gap(17),
                  Text('Konfirmasi Kata Sandi',
                      style: GoogleFonts.openSans(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600)),
                  Gap(8),
                  Obx(() => TextFormField(
                        controller: controller.confirmPasswordController,
                        onChanged: (value) => controller.validateInputs(),
                        obscureText: controller.isConfirmPasswordHidden.value,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Konfirmasi password tidak boleh kosong';
                          }
                          if (value != controller.passwordController.text) {
                            return 'Password tidak sama';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Masukan 8 karakter',
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
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isConfirmPasswordHidden.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed:
                                controller.toggleConfirmPasswordVisibility,
                          ),
                        ),
                      )),
                  Gap(28),
                  Obx(() => SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff4B76D9),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            disabledBackgroundColor: Colors.grey,
                          ),
                          onPressed: controller.isFormValid.value
                              ? () {
                                  if (controller.formKey.currentState!
                                      .validate()) {
                                    controller.saveNewPassword();
                                  }
                                }
                              : null,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 138, vertical: 15),
                            child: Text('Simpan',
                                style: GoogleFonts.openSans(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white)),
                          ),
                        ),
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
