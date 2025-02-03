import 'dart:async';
import 'dart:math';

import 'package:dompet_mal/app/modules/(admin)/charityAdmin/controllers/charity_admin_controller.dart';
import 'package:dompet_mal/app/modules/(admin)/transactions/controllers/transactions_controller.dart';
import 'package:dompet_mal/app/routes/app_pages.dart';
import 'package:dompet_mal/app/routes/app_pages.dart';
import 'package:dompet_mal/color/color.dart';
import 'package:dompet_mal/component/AppBar.dart';
import 'package:dompet_mal/models/BankAccountModel.dart';
import 'package:dompet_mal/models/CharityModel.dart';
import 'package:dompet_mal/models/TransactionModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../controllers/konfirmasi_transfer_controller.dart';

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
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      );
    }

    final bankName =
        args['bankAccount'] as String? ?? 'Nama bank accounttidak tersedia';
    final bankId = args['bankId'] as String? ?? 'id bank tidak tersedia';
    final transactionNumber =
        args['transactionNumber'] as String? ?? 'Nama bank tidak tersedia';
    final transactionId =
        args['transactionId'] as String? ?? 'id transaksi tidak tersedia';
    final userId = args['userId'] as String? ?? 'Nama bank tidak tersedia';
    final bankImage =
        args['bankImage'] as String? ?? 'Image bank tidak tersedia';

    final charityId =
        args['charityId'] as String? ?? 'Nama charid id tidak tersedia';
    final bankNumber =
        args['bankNumber'] as String? ?? 'Nomor rekening tidak tersedia';
    // final String idTransaksi = "#DM110703412";
    var lebar = MediaQuery.of(context).size.width;
    // Handle both string and int types for amount
    final dynamic rawAmount = args['amount'] ?? 0;
    final int totalTransfer;

    if (rawAmount is String) {
      totalTransfer = int.parse(rawAmount);
    } else if (rawAmount is int) {
      totalTransfer = rawAmount;
    } else {
      totalTransfer = 0; // Default value if neither string nor int
      print('Warning: amount argument is neither string nor int');
    }
    // int.tryParse(totalTransfer)
    final namaKategori = args['kategori'] as String? ?? 'haha';
    final String idTransaksi =
        generateTransactionId(categoryName: namaKategori);

    // print('amount: $totalTransfer');
    final formatRupiah = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    final totalTransferFormatted = formatRupiah.format(totalTransfer! ?? 0);

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
              child: Text(
                "LAKUKAN TRANSFER KE REKENING",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
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
                      Text(
                        "Pastikan nominal sesuai hingga 2 digit terakhir",
                        style: GoogleFonts.poppins(
                            color: Colors.black, fontSize: 13),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Transfer sebelum 12 Desember 22:41 WIB atau transaksimu akan dibatalkan otomatis oleh sistem.",
                    style: GoogleFonts.poppins(color: Colors.grey[700]),
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
            Section_IdTransaksi(
              charityId: charityId,
              idTransaksi: idTransaksi,
            ),
            Container(
              width: lebar,
              color: baseGray,
              height: 6,
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    "Sudah transfer melalui ATM/Internet/mobile banking? Klik tombol di bawah untuk mengonfirmasi. Dompet Mal tidak memproses transaksi yang belum dikonfirmasi.",
                    style: GoogleFonts.poppins(color: Colors.grey),
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
                          child: Text(
                            "TRANSFER SEKARANG",
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
                            final TransactionsController controller =
                                Get.put(TransactionsController());

                            // Hapus transaksi berdasarkan transactionId
                            controller.deleteTransaction(transactionId);
                            Navigator.popUntil(
                                context, (route) => route.isFirst);
                          },
                          child: Text(
                            "BATALKAN TRANSAKSI",
                            style: GoogleFonts.poppins(
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

  void _showCenteredPopup(
      BuildContext context,
      String bankId,
      String charityId,
      int donationPrice,
      transactionNumber,
      String userId,
      String trasactionId) {
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
                Text(
                  'Sudah transfer ke rekening Dompet Mal?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                // Deskripsi
                Text(
                  'Transaksi baru akan diproses jika kamu sudah transfer ke rekening Dompet Mal melalui ATM, SMS Banking, Mobile Banking, atau Internet Banking.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
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
                        child: Text(
                          "BELUM",
                          style: GoogleFonts.poppins(
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
                              id: trasactionId,
                              transactionNumber: transactionNumber,
                              status: 2,
                              donationPrice: donationPrice,
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

                            Get.toNamed(Routes.SEND_MONEY, arguments: {
                              'idTransaksi': trasactionId,
                              'transactionNumber': transactionNumber,
                              'bankId': bankId,
                              'charityId': charityId,
                              'donationPrice': donationPrice,
                              'userId': userId,
                            });
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
                        child: Text(
                          "SUDAH",
                          style: GoogleFonts.poppins(
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
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
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
                style: GoogleFonts.poppins(color: Colors.red),
              ),
            ),
          )
          // ElevatedButton(
          //   style: ButtonStyle(

          //   ),
          //   onPressed: () {

          //   },
          //   child: Text("Salin"),
          // ),
        ],
      ),
    );
  }
}

class Section_IdTransaksi extends StatelessWidget {
  final String idTransaksi;
  final String charityId;

  Section_IdTransaksi({
    required this.idTransaksi,
    required this.charityId,
    // required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final CharityAdminController controller = Get.put(CharityAdminController());

    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "ID TRANSAKSI $idTransaksi",
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.bold),
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
          FutureBuilder<Charity?>(
            future: controller.getCharityById(charityId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error loading charity data'));
              }

              final charity = snapshot.data;
              if (charity == null) {
                return Center(child: Text('Charity not found'));
              }

              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  leading: charity.image != null && charity.image!.isNotEmpty
                      ? Image.network(
                          charity.image!,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/placeholder.png',
                              width: 50,
                              height: 50,
                            );
                          },
                        )
                      : Image.asset(
                          'assets/images/placeholder.png',
                          width: 50,
                          height: 50,
                        ),
                  title: Text(
                    charity.title ?? 'No Title',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    charity.created_at != null
                        ? DateFormat('dd MMMM yyyy HH:mm')
                            .format(charity.created_at!)
                        : 'Date not available',
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
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
        title: Text("Konfirmasi Modal"),
      ),
      body: const Center(
        child: Text("Halaman Konfirmasi Modal"),
      ),
    );
  }
}
