import 'package:dompet_mal/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart';

class EmailVerificationController extends GetxController {
  final userEmail = ''.obs;
  final otpValue = ''.obs;
  final List<TextEditingController> otpControllers =
      List.generate(6, (index) => TextEditingController());
  final List<FocusNode> otpFocusNodes =
      List.generate(6, (index) => FocusNode());
  final countdown = 30.obs;
  final canResend = false.obs;
  final isLoading = false.obs;
  Timer? _timer;
  final dummyOTP = '123456';
  final supabase = Supabase.instance.client;

  @override
  void onInit() async {
    super.onInit();
    startCountdown();
    userEmail.value = Get.arguments?['email'] ?? 'email@gmail.com';
    // sendOTP(userEmail.value);
    _sendOtp(userEmail.value);
    print('email sent');
  }

  Future<void> handlePaste(String? value) async {
    if (value == null ||
        value.length != 6 ||
        !RegExp(r'^\d+$').hasMatch(value)) {
      return;
    }

    // Isi semua field dengan angka yang di-paste
    for (int i = 0; i < 6; i++) {
      otpControllers[i].text = value[i];
    }

    // Update nilai OTP
    updateOTPValue();
  }

  void handleInput(int index, String value) {
    if (value.isEmpty) return;

    // Jika panjang input > 1, mungkin ini adalah paste
    if (value.length > 1) {
      handlePaste(value);
      return;
    }

    // Untuk input single digit
    if (value.length == 1 && RegExp(r'[0-9]').hasMatch(value)) {
      otpControllers[index].text = value;
      if (index < 5) {
        otpFocusNodes[index + 1].requestFocus();
      }
    }

    updateOTPValue();
  }

  void _sendOtp(String email) async {
    try {
      final response = await Supabase.instance.client.auth.signInWithOtp(
        email: email,
      );

      print('Magic Link sent to email');
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var node in otpFocusNodes) {
      node.dispose();
    }
    super.onClose();
  }

  void startCountdown() {
    canResend.value = false;
    countdown.value = 30;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdown.value > 0) {
        countdown.value--;
      } else {
        canResend.value = true;
        timer.cancel();
      }
    });
  }

  void resendOTP() {
    startCountdown();
    _sendOtp(userEmail.value);
  }

  void updateOTPValue() {
    otpValue.value = otpControllers.map((c) => c.text).join();
    print('OTP yang dimasukkan: ${otpValue.value}');
  }

  void verifyOTP() async {
    if (otpValue.value.length != 6) {
      Get.snackbar('Error', 'Silakan masukkan kode OTP lengkap');
      return;
    }

    try {
      // Tampilkan loading dialog
      _showLoadingDialog();

      // Verifikasi OTP menggunakan Supabase
      final response = await Supabase.instance.client.auth.verifyOTP(
        email: userEmail.value, // Email yang digunakan saat mengirim OTP
        token: otpValue.value, // Kode OTP yang diinput user
        type: OtpType.email,
      );

      // Cek hasil verifikasi
      if (response.session != null) {
        // Verifikasi berhasil
        // Tutup dialog loading
        Get.back();

        // Tampilkan dialog sukses
        Get.dialog(
          WillPopScope(
            onWillPop: () async => false,
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.blue,
                      size: 50,
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Verifikasi berhasil',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),
          barrierDismissible: false,
        );
        Get.back();

        // Redirect ke halaman utama
        Get.toNamed(Routes.NAVIGATION);
      } else {
        // Jika gagal
        Get.back(); // Tutup dialog loading
        Get.snackbar('Error', 'Kode OTP tidak valid');
      }
    } catch (e) {
      // Handle error
      Get.back(); // Tutup dialog loading
      Get.snackbar('Error', 'Gagal memverifikasi OTP: ${e.toString()}');
    }
  }

  void _showLoadingDialog() {
    Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  backgroundColor: Color(0xFFC5D6FF),
                  child: Image.asset('assets/icons/dompet.png'),
                ),
                SizedBox(height: 15),
                Text(
                  'Sedang verifikasi akun..',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  Future<void> _showSuccessDialog() async {
    return Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.blue,
                  size: 50,
                ),
                SizedBox(height: 15),
                Text(
                  'Verifikasi berhasil',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
