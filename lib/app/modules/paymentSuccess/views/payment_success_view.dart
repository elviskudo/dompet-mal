import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../controllers/payment_success_controller.dart';

class PaymentSuccessView extends GetView<PaymentSuccessController> {
  const PaymentSuccessView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Color(0xFF4B76D9), // Light green color
        child: SafeArea(
          child: Stack(
            children: [
              // Close button at top-left
              Positioned(
                top: 16,
                left: 16,
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ),
              // Main content
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Check icon in white circle
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check,
                      color: Color(0xFF4B76D9),
                      size: 48,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Success text
                  Text(
                    'Pembayaran berhasil!',
                    style: GoogleFonts.openSans(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Thank you message
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      'Terima kasih sudah memberikan donasi.Semoga Alloh memberkahiku dan memberkahimu dan menerima seluruh amalmu sebagai pemberat kebaikan di hari hisab kelak. Aamiin',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Amount section
                  Text(
                    'AMOUNT PAID',
                    style: GoogleFonts.openSans(
                      color: Colors.white,
                      fontSize: 14,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    NumberFormat.currency(
                      locale: 'id_ID',
                      symbol: 'Rp',
                      decimalDigits: 0,
                    ).format(100000),
                    style: GoogleFonts.openSans(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
