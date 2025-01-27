import 'package:dompet_mal/app/modules/(admin)/list_user/controllers/list_user_controller.dart';
import 'package:dompet_mal/app/modules/(admin)/upload/controllers/upload_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileView extends GetView<ListUserController> {
  ProfileView({super.key});

  final UploadController uploadController = Get.put(UploadController());

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile',
            style: GoogleFonts.openSans(
                fontWeight: FontWeight.w600, fontSize: 18)),
      ),
      body: Obx(() => Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 23,
            ),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Profile Image Section

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
                            return 'Masukan nama lengkap';
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
                        readOnly: true,
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
                                Image.asset('assets/icons/flag.png',
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
                      Gap(16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF4B76D9),
                          minimumSize: Size(double.infinity, 45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: controller.isLoading.value
                            ? null
                            : () async {
                                if (formKey.currentState!.validate()) {
                                  await controller.updateProfileWithImage(
                                    name: controller.namaController.text,
                                    phone: controller.phoneController.text,
                                  );
                                }
                              },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: controller.isLoading.value
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text(
                                  'UPDATE',
                                  style: GoogleFonts.openSans(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                        ),
                      ),
                    ],
                  ),
                  Gap(20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 255, 51, 19),
                      minimumSize: Size(double.infinity, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () => controller.logout(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        'Logout',
                        style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
