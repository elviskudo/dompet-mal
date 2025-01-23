import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../helper/PasswordHasher.dart';
import '../../../routes/app_pages.dart';

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
    // try {
    //   isLoading.value = true;

    //   // Trigger the Google OAuth sign in flow
    //   final bool success = await supabase.auth.signInWithOAuth(
    //     OAuthProvider.google,
    //     redirectTo: 'io.supabase.flutter://login-callback/',
    //   );

    //   if (success) {
    //     // Wait for the session to be available
    //     final Session? session = supabase.auth.currentSession;
    //     final User? user = session?.user;

    //     if (user != null) {
    //       try {
    //         // Get user details from Supabase
    //         final userData = await supabase
    //             .from('users')
    //             .select()
    //             .eq('email', user)
    //             .single();

    //         final DateTime now = DateTime.now();

    //         // If user doesn't exist in your users table, create them
    //         if (userData == null) {
    //           // Insert new user
    //           final String userId = await supabase
    //               .from('users')
    //               .insert({
    //                 'name': user.userMetadata?['full_name'] ?? '',
    //                 'email': user.email,
    //                 'password': '', // Empty for Google Sign In
    //                 'phone_number': '',
    //                 'access_token': session?.accessToken ?? '',
    //                 'created_at': now.toIso8601String(),
    //                 'updated_at': now.toIso8601String(),
    //               })
    //               .select('id')
    //               .single()
    //               .then((response) => response['id']);

    //           // Assign member role to new user
    //           await supabase.from('user_roles').insert({
    //             'user_id': userId,
    //             'role_id': MEMBER_ROLE_ID,
    //             'created_at': now.toIso8601String(),
    //             'updated_at': now.toIso8601String(),
    //           });

    //           // Store user session details
    //           final prefs = await SharedPreferences.getInstance();
    //           await prefs.setBool('isLoggedIn', true);
    //           await prefs.setString('userEmail', user.email ?? '');
    //           await prefs.setString('userId', userId);
    //           await prefs.setString(
    //               'userName', user.userMetadata?['full_name'] ?? '');
    //           await prefs.setString('accessToken', session?.accessToken ?? '');
    //           await prefs.setString('userRole', 'member');
    //         } else {
    //           // Update existing user's access token
    //           await supabase.from('users').update({
    //             'access_token': session?.accessToken ?? '',
    //             'updated_at': now.toIso8601String(),
    //           }).eq('id', userData['id']);

    //           // Get user's role
    //           final userRole = await supabase
    //               .from('user_roles')
    //               .select('roles (name)')
    //               .eq('user_id', userData['id'])
    //               .single();

    //           // Store user session details
    //           final prefs = await SharedPreferences.getInstance();
    //           await prefs.setBool('isLoggedIn', true);
    //           await prefs.setString('userEmail', userData['email']);
    //           await prefs.setString('userId', userData['id']);
    //           await prefs.setString('userName', userData['name']);
    //           await prefs.setString('accessToken', session?.accessToken ?? '');
    //           await prefs.setString('userRole', userRole['roles']['name']);
    //         }

    //         // Show success message
    //         Get.snackbar(
    //           'Sukses',
    //           'Berhasil login dengan Google',
    //           backgroundColor: Colors.green,
    //           colorText: Colors.white,
    //           margin: EdgeInsets.all(20),
    //           padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    //           snackPosition: SnackPosition.BOTTOM,
    //           duration: Duration(seconds: 2),
    //           snackStyle: SnackStyle.FLOATING,
    //           forwardAnimationCurve: Curves.easeOut,
    //           reverseAnimationCurve: Curves.easeIn,
    //         );

    //         // Navigate to main screen
    //         Get.offAllNamed(Routes.NAVIGATION);
    //       } catch (e) {
    //         print('Error processing user data: $e');
    //         Get.snackbar(
    //           'Error',
    //           'Terjadi kesalahan saat memproses data pengguna',
    //           backgroundColor: Colors.red,
    //           colorText: Colors.white,
    //         );
    //       }
    //     } else {
    //       Get.snackbar(
    //         'Error',
    //         'Gagal mendapatkan data pengguna',
    //         backgroundColor: Colors.red,
    //         colorText: Colors.white,
    //       );
    //     }
    //   } else {
    //     Get.snackbar(
    //       'Error',
    //       'Gagal login dengan Google',
    //       backgroundColor: Colors.red,
    //       colorText: Colors.white,
    //     );
    //   }
    // } on AuthException catch (error) {
    //   Get.snackbar(
    //     'Error',
    //     error.message,
    //     backgroundColor: Colors.red,
    //     colorText: Colors.white,
    //   );
    // } catch (error) {
    //   Get.snackbar(
    //     'Error',
    //     'Terjadi kesalahan saat login dengan Google: $error',
    //     backgroundColor: Colors.red,
    //     colorText: Colors.white,
    //   );
    // } finally {
    //   isLoading.value = false;
    // }
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
