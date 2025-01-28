import 'package:dompet_mal/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../controllers/payment_success_controller.dart';

class PaymentSuccessView extends GetView<PaymentSuccessController> {
  const PaymentSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    // Tangkap argumen yang dikirim melalui Get.offAllNamed

    return WillPopScope(
      onWillPop: () async {
        // Navigasi ke halaman tertentu saat back atau close ditekan
        Get.offAllNamed(
            Routes.NAVIGATION); // Ganti '/navigation' dengan route tujuan
        return false; // Mencegah navigasi default
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          color: Color(0xFF4B76D9), // Warna biru
          child: SafeArea(
            child: Stack(
              children: [
                // Tombol close di kiri atas
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
                // Konten utama
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Ikon centang dalam lingkaran putih
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
                    // Teks sukses
                    Text(
                      'Pembayaran berhasil!',
                      style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Pesan ucapan terima kasih
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        'Terima kasih sudah memberikan donasi. Semoga Alloh memberkahiku dan memberkahimu dan menerima seluruh amalmu sebagai pemberat kebaikan di hari hisab kelak. Aamiin',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Bagian jumlah pembayaran
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
                      // Format jumlah pembayaran dengan argumen 'donationPrice'
                      NumberFormat.currency(
                        locale: 'id_ID',
                        symbol: 'Rp',
                        decimalDigits: 0,
                      ).format(10000),
                      style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
