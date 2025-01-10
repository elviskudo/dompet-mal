import 'package:dompet_mal/app/modules/home/controllers/home_controller.dart';
import 'package:dompet_mal/app/routes/app_pages.dart';
import 'package:dompet_mal/models/BankAccountModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SlidingDonationSheet extends StatefulWidget {
  SlidingDonationSheet({Key? key}) : super(key: key);

  @override
  State<SlidingDonationSheet> createState() => _SlidingDonationSheetState();
}

class _SlidingDonationSheetState extends State<SlidingDonationSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  final donationController = Get.find<HomeController>();
  final TextEditingController _textController = TextEditingController();
  final Rx<BankAccount?> selectedBankAccount = Rx<BankAccount?>(null);

  final List<int> predefinedAmounts = [
    50000,
    100000,
    150000,
    200000,
    500000,
    1000000
  ];

  @override
  void initState() {
    super.initState();
    // Check if there's an argument passed
    if (Get.arguments != null) {
      selectedBankAccount.value = Get.arguments as BankAccount;
    }
    print(selectedBankAccount.value);

    // Set initial value of TextField
    _textController.text = donationController.donationAmount.value;

    // Add listener to update controller when text changes
    _textController.addListener(() {
      final text = _textController.text;
      if (text != donationController.donationAmount.value) {
        donationController.setDonationAmount(text);
      }
    });

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

  void _handleClose() async {
    await _controller.reverse();
    if (mounted && context.mounted) {
      Get.back();
    }
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
                    Image.asset(
                      'images/mandiri.png',
                      width: 80,
                      height: 40,
                    ),
                    // const SizedBox(height: 4),
                    Text(
                      selectedBankAccount.value!.accountName,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      selectedBankAccount.value!.accountNumber,
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                );
              } else {
                // Show default text when no argument
                return const Text(
                  'Rekening Pembayaran',
                  style: TextStyle(fontSize: 16),
                );
              }
            }),
          ),
          ElevatedButton(
            onPressed: () async {
              // Get result from payment-account-page
              final result = await Get.toNamed("payment-account-page");
              if (result != null && result is BankAccount) {
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
            child: const Text(
              'Pilih',
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
              const Text(
                'Masukkan Nominal Donasi\nUntuk Dana Operasional',
                style: TextStyle(
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
                      _textController.text = amount.toString();
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
                            style: TextStyle(
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
                    const Text(
                      'Rp',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
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
                            final parsedValue =
                                int.tryParse(value.replaceAll('.', ''));
                            if (parsedValue != null) {
                              donationController
                                  .setDonationAmount(parsedValue.toString());
                            }
                          },
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: '0',
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Min. donasi sebesar Rp.10.000',
                style: TextStyle(
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
                              final amount = int.tryParse(
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

                              // Kirim data ke halaman konfirmasi
                              Get.toNamed(
                                Routes.KONFIRMASI_TRANSFER,
                                arguments: {
                                  'bankAccount': selectedBankAccount.value,
                                  'amount':
                                      donationController.donationAmount.value,
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
                          : const Text(
                              'Lanjut pembayaran',
                              style: TextStyle(
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
