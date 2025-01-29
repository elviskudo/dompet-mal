import 'dart:io';

import 'package:dompet_mal/app/modules/(admin)/list_user/controllers/list_user_controller.dart';
import 'package:dompet_mal/app/modules/(admin)/upload/controllers/upload_controller.dart';
import 'package:dompet_mal/app/modules/(home)/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile',
            style: GoogleFonts.openSans(
                fontWeight: FontWeight.w600, fontSize: 18)),
      ),
      body: Obx(() => SingleChildScrollView(
            child: Padding(
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
                        Center(
                          child: Stack(
                            children: [
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                    width: 2,
                                  ),
                                ),
                                child: Obx(() {
                                  if (controller.uploadController.selectedImage
                                          .value !=
                                      null) {
                                    return ClipOval(
                                      child: Image.file(
                                        File(controller.uploadController
                                            .selectedImage.value!.path),
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  } else if (controller
                                      .profileImageUrl.value.isNotEmpty) {
                                    return ClipOval(
                                      child: Image.network(
                                        controller.profileImageUrl.value,
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  } else {
                                    return Icon(Icons.person,
                                        size: 60, color: Colors.grey);
                                  }
                                }),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: InkWell(
                                  onTap: () async {
                                    final ImagePicker picker = ImagePicker();
                                    final XFile? image = await picker.pickImage(
                                      source: ImageSource.gallery,
                                    );
                                    if (image != null) {
                                      controller.uploadController.selectedImage
                                          .value = image;
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Gap(20),
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
                                  await controller.updateProfileWithImage(
                                    name: controller.namaController.text,
                                    phone: controller.phoneController.text,
                                  );
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
            ),
          )),
    );
  }
}
