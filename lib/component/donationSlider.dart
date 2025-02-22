// ignore_for_file: override_on_non_overriding_member

import 'dart:math';

import 'package:dompet_mal/app/modules/(admin)/transactions/controllers/transactions_controller.dart';
import 'package:dompet_mal/app/modules/(home)/home/controllers/home_controller.dart';
import 'package:dompet_mal/app/routes/app_pages.dart';
import 'package:dompet_mal/models/BankAccountModel.dart';
import 'package:dompet_mal/models/BankModel.dart';
import 'package:dompet_mal/models/TransactionModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class SlidingDonationSheet extends StatefulWidget {
  @override
  final String kategoriId;
  final String kategori;
  final String charityId;
  final String targetDate;
  final String title;

  const SlidingDonationSheet({
    Key? key,
    required this.kategoriId,
    required this.kategori,
    required this.charityId,
    required this.targetDate,
    required this.title,
  }) : super(key: key);
  State<SlidingDonationSheet> createState() => _SlidingDonationSheetState();
}

class _SlidingDonationSheetState extends State<SlidingDonationSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  final donationController = Get.find<HomeController>();
  final TextEditingController _textController = TextEditingController();
  final Rx<Bank?> selectedBankAccount = Rx<Bank?>(null);

  final List<int> predefinedAmounts = [
    50000,
    100000,
    200000,
    300000,
    500000,
    1000000
  ];
  @override
  void initState() {
    super.initState();
    // Check if there's an argument passed
    if (Get.arguments != null) {
      selectedBankAccount.value = Get.arguments;
    }

    // Initial setup for text controller with formatting
    _textController.addListener(() {
      final text = _textController.text;
      // Remove 'Rp ' and '.' before processing
      final cleanValue = text.replaceAll('Rp ', '').replaceAll('.', '');
      donationController.setDonationAmount(cleanValue);
    });

    // Format initial amount if exists
    String initialAmount = donationController.donationAmount.value;
    if (initialAmount.isNotEmpty) {
      _textController.text = 'Rp ${_formatNumber(initialAmount)}';
    }
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();
  }

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

  int formatAmount2(String value) {
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

      return number;
    } catch (e) {
      print('Error formatting amount: $e');
      return 0;
    }
  }

  String _formatNumber(String value) {
    // Remove any existing formatting
    value = value.replaceAll('.', '');

    // Convert to integer first
    int? number = int.tryParse(value);
    if (number == null) return value;

    // Format with dots
    return number.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.');
  }

  @override
  void dispose() {
    _controller.dispose();
    _textController.dispose();
    super.dispose();
  }

  String formatRupiah(num value) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatter.format(value);
  }

  String formatRupiah2(num value) {
    final formatter = NumberFormat('#,##0', 'id_ID');
    return 'Rp ' + formatter.format(value).replaceAll(',', '.');
  }

  void _handleClose() async {
    await _controller.reverse();
    if (mounted && context.mounted) {
      Get.back();
    }
  }

  String generateTransactionNumber({
    required String categoryName,
  }) {
    // Create category initial from category name
    String categoryInitial =
        categoryName.split(' ').map((word) => word[0].toUpperCase()).join();

    // Get current date
    DateTime now = DateTime.now();
    String year = now.year.toString();
    String month = now.month.toString().padLeft(2, '0');

    // Generate random sequence
    Random random = Random();
    int randomSequence = random.nextInt(99999) + 1;
    String formattedSequence = randomSequence.toString().padLeft(4, '0');

    // Combine all parts to create transaction ID
    return "$categoryInitial$year$month$formattedSequence";
  }

  Widget _buildPaymentSection() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Obx(() {
              if (selectedBankAccount.value != null) {
                // Show bank account details when argument exists
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      selectedBankAccount.value!.image ??
                          'https://via.placeholder.com/150',
                      // fit: BoxFit.fill,
                      width: 73,
                      height: 24,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: const Icon(Icons.image, size: 50),
                        );
                      },
                    ), //
                    Text(
                      selectedBankAccount.value!.name!,
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Text(
                        selectedBankAccount.value!.accountNumber!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: GoogleFonts.poppins(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                );
              } else {
                // Show default text when no argument
                return Text(
                  'Rekening Pembayaran',
                  style: GoogleFonts.poppins(fontSize: 16),
                );
              }
            }),
          ),
          ElevatedButton(
            onPressed: () async {
              // Get result from payment-account-page
              final result = await Get.toNamed("payment-account-page");
              if (result != null && result is Bank) {
                selectedBankAccount.value = result;
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff4B76D9),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            ),
            child: Text(
              'Pilih',
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TransactionsController transactionsController =
        Get.put(TransactionsController());
    return GestureDetector(
      onVerticalDragEnd: (details) {
        if (details.primaryVelocity! > 500) {
          _handleClose();
        }
      },
      child: SlideTransition(
        position: _slideAnimation,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Text(
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                'Masukkan Nominal Donasi\nUntuk ${widget.title}', // Ubah text ini
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: predefinedAmounts.map((amount) {
                  return InkWell(
                    onTap: () {
                      donationController.setDonationAmount(amount.toString());
                      _textController.text = formatRupiah(amount);
                    },
                    child: Obx(() => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    donationController.donationAmount.value ==
                                            amount.toString()
                                        ? const Color(0xff4B76D9)
                                        : Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            formatRupiah(amount),
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: donationController.donationAmount.value ==
                                      amount.toString()
                                  ? const Color(0xff4B76D9)
                                  : Colors.black,
                            ),
                          ),
                        )),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Text(
                      'Rp',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Obx(() {
                        _textController.text =
                            donationController.donationAmount.value;
                        return TextField(
                          controller: _textController,
                          onChanged: (value) {
                            // Remove non-numeric characters
                            String cleanValue =
                                value.replaceAll(RegExp(r'[^\d]'), '');

                            // Convert to integer
                            int? number = int.tryParse(cleanValue);

                            if (number != null) {
                              // Format with Rupiah prefix
                              String formattedValue = formatRupiah2(number);

                              // Update text controller without triggering another onChanged
                              _textController.value = TextEditingValue(
                                text: formattedValue,
                                selection: TextSelection.collapsed(
                                    offset: formattedValue.length),
                              );

                              // Update donation amount
                              donationController
                                  .setDonationAmount(number.toString());
                            }
                          },
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: '0',
                          ),
                        );
                        ;
                      }),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Min. donasi sebesar Rp.10.000',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 16),
              _buildPaymentSection(),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: Obx(() => ElevatedButton(
                      onPressed: donationController.isLoading.value
                          ? null
                          : () async {
                              // Validasi bank account sudah dipilih
                              if (selectedBankAccount.value == null) {
                                Get.snackbar(
                                  'Peringatan',
                                  'Silahkan pilih rekening pembayaran terlebih dahulu',
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                );
                                return;
                              }

                              // Validasi jumlah donasi
                              final amount = formatAmount2(
                                  donationController.donationAmount.value);
                              if (amount == null || amount < 10000) {
                                Get.snackbar(
                                  'Peringatan',
                                  'Minimal donasi Rp 10.000',
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                );
                                return;
                              }
                              final transactionNumber =
                                  generateTransactionNumber(
                                categoryName: widget.kategori,
                              );

                              final transactionId = Uuid().v4();

                              await transactionsController.addTransaction(
                                  Transaction(
                                      id: transactionId,
                                      bankId: selectedBankAccount.value!.id,
                                      charityId: widget.charityId,
                                      userId:
                                          transactionsController.userId.value,
                                      updatedAt: DateTime.now(),
                                      transactionNumber: transactionNumber,
                                      donationPrice: amount,
                                      status: 1 // Pending
                                      ));

                              await transactionsController
                                  .getTransactionsWithNoGrouping();

                              Get.snackbar(
                                  'Berhasil transaksi', 'Status: pending');

                          

                              // Kirim data ke halaman konfirmasi
                              Get.toNamed(
                                Routes.KONFIRMASI_TRANSFER,
                                arguments: {
                                  'kategori': widget.kategori.toString(),
                                  'charityId': widget.charityId,
                                  // 'status': widget.,
                                  'bankImage': selectedBankAccount.value!.image,
                                  'transactionNumber': transactionNumber,
                                  'transactionId': transactionId,
                                  'bankId': selectedBankAccount.value!.id,
                                  'bankAccount':
                                      selectedBankAccount.value!.name,
                                  'userId':
                                      transactionsController.userId.value!,

                                  'bankNumber':
                                      selectedBankAccount.value!.accountNumber,
                                  'amount': amount,
                                  // Tambahkan data lain yang diperlukan
                                },
                              );
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff4B76D9),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: donationController.isLoading.value
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                              'Lanjut pembayaran',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
