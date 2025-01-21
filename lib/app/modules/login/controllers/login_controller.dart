import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bcrypt/flutter_bcrypt.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../routes/app_pages.dart';
import 'package:crypto/crypto.dart';

class LoginController extends GetxController {
  final emailC = TextEditingController();
  final passC = TextEditingController();
  RxBool isLoading = false.obs;
  RxBool isPasswordHidden = true.obs;
  RxString email = ''.obs;
  RxString password = ''.obs;
  final supabase = Supabase.instance.client;
  String MEMBER_ROLE_ID = '3b762a72-a685-4020-841e-db8f86ba71e3';

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

  Future<String> _hashPassword(String password) async {
    // Convert the password to bytes
    final passwordBytes = utf8.encode(password);

    // Create a SHA-256 hash of the password
    final digest = sha256.convert(passwordBytes);

    // Return the hexadecimal string of the hash
    return digest.toString();
  }

  Future<void> signInWithGoogle() async {
    const webClientId = 'my-web.apps.googleusercontent.com';

    /// TODO: update the iOS client ID with your own.
    ///
    /// iOS Client ID that you registered with Google Cloud.
    const iosClientId = 'my-ios.apps.googleusercontent.com';

    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    await supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
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
      final hashedEnteredPassword = await _hashPassword(passC.text);

      if (hashedEnteredPassword != storedHashedPassword) {
        Get.snackbar(
          'Error',
          'Password salah',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      isLoading.value = true;

      final AuthResponse res = await supabase.auth.signInWithPassword(
        email: emailC.text,
        password: passC.text,
      );
      if (res.session != null) {
        // Log user session details
        print('User logged in: ${res.user?.email}');
      } else {
        Get.snackbar('Error', 'Gagal mendapatkan sesi login.',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
      if (res.session != null) {
        final user = await supabase
            .from('users')
            .select()
            .eq('email', emailC.text)
            .single();

        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('userEmail', emailC.text);
        await prefs.setString('userId', res.user!.id);
        await prefs.setString('userName', user['name']);
        await prefs.setString('accessToken', res.session!.accessToken);
        print(
            'email : ${emailC.text}, hser id ${res.user!.id}, nama : ${user['name']}, token : ${res.session!.accessToken}');
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

        Get.offAllNamed(Routes.NAVIGATION);
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
