import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../../helper/PasswordHasher.dart';
import '../../../../routes/app_pages.dart';

class LoginController extends GetxController {
  final emailC = TextEditingController();
  final passC = TextEditingController();
  RxBool isLoading = false.obs;
  RxBool isPasswordHidden = true.obs;
  RxString email = ''.obs;
  RxString password = ''.obs;
  final supabase = Supabase.instance.client;
  // String MEMBER_ROLE_ID = '3b762a72-a685-4020-841e-db8f86ba71e3';

  @override
  void onInit() {
    super.onInit();
    emailC.addListener(() {
      email.value = emailC.text;
    });
    passC.addListener(() {
      password.value = passC.text;
    });
  }

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;

      // Trigger Google Sign In
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        throw 'Google Sign In dibatalkan';
      }

      // Get Google Sign In authentication
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Check if user already exists in Supabase
      final existingUser = await supabase
          .from('users')
          .select()
          .eq('email', googleUser.email)
          .maybeSingle();

      String userId;

      if (existingUser == null) {
        // Create new user if doesn't exist
        final newUser = {
          'email': googleUser.email,
          'name': googleUser.displayName ?? 'Google User',
          'access_token': '',
          'password': '12345678', // Empty password for Google users
          'phone_number': '+62', // Default phone number as requested
        };

        final response =
            await supabase.from('users').insert(newUser).select().single();

        userId = response['id'];

        // Create user role (assuming member role)
        await supabase.from('user_roles').insert({
          'user_id': userId,
          'role_id': '3b762a72-a685-4020-841e-db8f86ba71e3', // Member role ID
        });
      } else {
        userId = existingUser['id'];
      }

      // Get user role
      final userRole = await supabase
          .from('user_roles')
          .select()
          .eq('user_id', userId)
          .single();

      final roles = await supabase
          .from('roles')
          .select()
          .eq('id', userRole['role_id'])
          .single();

      final roleUsers = roles['name'] ?? 'member';
      final defaultProfileImage =
          'https://res.cloudinary.com/dcthljxbl/image/upload/v1738161418/bycisnwjaqzyxddx7ome.webp';
      final fileData = {
        'module_class': 'users',
        'module_id': userId,
        'file_name': defaultProfileImage,
        'file_type': 'webp',
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      };

      await supabase.from('files').insert(fileData);

      // Save user data to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userEmail', googleUser.email);
      await prefs.setString('userId', userId);
      await prefs.setString(
          'userName', googleUser.displayName ?? 'Google User');
      await prefs.setString('userPhone', '+62');
      await prefs.setString('userProfileImage', defaultProfileImage);
      Get.snackbar(
        'Sukses',
        'Berhasil login dengan Google',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
        snackStyle: SnackStyle.FLOATING,
        forwardAnimationCurve: Curves.easeOut,
        reverseAnimationCurve: Curves.easeIn,
      );

      // Navigate based on role
      if (roleUsers == 'admin') {
        Get.offAllNamed(Routes.ADMIN_PANEL);
      } else {
        Get.offAllNamed(Routes.NAVIGATION);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> login() async {
    if (emailC.text.isEmpty || passC.text.isEmpty) {
      Get.snackbar('Error', 'Email dan password harus diisi',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    if (!GetUtils.isEmail(emailC.text)) {
      Get.snackbar('Error', 'Email tidak valid',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    try {
      final response = await supabase
          .from('users')
          .select('password')
          .eq('email', emailC.text.toLowerCase())
          .single();

      if (response == null || response['password'] == null) {
        Get.snackbar(
          'Error',
          'Email tidak terdaftar',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      final String storedHashedPassword = response['password'];

      // Hash the entered password and compare it with the stored hashed password
      final bool passwordMatch = await PasswordHasher.verifyPassword(
        passC.text,
        storedHashedPassword,
      );

      if (!passwordMatch) {
        Get.snackbar(
          'Error',
          'Password salah',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }
      isLoading.value = true;

      final user = await supabase
          .from('users')
          .select()
          .eq('email', emailC.text)
          .single();

      final userRole = await supabase
          .from('user_roles')
          .select()
          .eq('user_id', user['id'])
          .single();

      final roles = await supabase
          .from('roles')
          .select()
          .eq('id', userRole['role_id'])
          .single();

      final roleUsers = roles['name'] ?? 'member';

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userEmail', emailC.text);
      await prefs.setString('userId', user['id']);
      await prefs.setString('userName', user['name']);
      await prefs.setString('userPhone', user['phone_number']);
      await prefs.setString('userRole', roleUsers);

      print('user role : $roleUsers');
      // await prefs.setString('accessToken', res.session!.accessToken);
      // print(
      //     'email : ${emailC.text}, hser id ${res.user!.id}, nama : ${user['name']}, token : ${res.session!.accessToken}');
      Get.snackbar(
        'Sukses',
        'Berhasil login',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
        snackStyle: SnackStyle.FLOATING,
        forwardAnimationCurve: Curves.easeOut,
        reverseAnimationCurve: Curves.easeIn,
      );

      if (roleUsers == 'admin') {
        Get.offAllNamed(Routes.ADMIN_PANEL); // Halaman untuk admin
      } else {
        Get.offAllNamed(Routes.NAVIGATION); // Halaman untuk member
      }
    } on AuthException catch (e) {
      print('eeee ${e}');
      Get.snackbar('Error', e.message,
          backgroundColor: Colors.red, colorText: Colors.white);
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailC.dispose();
    passC.dispose();
    super.onClose();
  }
}
