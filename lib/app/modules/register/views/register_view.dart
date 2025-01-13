import 'package:dompet_mal/app/modules/routes/app_pages.dart';
import 'package:dompet_mal/color/color.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    var lebar = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                width: lebar,
                height: 226,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/bgLogin.png'),
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
            child: SingleChildScrollView(
              child: Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset('icons/X.png'),
                        TextButton(
                          onPressed: () => Get.toNamed(Routes.LOGIN),
                          child: Text(
                            'Masuk',
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
                    Center(child: Image.asset('images/logoLogin.png')),
                    Gap(40),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Nama Lengkap',
                            style: GoogleFonts.openSans(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w600)),
                        Gap(8),
                        TextFormField(
                          controller: controller.namaController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Nama lengkap tidak boleh kosong';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Masukan nama lengkap',
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
                        Text('Email',
                            style: GoogleFonts.openSans(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w600)),
                        Gap(8),
                        TextFormField(
                          controller: controller.emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email tidak boleh kosong';
                            }
                            if (!GetUtils.isEmail(value)) {
                              return 'Email tidak valid';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Masukan email',
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
                        Obx(() => TextFormField(
                              controller: controller.passwordController,
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
                                  icon: Icon(controller.isPasswordHidden.value
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                  onPressed:
                                      controller.togglePasswordVisibility,
                                ),
                              ),
                            )),
                        Gap(20),
                        Text('Ulangi Kata Sandi',
                            style: GoogleFonts.openSans(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w600)),
                        Gap(8),
                        Obx(() => TextFormField(
                              controller: controller.confirmPasswordController,
                              obscureText:
                                  controller.isConfirmPasswordHidden.value,
                              validator: (value) {
                                if (value !=
                                    controller.passwordController.text) {
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
                                          : Icons.visibility),
                                  onPressed: controller
                                      .toggleConfirmPasswordVisibility,
                                ),
                              ),
                            )),
                        Gap(20),
                        Text('Nomor Ponsel',
                            style: GoogleFonts.openSans(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w600)),
                        Gap(8),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 12),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(0xFFC7C9D9).withOpacity(0.5)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Image.asset('icons/flag.png',
                                      width: 24, height: 16),
                                  Gap(4),
                                  Text('+62',
                                      style: GoogleFonts.openSans(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400)),
                                ],
                              ),
                            ),
                            Gap(8),
                            Expanded(
                              child: TextFormField(
                                controller: controller.phoneController,
                                keyboardType: TextInputType.phone,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Nomor telepon tidak boleh kosong';
                                  }
                                  if (value.length < 10) {
                                    return 'Nomor telepon tidak valid';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: '810 101x xx',
                                  hintStyle: GoogleFonts.montserratAlternates(
                                      fontSize: 12,
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
                            ),
                          ],
                        ),
                        Gap(20),
                        Row(
                          children: [
                            Obx(() => Checkbox(
                                  value: controller.isAgreed.value,
                                  onChanged: (value) =>
                                      controller.toggleAgreement(),
                                  activeColor: Color(0xFF4B76D9),
                                )),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  text: 'Anda menyetujui ',
                                  style: GoogleFonts.openSans(
                                    fontSize: 14,
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Syarat & Ketentuan',
                                      style: GoogleFonts.openSans(
                                        fontSize: 14,
                                        color: Color(0xFF4B76D9),
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap =
                                            () => Get.toNamed(Routes.AGGREMENT),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Gap(32),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF4B76D9),
                            minimumSize: Size(double.infinity, 45),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: controller.register,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 139),
                            child: Text(
                              'DAFTAR',
                              style: GoogleFonts.openSans(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        Gap(52),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Sudah punya akun? ',
                                style: GoogleFonts.openSans(
                                    fontSize: 14,
                                    color: Colors.grey.shade500,
                                    fontWeight: FontWeight.w400)),
                            TextButton(
                              onPressed: () => Get.toNamed(Routes.LOGIN),
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text('Login',
                                  style: GoogleFonts.openSans(
                                      fontSize: 14,
                                      color: Color(0xFF4B76D9),
                                      fontWeight: FontWeight.w700,
                                      decoration: TextDecoration.underline)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
