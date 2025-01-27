import 'package:dompet_mal/app/modules/(home)/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../(admin)/list_user/controllers/list_user_controller.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({super.key});
  final ListUserController listUserController = Get.put(ListUserController());
  @override
  Widget build(BuildContext context) {
    // Tambahkan Obx untuk reactive UI
    return Obx(() {
      // Cek apakah data user tersedia
      final userFound = controller.usersList
          .any((user) => user.id == controller.currentUserId.value);

      if (!userFound) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Data pengguna tidak ditemukan',
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gap(16),
                ElevatedButton(
                  onPressed: () => Get.offAllNamed('/login'),
                  child: Text('Kembali ke Login'),
                ),
              ],
            ),
          ),
        );
      }

      // Ambil data user jika ditemukan
      final currentUser = controller.usersList.firstWhere(
        (user) => user.id == controller.currentUserId.value,
      );

      TextEditingController nameController =
          TextEditingController(text: currentUser.name);
      TextEditingController phoneController =
          TextEditingController(text: currentUser.phoneNumber);

      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Profile',
            style: GoogleFonts.openSans(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 23,
          ),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nama Lengkap',
                      style: GoogleFonts.openSans(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Gap(8),
                    TextFormField(
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Masukan nama lengkap';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Masukan nama lengkap',
                        hintStyle: GoogleFonts.montserratAlternates(
                          fontSize: 14,
                          color: Color(0xFFC7C9D9),
                          fontWeight: FontWeight.w400,
                        ),
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
                    Text(
                      'Email',
                      style: GoogleFonts.openSans(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Gap(8),
                    TextFormField(
                      controller:
                          TextEditingController(text: currentUser.email),
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: 'Masukan email',
                        hintStyle: GoogleFonts.montserratAlternates(
                          fontSize: 14,
                          color: Color(0xFFC7C9D9),
                          fontWeight: FontWeight.w400,
                        ),
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
                    Text(
                      'Nomor Ponsel',
                      style: GoogleFonts.openSans(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Gap(8),
                    Row(
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xFFC7C9D9).withOpacity(0.5),
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/icons/flag.png',
                                width: 24,
                                height: 16,
                              ),
                              Gap(4),
                              Text(
                                '+62',
                                style: GoogleFonts.openSans(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Gap(8),
                        Expanded(
                          child: TextFormField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
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
                                fontWeight: FontWeight.w400,
                              ),
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
                              : () {
                                  if (controller.formKey.currentState!
                                      .validate()) {
                                    final updatedData = {
                                      'name': nameController.text.trim(),
                                      'phone_number':
                                          listUserController.formatPhoneNumber(
                                        phoneController.text.trim(),
                                      ),
                                      'updated_at':
                                          DateTime.now().toIso8601String(),
                                    };

                                    listUserController.updateUser(
                                      controller.currentUserId.value,
                                      updatedData,
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
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                          ),
                        )),
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
                  onPressed: () => Get.offAllNamed('/login'),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      'Logout',
                      style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
