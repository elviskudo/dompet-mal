import 'dart:async';
import 'dart:math';

import 'package:dompet_mal/app/modules/(admin)/transactions/controllers/transactions_controller.dart';
import 'package:dompet_mal/app/routes/app_pages.dart';
import 'package:dompet_mal/app/routes/app_pages.dart';
import 'package:dompet_mal/color/color.dart';
import 'package:dompet_mal/component/AppBar.dart';
import 'package:dompet_mal/models/BankAccountModel.dart';
import 'package:dompet_mal/models/TransactionModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/konfirmasi_transfer_controller.dart';

String formatAmount(String value) {
  try {
    // Bersihkan string dari karakter non-numerik
    final cleanValue = value.replaceAll(RegExp(r'[^0-9]'), '');

    // Konversi ke number
    int number = int.tryParse(cleanValue) ?? 0;

    // Generate random number (0-99)
    final random = Random();
    final randomNum = random.nextInt(100);

    // Tambahkan random number
    number = number + randomNum;

    // Format dengan separator ribuan dan tambahkan Rp
    final formatter = NumberFormat('#,###', 'id_ID');
    return "Rp ${formatter.format(number).replaceAll(',', '.')}";
  } catch (e) {
    print('Error formatting amount: $e');
    return 'Rp 0';
  }
}

String generateTransactionId({
  required String categoryName,
}) {
  // Buat inisial kategori dari nama kategori
  String categoryInitial = categoryName
      .split(' ') // Pisahkan nama kategori berdasarkan spasi
      .map((word) => word[0]
          .toUpperCase()) // Ambil huruf pertama dari tiap kata dan jadikan huruf besar
      .join(); // Gabungkan semua huruf pertama

  // Ambil tanggal saat ini
  DateTime now = DateTime.now();
  String year = now.year.toString();
  String month = now.month.toString().padLeft(2, '0'); // Pastikan bulan 2 digit

  // Generate angka acak untuk urutan
  Random random = Random();
  int randomSequence = random.nextInt(9999) + 1; // Angka antara 1 dan 9999
  String formattedSequence =
      randomSequence.toString().padLeft(4, '0'); // Pastikan 4 digit

  // Gabungkan semua bagian untuk membuat ID transaksi
  return "#$categoryInitial$year$month$formattedSequence";
}

class ConfirmationTransferView extends GetView<ConfirmationTransferController> {
  const ConfirmationTransferView({super.key});
  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>?;

    if (args == null) {
      return Center(
        child: Text(
          'Data tidak ditemukan!',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      );
    }

    final bankName =
        args['bankAccount'] as String? ?? 'Nama bank tidak tersedia';
    final bankId = args['bankId'] as String? ?? 'Nama bank tidak tersedia';
    final transactionNumber =
        args['transactionNumber'] as String? ?? 'Nama bank tidak tersedia';
    final transactionId =
        args['transactionId'] as String? ?? 'Nama bank tidak tersedia';
    final userId = args['userId'] as String? ?? 'Nama bank tidak tersedia';
    final bankImage =
        args['bankImage'] as String? ?? 'Image bank tidak tersedia';

    final charityId =
        args['charityId'] as String? ?? 'Nama charid id tidak tersedia';
    final bankNumber =
        args['bankNumber'] as String? ?? 'Nomor rekening tidak tersedia';
    // final String idTransaksi = "#DM110703412";
    var lebar = MediaQuery.of(context).size.width;
    final totalTransfer = args['amount'] ?? '0';
    final namaKategori = args['kategori'] as String? ?? 'haha';
    final String idTransaksi =
        generateTransactionId(categoryName: namaKategori);

    final totalTransferFormatted = formatAmount(totalTransfer);
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
                      Image.network(
                        bankImage ?? 'https://via.placeholder.com/150',
                        fit: BoxFit.cover,
                        width: 72,
                        height: 21,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: const Icon(Icons.image, size: 50),
                          );
                        },
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${bankName}"),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _inputCopyTransfer('${bankNumber}', context),
                  const SizedBox(height: 16),
                  _inputCopyTransfer(totalTransferFormatted, context),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/icons/dashicons_warning.png'),
                      Gap(8),
                      const Text(
                        "Pastikan nominal sesuai hingga 2 digit terakhir",
                        style: TextStyle(color: Colors.black, fontSize: 13),
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
                          onPressed: () => _showCenteredPopup(
                            context,
                            bankId,
                            charityId,
                            totalTransfer,
                            transactionNumber,
                            userId,
                            transactionId,
                          ),
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

  void _showCenteredPopup(BuildContext context, String bankId, String charityId,
      donationPrice, transactionNumber, String userId, String trasactionId) {
    final TransactionsController controller = Get.put(TransactionsController());
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
                          child: Image.asset('assets/icons/icon_dompet.png')),
                      Container(
                        width: 50,
                        height: 50,
                        margin: EdgeInsets.only(left: 50, bottom: 40),
                        child: Image.asset(
                          'assets/icons/icon_ceklis.png',
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
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
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
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          minimumSize:
                              Size(MediaQuery.of(context).size.width * 0.3, 32),
                          padding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 16),
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
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: basecolor,
                          padding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 16),
                        ),
                        onPressed: () async {
                          try {
                            print(
                                'Attempting to update transaction with ID: $charityId');
                            print('New status: 2');

                            final newTransaction = Transaction(
                              transactionNumber: transactionNumber,
                              status: 2,
                              donationPrice: double.tryParse(donationPrice),
                              bankId: bankId,
                              charityId: charityId,
                              userId: userId,
                              updatedAt: DateTime.now(),
                            );
                            print('transactionNumber : $transactionNumber');
                            Navigator.pop(context);
                            // Add timeout to prevent indefinite waiting
                            await controller.updateTransaction(
                                newTransaction, trasactionId);

                            Get.toNamed(Routes.SEND_MONEY,
                                arguments: {'idTransaksi': trasactionId});
                            print('Update method called');
                          } catch (e) {
                            print('Error updating transaction: $e');
                            // Show an error dialog or snackbar
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                      Text('Failed to update transaction: $e')),
                            );
                          }
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
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Text(
              nomorRekening,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
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
