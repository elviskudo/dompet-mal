import 'package:dompet_mal/component/OTPTextField.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/email_verification_controller.dart';

class EmailVerificationView extends GetView<EmailVerificationController> {
  const EmailVerificationView({super.key});
  @override
  Widget build(BuildContext context) {
    var lebar = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            width: lebar,
            height: 226,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bgFg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/icons/X.png'),
                  Image.asset(
                    'assets/images/logoLogin.png',
                    width: 343,
                    height: 36,
                  ),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
              Gap(14),
              Text(
                'Verifikasi Email',
                style: GoogleFonts.openSans(
                    fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Gap(17),
              Text(
                'Kami telah mengirimkan kode OTP ke',
                style: GoogleFonts.openSans(
                    fontSize: 14, fontWeight: FontWeight.w400),
              ),
              Gap(7),
              Obx(() => Text(
                    controller.userEmail.value,
                    style: GoogleFonts.openSans(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF4B76D9)),
                  )),
              Gap(24),
              Text(
                'Cek email Anda dan masukkan kode OTP yang Anda terima.',
                style: GoogleFonts.openSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  6,
                  (index) => OTPTextField(
                    controller: controller.otpControllers[index],
                    focusNode: controller.otpFocusNodes[index],
                    index: index,
                    parentController: controller,
                  ),
                ),
              ),
              Gap(35),
              Center(
                child: Text(
                  'Tidak menerima kode?',
                  style: GoogleFonts.openSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Gap(16),
              Center(
                child: TextButton(
                  onPressed: controller.canResend.value
                      ? () {
                          controller.resendOTP();
                        }
                      : null,
                  child: Obx(() => Text(
                        controller.canResend.value
                            ? 'Kirim Ulang Kode'
                            : 'Kirim Ulang kode dalam ${controller.countdown.value}s',
                        style: GoogleFonts.openSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: controller.canResend.value
                              ? Color(0xFF4B76D9)
                              : Colors.black.withOpacity(0.5),
                        ),
                      )),
                ),
              ),
              Gap(204),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4B76D9),
                  minimumSize: Size(double.infinity, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: controller.verifyOTP,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    'VERIFIKASI',
                    style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Gap(24),
              Center(
                child: Text(
                  'GANTI EMAIL',
                  style: GoogleFonts.openSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF4B76D9),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    ));
  }
}
