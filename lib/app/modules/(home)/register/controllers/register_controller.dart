import 'package:dompet_mal/app/routes/app_pages.dart';
import 'package:dompet_mal/helper/PasswordHasher.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final namaController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();
  bool _initialized = false;
  bool get isInitialized => _initialized;
  final isPasswordHidden = true.obs;
  final isConfirmPasswordHidden = true.obs;
  final isAgreed = false.obs;
  final isLoading = false.obs;
  final formattedPhone = ''.obs;
  final storage = GetStorage();
  final supabase = Supabase.instance.client;

  @override
  void onInit() {
    super.onInit();

    initializePage();
    phoneController.addListener(() {
      if (phoneController.text.isNotEmpty) {
        formattedPhone.value = formatPhoneNumber(phoneController.text);
      }
    });

    /// Configuring the remote server
    // deleteUser('7102d17a-0ce7-4d3c-94eb-e47b93905f70');
  }

  Future<void> initializePage() async {
    isLoading.value = true;
    try {
      await supabase.from('users').select().limit(1);
      _initialized = true;
    } catch (e) {
      print('Error initializing: $e');
      Get.snackbar(
        'Error',
        'Gagal terhubung ke server',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  String formatPhoneNumber(String phone) {
    // Hilangkan semua karakter non-digit
    String cleanPhone = phone.replaceAll(RegExp(r'[^\d]'), '');

    // Jika dimulai dengan 0, hilangkan 0 di depan
    if (cleanPhone.startsWith('0')) {
      cleanPhone = cleanPhone.substring(1);
    }

    // Jika tidak dimulai dengan 62, tambahkan 62
    if (!cleanPhone.startsWith('62')) {
      cleanPhone = '62$cleanPhone';
    }

    return '+$cleanPhone';
  }

  void togglePasswordVisibility() =>
      isPasswordHidden.value = !isPasswordHidden.value;

  void toggleConfirmPasswordVisibility() =>
      isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;

  void toggleAgreement() => isAgreed.value = !isAgreed.value;

  Future<void> register() async {
    if (!formKey.currentState!.validate()) return;

    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar(
        'Error',
        'Password dan konfirmasi password tidak cocok',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (!isAgreed.value) {
      Get.snackbar(
        'Error',
        'Anda harus menyetujui Syarat & Ketentuan',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    try {
      final formattedPhoneNumber = formatPhoneNumber(phoneController.text);
      // Ambil role ID untuk "member" dari tabel roles
      final roles = await supabase
          .from('roles')
          .select('id')
          .eq('name', 'member')
          .limit(1)
          .single();
      final defaultRoleId = roles['id'];

      if (defaultRoleId == null) {
        throw 'Role default untuk "member" tidak ditemukan';
      }

      // Register user dengan Supabase Auth
      final AuthResponse res = await supabase.auth.signUp(
        email: emailController.text.toLowerCase(),
        password: passwordController.text,
        
        // phone: phoneController.text,
      );

      if (res.user == null) throw 'Gagal membuat akun';

      // Insert data ke table users
      final hashedPassword =
          await PasswordHasher.hashPassword(passwordController.text);
      final userData = {
        'id': res.user!.id,
        'name': namaController.text,
        'email': emailController.text.toLowerCase(),
        'password': hashedPassword,
        'phone_number': formattedPhoneNumber,
        'access_token': res.session?.accessToken ?? '',
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      };

      await supabase.from('users').insert(userData);

      // Insert ke table user_roles
      final userRoleData = {
        'user_id': res.user!.id,
        'role_id': defaultRoleId,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      };

      await supabase.from('user_roles').insert(userRoleData);

      // Simpan data sementara di local storage
      storage.write('temp_user_data', {
        'email': emailController.text,
        'name': namaController.text,
      });

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userEmail', userData['email'] ?? '');
      await prefs.setString('userId', userData['id'] ?? '');
      await prefs.setString('userName', userData['name'] ?? '');
      await prefs.setString('userPhone', userData['phone_number'] ?? '');

      Get.snackbar(
        'Sukses',
        'Registrasi berhasil! Silahkan verifikasi email Anda',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      Get.offAllNamed(
        Routes.EMAIL_VERIFICATION,
        arguments: {
          'email': emailController.text,
          'nama': namaController.text,
        },
      );
    } catch (error) {
      print('Error during registration: $error');
      String errorMessage = 'Terjadi kesalahan saat mendaftar';

      if (error is PostgrestException) {
        if (error.code == '23505') {
          errorMessage = 'Email sudah terdaftar';
        } else if (error.code == '42501') {
          errorMessage = 'Akses tidak diizinkan';
        }
      } else if (error is AuthException) {
        if (error.statusCode == 429) {
          errorMessage = 'Mohon tunggu beberapa saat sebelum mencoba kembali';
        } else {
          errorMessage = error.message;
        }
      }

      Get.snackbar(
        'Error',
        errorMessage,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 5),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteUser(String userId) async {
    final supabase = Supabase.instance.client;

    try {
      await supabase.from('user_roles').delete().eq('user_id', userId);

      final response = await supabase.from('users').delete().eq('id', userId);

      if (response.error != null) {
        throw Exception('Failed to delete user: ${response.error!.message}');
      }

      print('User and related roles deleted successfully.');
    } catch (e) {
      print('Error deleting user: $e');
    }
  }

  @override
  void onClose() {
    namaController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
