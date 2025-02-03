import 'package:dompet_mal/app/modules/(admin)/charityAdmin/controllers/charity_admin_controller.dart';
import 'package:dompet_mal/app/modules/(admin)/transactions/controllers/transactions_controller.dart';
import 'package:dompet_mal/app/modules/(home)/donationDetailPage/views/donation_detail_page_view.dart';
import 'package:dompet_mal/app/routes/app_pages.dart';
import 'package:dompet_mal/color/color.dart';
import 'package:dompet_mal/component/donationSlider.dart';
import 'package:dompet_mal/models/BankModel.dart';
import 'package:dompet_mal/models/Category.dart';
import 'package:dompet_mal/models/CharityModel.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class StraightCharityComponent extends StatelessWidget {
  final List<Charity> banners;
  final List<Category> category;
  final int maxItems;
  final TransactionsController transactionController =
      Get.put(TransactionsController());

  StraightCharityComponent({
    Key? key,
    required this.banners,
    required this.category,
    this.maxItems = -1,
  }) : super(key: key);

  String formatCurrency(int amount) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }

  String formatDate(String? dateStr) {
    if (dateStr == null) return '-';

    try {
      DateTime date = DateTime.parse(dateStr);
      final formatter = DateFormat('d MMMM yyyy', 'id_ID');
      return formatter.format(date);
    } catch (e) {
      print('Error parsing date: $e');
      return '-';
    }
  }

  Future<bool> hasUnpaidTransactions() async {
    final incompleteTransactions = transactionController.transactionsNoGroup
        .where((t) =>
            t.userId == transactionController.userId.value &&
            (t.status == 1 || t.status == 2))
        .toList();
    return incompleteTransactions.isNotEmpty;
  }

  void _showPendingTransactionWarning(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Transaksi Pending',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Text(
            'Anda masih memiliki transaksi yang belum diselesaikan. Silakan selesaikan transaksi terlebih dahulu.',
            style: GoogleFonts.poppins(fontSize: 14),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Tutup',
                style: GoogleFonts.poppins(color: basecolor),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDonationButton(BuildContext context, String charityId,
      String categoryName, targetDate, String title) {
    return Obx(() {
      final latestTransaction = transactionController.transactionsNoGroup
          .where((t) =>
              t.charityId == charityId &&
              t.userId == transactionController.userId.value &&
              (t.status == 1 || t.status == 2))
          .toList();

      latestTransaction.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

      // Find the charity and calculate progress
      final charity = banners.firstWhere((b) => b.id == charityId);
      final progress = (charity.total ?? 0) / (charity.targetTotal ?? 1) * 100;

      // Show Terima button if progress >= 100%
      if (progress >= 100) {
        return ElevatedButton(
          onPressed: () {
            // Add your logic for when Terima is pressed
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  title: Text(
                    'Konfirmasi Penerimaan',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  content: Text(
                    'Apakah Anda yakin ingin menerima donasi ini?',
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Batal',
                        style: GoogleFonts.poppins(color: Colors.grey),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Add your confirmation logic here
                        Navigator.of(context).pop();
                        // Show success message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Donasi berhasil diterima',
                              style: GoogleFonts.poppins(),
                            ),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                      child: Text(
                        'Terima',
                        style: GoogleFonts.poppins(color: Colors.green),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            minimumSize: Size(80, 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: const Color(0xff4CAF50),
            foregroundColor: Colors.white,
          ),
          child: Text(
            "Terima",
            style: GoogleFonts.poppins(fontSize: 14),
          ),
        );
      }

      if (latestTransaction.isEmpty) {
        return _normalDonationButton(
            context, charityId, categoryName, targetDate, title);
      }

      final status = latestTransaction.first.status;
      if (status == 1 || status == 2) {
        return FutureBuilder<Bank?>(
          future: transactionController
              .getBankById(latestTransaction.first.bankId!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final bank = snapshot.data;
            return ElevatedButton(
              onPressed: () {
                if (status == 2) {
                  Get.toNamed(
                    Routes.SEND_MONEY,
                    arguments: {
                      'kategori': categoryName,
                      'charityId': charityId,
                      'bankImage': bank?.image,
                      'transactionNumber':
                          latestTransaction.first.transactionNumber,
                      'idTransaksi': latestTransaction.first.id,
                      'bankId': latestTransaction.first.bankId,
                      'bankAccount': bank?.name,
                      'userId': transactionController.userId.value,
                      'bankNumber': bank?.accountNumber,
                      'donationPrice':
                          latestTransaction.first.donationPrice ?? 0,
                    },
                  );
                } else {
                  Get.toNamed(
                    Routes.KONFIRMASI_TRANSFER,
                    arguments: {
                      'kategori': categoryName,
                      'charityId': charityId,
                      'bankImage': bank?.image,
                      'transactionNumber':
                          latestTransaction.first.transactionNumber,
                      'transactionId': latestTransaction.first.id,
                      'bankId': latestTransaction.first.bankId,
                      'bankAccount': bank?.name,
                      'userId': transactionController.userId.value,
                      'bankNumber': bank?.accountNumber,
                      'amount': latestTransaction.first.donationPrice ?? 0,
                    },
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                minimumSize: Size(80, 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                backgroundColor: const Color(0xffFFA500),
                foregroundColor: Colors.white,
              ),
              child: Text(
                "Lanjutkan Pembayaran",
                style: GoogleFonts.poppins(fontSize: 14),
              ),
            );
          },
        );
      } else {
        return _normalDonationButton(
            context, charityId, categoryName, targetDate, title);
      }
    });
  }

  Widget _normalDonationButton(BuildContext context, String charityId,
      String categoryName, targetDate, String title) {
    var lebar = MediaQuery.of(context).size.width;
    return ElevatedButton(
      onPressed: () {
        Get.bottomSheet(
          SlidingDonationSheet(
            targetDate: targetDate,
            kategoriId: charityId,
            charityId: charityId,
            kategori: categoryName,
            title: title,
          ),
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
        );
      },
      style: ElevatedButton.styleFrom(
        minimumSize: Size(lebar, 32),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: const Color(0xff4B76D9),
        foregroundColor: Colors.white,
      ),
      child: Text(
        "Donasi",
        style: GoogleFonts.poppins(fontSize: 12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var lebar = MediaQuery.of(context).size.width;
    var tinggi = MediaQuery.of(context).size.height;
    final displayBanners =
        maxItems > 0 ? banners.take(maxItems).toList() : banners;

    return Container(
      height: tinggi * 0.465,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: displayBanners.length,
        itemBuilder: (context, index) {
          var banner = displayBanners[index];
          var categoryName = category
              .firstWhere(
                (cat) => cat.id == banner.categoryId,
                orElse: () => Category(name: 'Unknown Category'),
              )
              .name!;

          // Hitung progress
          final progress =
              (banner.total ?? 0) / (banner.targetTotal ?? 1) * 100;
          final isCompleted = progress >= 100;

          return GestureDetector(
            onTap: isCompleted
                ? null
                : () {
                    Get.toNamed(Routes.DONATION_DETAIL_PAGE, arguments: {
                      "categoryName": categoryName,
                      "charity": {
                        "id": banner.id! ?? "",
                        "title": banner.title! ?? "",
                        "image": banner.image! ?? "",
                        "progress": banner.progress ?? 0,
                        "total": banner.total ?? 0,
                        "targetTotal": banner.targetTotal ?? 0,
                        "description": banner.description ?? '',
                        "categoryId": banner.categoryId ?? '',
                        "companyName": banner.companyName ?? "",
                        "companyImage": banner.companyImage ?? "",
                        "created_at": banner.created_at,
                        "targetDate": banner.targetDate,
                        "contributors": banner.contributors
                            .map((contributor) => {
                                  "imageUrl": contributor.user?.imageUrl ??
                                      'https://via.placeholder.com/40'
                                })
                            .toList()
                      }
                    });
                  },
            child: Opacity(
              opacity: isCompleted ? 0.6 : 1.0,
              child: Container(
                width: lebar * 0.49,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 140,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                            child: Image.network(
                              banner.image ?? 'https://via.placeholder.com/150',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey[300],
                                  child: const Icon(Icons.image, size: 50),
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 32,
                                child: Text(
                                  banner.title ?? 'Untitled Charity',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    height: 1.2,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                category
                                    .firstWhere(
                                      (cat) => cat.id == banner.categoryId,
                                      orElse: () =>
                                          Category(name: 'Unknown Category'),
                                    )
                                    .name!,
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  color: Colors.grey[800],
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Dana yang disetorkan',
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  color: Colors.black54,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                formatCurrency(banner.total ?? 0),
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Target',
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  color: Colors.black54,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                formatCurrency(banner.targetTotal ?? 0),
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // Tambahkan overlay "Completed" jika progress >= 100%
                    if (isCompleted)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'Completed',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
