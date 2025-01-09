import 'package:dompet_mal/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:flutter/material.dart';

class ForgotpassVerificationController extends GetxController {
  final List<TextEditingController> otpControllers =
      List.generate(6, (index) => TextEditingController());

  RxInt timeLeft = 60.obs;
  RxBool canResend = false.obs;
  Timer? _timer;

  final String otpDummy = "123456";
  final userEmail = "".obs;

  final isOtpComplete = false.obs;

  @override
  void onInit() {
    super.onInit();
    startTimer();
    userEmail.value = Get.arguments?['email'] ?? 'email@gmail.com';
  }

  void startTimer() {
    canResend.value = false;
    timeLeft.value = 60;

    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeLeft.value > 0) {
        timeLeft.value--;
      } else {
        canResend.value = true;
        timer.cancel();
      }
    });
  }

  String get otp => otpControllers.map((e) => e.text).join();

  void verifyOTP() {
    if (otp.length != 6) {
      Get.snackbar(
        'Error',
        'Masukkan 6 digit kode OTP',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (otp == otpDummy) {
      Get.snackbar(
        'Sukses',
        'Verifikasi OTP berhasil',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      Get.toNamed(Routes.RESET_PASS, arguments: {'email': userEmail.value});
    } else {
      Get.snackbar(
        'Error',
        'Kode OTP tidak valid',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );

      for (var controller in otpControllers) {
        controller.clear();
      }

      FocusScope.of(Get.context!).requestFocus(FocusNode());
    }
  }

  void resendOTP() {
    if (!canResend.value) return;

    Get.snackbar(
      'Sukses',
      'Kode OTP telah dikirim ulang\nGunakan OTP: $otpDummy',
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: Duration(seconds: 5),
    );

    startTimer();
  }

  void checkOtpComplete() {
    bool complete =
        otpControllers.every((controller) => controller.text.length == 1);
    isOtpComplete.value = complete;
  }

  @override
  void onClose() {
    _timer?.cancel();
    for (var controller in otpControllers) {
      controller.dispose();
    }
    super.onClose();
  }
}
