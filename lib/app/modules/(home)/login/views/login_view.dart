import 'package:dompet_mal/color/color.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/login_controller.dart';
import 'package:dompet_mal/app/routes/app_pages.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    var lebar = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: lebar,
                  height: 226,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/bgLogin.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: lebar,
                  height: 500,
                  color: Colors.white,
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('assets/icons/X.png'),
                      TextButton(
                        onPressed: () {
                          Get.toNamed(Routes.REGISTER);
                        },
                        child: Text(
                          'Daftar',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: basecolor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(22),
                  Center(
                    child: Image.asset('assets/images/logoLogin.png'),
                  ),
                  Gap(40),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black87,
                          minimumSize: Size(double.infinity, 45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                        onPressed: () => controller.signInWithGoogle(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/icons/google.png', height: 24),
                              Gap(8),
                              Text(
                                'Masuk dengan akun Google',
                                style: GoogleFonts.openSans(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF313036),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Gap(26),
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.grey.shade300,
                              thickness: 1,
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.grey.shade300,
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                      Gap(26),
                      Text('Email',
                          style: GoogleFonts.openSans(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w600)),
                      Gap(8),
                      TextField(
                        controller: controller.emailC,
                        keyboardType: TextInputType.emailAddress,
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
                      Gap(20),
                      Text('Kata Sandi',
                          style: GoogleFonts.openSans(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w600)),
                      Gap(8),
                      Obx(() => TextField(
                            controller: controller.passC,
                            obscureText: controller.isPasswordHidden.value,
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
                                icon: Icon(controller.isPasswordHidden.value
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: controller.togglePasswordVisibility,
                              ),
                            ),
                          )),
                      Gap(32),
                      Obx(() => ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF4B76D9),
                              minimumSize: Size(double.infinity, 45),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: controller.isLoading.value
                                ? null
                                : controller.login,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15),
                              child: controller.isLoading.value
                                  ? SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Text(
                                      'MASUK',
                                      style: GoogleFonts.openSans(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                            ),
                          )),
                      Gap(36),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Get.toNamed(Routes.FORGOT_PASSWORD);
                          },
                          child: Text(
                            'Lupa kata sandi?',
                            style: GoogleFonts.openSans(
                              fontSize: 16,
                              color: Color(0xFF4B76D9),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Gap(52),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Belum punya akun? ',
                              style: GoogleFonts.openSans(
                                  fontSize: 14,
                                  color: Colors.grey.shade500,
                                  fontWeight: FontWeight.w400)),
                          TextButton(
                            onPressed: () {
                              Get.toNamed(Routes.REGISTER);
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text('DAFTAR',
                                style: GoogleFonts.openSans(
                                    fontSize: 14,
                                    color: Color(0xFF4B76D9),
                                    fontWeight: FontWeight.w700)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
