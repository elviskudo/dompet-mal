import 'package:dompet_mal/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController =
        TextEditingController(text: controller.userName.value);
    TextEditingController phoneController =
        TextEditingController(text: controller.userPhone.value);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text('Profile',
            style: GoogleFonts.openSans(
                fontWeight: FontWeight.w600, fontSize: 18)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 23,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
                  controller: nameController,
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
                  controller:
                      TextEditingController(text: controller.userEmail.value),
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Color(0xFFC7C9D9).withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Image.asset('icons/flag.png', width: 24, height: 16),
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
                        controller: phoneController,
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
                  onPressed: () {
                    if (controller.formKey.currentState!.validate()) {
                      String newName = nameController.text.trim();
                      String newPhone = phoneController.text.trim();

                      controller.updateProfile(
                        name: newName,
                        phone: newPhone,
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 139),
                    child: Text(
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
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 139),
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
    );
  }
}
