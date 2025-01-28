import 'package:dompet_mal/app/modules/(home)/sendMoney/controllers/sendMoney_controller.dart';
import 'package:dompet_mal/app/routes/app_pages.dart';
import 'package:dompet_mal/color/color.dart';
import 'package:dompet_mal/component/AppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SendMoneyView extends GetView<SendMoneyController> {
  const SendMoneyView({super.key});
  @override
  Widget build(BuildContext context) {
    var tinggi = MediaQuery.of(context).size.height;
    var lebar = MediaQuery.of(context).size.width;
    var default_id_transaksi = '#DM110703412';
    final args = Get.arguments as Map<String, dynamic>?;

    // Provide default values and proper null handling
    final transactionId =
        args?['idTransaksi'] as String? ?? default_id_transaksi;
    final transactionNumber =
        args?['transactionNumber'] as String? ?? default_id_transaksi;
    final charityId = args?['charityId'] as String? ?? '';
    final bankId = args?['bankId'] as String? ?? '';
    final donationPrice = args?['donationPrice'] as String? ?? '0';
    final userId = args?['userId'] as String? ?? '';

    print('transid id : $transactionId');

    return Scaffold(
        appBar: appbar2(
          title: 'Kirim Uang',
          color: basecolor,
          iconColor: Colors.white,
          titleColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              _Jumbotron(tinggi, lebar),
              Section_IdTransaksi(context, transactionNumber),
              Gap(24),
              Container(
                width: lebar,
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Unggah bukti transfer hanya jika kamu transfer via EDC atau setor tunai, atau jika transaksi bermasalah.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(color: Colors.black87),
                    ),
                    Gap(24),
                    Container(
                      width: lebar,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: basecolor,
                          padding: EdgeInsets.all(24),
                        ),
                        onPressed: () =>
                            Get.toNamed(Routes.SEND_MONEY2, arguments: {
                          'idTransaksi': transactionId,
                          'transactionNumber': transactionNumber,
                          'bankId': bankId,
                          'charityId': charityId,
                          'donationPrice': donationPrice,
                          'userId': userId,
                        }),
                        child: Text(
                          "UNGGAH BUKTI TRANSFER",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Gap(16),
                    Container(
                      width: lebar,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.all(24),
                          side: const BorderSide(
                              color: Color.fromARGB(48, 49, 48, 54)),
                        ),
                        onPressed: () {
                          // Clear session and navigate to home
                          Get.toNamed(Routes.HOME);
                        },
                        child: Text(
                          "KEMBALI KE BERANDA",
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(160, 49, 48, 54)),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Container _Jumbotron(double tinggi, double lebar) {
    return Container(
      color: Color(0xfff7f7f7),
      padding:
          EdgeInsetsDirectional.only(top: 24, bottom: 16, end: 16, start: 16),
      height: tinggi * 0.35,
      width: lebar,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Dompet mal sedang mengecek transaksimu',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          Image.asset(
            'assets/icons/dompet2.png',
            width: 90,
            height: 90,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Setelah uang kami terima, uang akan langsung dikirim ke rekening tujuan',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          )
        ],
      ),
    );
  }

  Padding Section_IdTransaksi(BuildContext context, String idTransaksi) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "ID TRANSAKSI $idTransaksi",
                style: GoogleFonts.poppins
                    (fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Gap(12),
              InkWell(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: idTransaksi));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Nominal transfer disalin ke clipboard")),
                  );
                },
                hoverColor: Colors.white,
                child: Image.asset('assets/icons/icon_copy.png'),
              )
            ],
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListTile(
              leading: Image.asset(
                'assets/images/foto_bayi_sekarat.png', // Ganti dengan path gambar
                width: 50,
                height: 50,
              ),
              title: Text(
                "Kembarannya Tiada, Bantu Bayi Esha Operasi Segera!",
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("17 Januari 2022 10:00"),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
