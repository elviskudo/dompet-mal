import 'package:dompet_mal/app/modules/kategori/views/kategori_view.dart';
import 'package:dompet_mal/app/routes/app_pages.dart';
import 'package:dompet_mal/color/color.dart';
import 'package:dompet_mal/component/AppBar.dart';
import 'package:dompet_mal/models/BankAccountModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';

import '../controllers/konfirmasi_transfer_controller.dart';

class KonfirmasiTransferView extends GetView<KonfirmasiTransferController> {
  const KonfirmasiTransferView({super.key});
  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final nomorRekening = args['bankAccount'] as BankAccount;
    final totalTransfer = args['amount'] as String;
    final String idTransaksi = "#DM110703412";
    var lebar = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar2(
        title: 'Konfimasi Transfer',
        color: basecolor,
        titleColor: Colors.white,
        iconColor: Colors.white,
      ),
      body: SingleChildScrollView(
        // padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              width: double.infinity,
              color: baseGray,
              child: const Text(
                "LAKUKAN TRANSFER KE REKENING",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'images/mandiri.png', // Ganti dengan path logo bank Anda
                        width: 73,
                        height: 21,
                      ),
                      const SizedBox(width: 16),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Bank Mandiri",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text("ELVIS SONATHA"),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _inputCopyTransfer('$nomorRekening', context),
                  const SizedBox(height: 16),
                  _inputCopyTransfer(totalTransfer, context),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('icons/dashicons_warning.png'),
                      Gap(12),
                      const Text(
                        "Pastikan nominal sesuai hingga 2 digit terakhir",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Transfer sebelum 12 Desember 22:41 WIB atau transaksimu akan dibatalkan otomatis oleh sistem.",
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            Container(
              width: lebar,
              color: baseGray,
              height: 6,
            ),
            Section_IdTransaksi(context, idTransaksi),
            Container(
              width: lebar,
              color: baseGray,
              height: 6,
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    "Sudah transfer melalui ATM/Internet/mobile banking? Klik tombol di bawah untuk mengonfirmasi. Dompet Mal tidak memproses transaksi yang belum dikonfirmasi.",
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  Column(
                    children: [
                      Container(
                        width: lebar,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: basecolor,
                            padding: EdgeInsets.all(24),
                          ),
                          onPressed: () => _showCenteredPopup(context),
                          child: const Text(
                            "TRANSFER SEKARANG",
                            style: TextStyle(
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
                            Navigator.popUntil(
                                context, (route) => route.isFirst);
                          },
                          child: const Text(
                            "BATALKAN TRANSAKSI",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(160, 49, 48, 54)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showCenteredPopup(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Popup tidak bisa ditutup dengan klik di luar
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon atau gambar
                Container(
                  width: 150,
                  padding: EdgeInsets.all(36),
                  height: 150,
                  decoration: BoxDecoration(
                    color: const Color(0xffE9EFFF),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                          width: 80,
                          height: 66,
                          child: Image.asset('icons/icon_dompet.png')),
                      Container(
                        width: 50,
                        height: 50,
                        margin: EdgeInsets.only(left: 50, bottom: 40),
                        child: Image.asset(
                          'icons/icon_ceklis.png',
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Judul
                const Text(
                  'Sudah transfer ke rekening Dompet Mal?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                // Deskripsi
                const Text(
                  'Transaksi baru akan diproses jika kamu sudah transfer ke rekening Dompet Mal melalui ATM, SMS Banking, Mobile Banking, atau Internet Banking.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 24),
                // Tombol aksi
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.38,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.all(24),
                          side: const BorderSide(
                              color: Color.fromARGB(48, 49, 48, 54)),
                        ),
                        onPressed: () {
                          // Clear session and navigate to home
                          Navigator.popUntil(context, (route) => route.isFirst);
                        },
                        child: const Text(
                          "BELUM",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(160, 49, 48, 54)),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.38,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: basecolor,
                          padding: EdgeInsets.all(24),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          Get.toNamed(Routes.KIRIM_UANG);
                        },
                        child: const Text(
                          "SUDAH",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
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
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                child: Image.asset('icons/icon_copy.png'),
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
                'images/foto_bayi_sekarat.png', // Ganti dengan path gambar
                width: 50,
                height: 50,
              ),
              title: const Text(
                "Kembarannya Tiada, Bantu Bayi Esha Operasi Segera!",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text("17 Januari 2022 10:00"),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Container _inputCopyTransfer(String nomorRekening, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xfff7f7f7),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            nomorRekening,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          InkWell(
            onTap: () {
              Clipboard.setData(ClipboardData(text: nomorRekening));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text("Nominal transfer disalin ke clipboard")),
              );
            },
            hoverColor: Colors.white,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.redAccent)),
              child: Text(
                "Salin",
                style: TextStyle(color: Colors.red),
              ),
            ),
          )
          // ElevatedButton(
          //   style: ButtonStyle(

          //   ),
          //   onPressed: () {

          //   },
          //   child: const Text("Salin"),
          // ),
        ],
      ),
    );
  }
}

class ConfirmationModalComponent extends StatelessWidget {
  const ConfirmationModalComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Konfirmasi Modal"),
      ),
      body: const Center(
        child: Text("Halaman Konfirmasi Modal"),
      ),
    );
  }
}
