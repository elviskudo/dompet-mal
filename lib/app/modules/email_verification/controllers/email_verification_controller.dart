import 'package:dompet_mal/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

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

  @override
  void onInit() {
    super.onInit();
    startCountdown();
    userEmail.value = Get.arguments?['email'] ?? 'email@gmail.com';
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
  }

  void updateOTPValue() {
    otpValue.value = otpControllers.map((c) => c.text).join();
    print('OTP yang dimasukkan: ${otpValue.value}');
  }

  void verifyOTP() async {
    print('Fungsi verifyOTP dipanggil');

    if (otpValue.value.length != 6) {
      Get.snackbar('Error', 'Silakan masukkan kode OTP lengkap');
      return;
    }

    print('OTP yang benar: $dummyOTP');
    print('OTP yang dimasukkan: ${otpValue.value}');

    if (otpValue.value != dummyOTP) {
      Get.snackbar('Error', 'Kode OTP tidak valid');
      return;
    }

    print('Memverifikasi OTP: ${otpValue.value}');

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
                  child: Image.asset('icons/dompet.png'),
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

    try {
      await Future.delayed(Duration(seconds: 2));
      Get.back();

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

      await Future.delayed(Duration(milliseconds: 800));
      Get.offAllNamed(Routes.NAVIGATION);
    } catch (e) {
      Get.back();
      Get.snackbar('Error', 'Gagal memverifikasi OTP');
    }
  }
}
