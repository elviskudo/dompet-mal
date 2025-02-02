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
      // Parse string ke DateTime
      DateTime date = DateTime.parse(dateStr);
      // Format ke bahasa Indonesia
      final formatter = DateFormat('d MMMM yyyy', 'id_ID');
      return formatter.format(date);
    } catch (e) {
      print('Error parsing date: $e');
      return '-';
    }
  }

  // Add method to check for pending transactions
  Future<bool> hasUnpaidTransactions() async {
    final incompleteTransactions = transactionController.transactionsNoGroup
        .where((t) =>
            t.userId == transactionController.userId.value &&
            (t.status == 1 || t.status == 2))
        .toList();
    return incompleteTransactions.isNotEmpty;
  }

  // Show pending transaction warning
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

  Widget _buildDonationButton(
      BuildContext context, String charityId, String categoryName, targetDate, String title) {
    return Obx(() {
      final latestTransaction = transactionController.transactionsNoGroup
          .where((t) =>
              t.charityId == charityId &&
              t.userId == transactionController.userId.value &&
              (t.status == 1 || t.status == 2))
          .toList();

      // Sort berdasarkan created_at untuk mendapatkan transaksi terbaru
      latestTransaction.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

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
                  // Arahkan ke halaman Send Money jika status == 2
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
                          latestTransaction.first.donationPrice?.toString() ??
                              '0',
                    },
                  );
                } else {
                  // Tetap ke halaman KONFIRMASI_TRANSFER jika status == 1
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
                      'amount':
                          latestTransaction.first.donationPrice?.toString() ??
                              '0',
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

  Widget _normalDonationButton(
      BuildContext context, String charityId, String categoryName, targetDate,  String title) {
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
          return GestureDetector(
            onTap: () {
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
            child: Container(
              width: lebar * 0.49,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image
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
                  // Content
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
                          formatCurrency(
                              banner.total ?? 0), // Nilai default 0 jika null
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 12),
                        Text(
                          'Target Waktu Penyerahan',
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '${formatDate(banner.targetDate!)}',
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 2),
                        // Text(
                        //   formatDate(banner.created_at! ?? DateTime.now()),
                        //   style: GoogleFonts.poppins(
                        //     fontSize: 12,
                        //     fontWeight: FontWeight.w600,
                        //   ),
                        // ),
                        Gap(8),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          width: double.infinity,
                          child: _buildDonationButton(context, banner.id!,
                              categoryName, banner.targetDate!, banner.title!),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class Section extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color backgroundColor;

  const Section({
    Key? key,
    required this.child,
    this.padding,
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}

class HorizontalScrollRow extends StatelessWidget {
  final List<Widget> items;
  final double spacing;

  const HorizontalScrollRow({
    Key? key,
    required this.items,
    this.spacing = 12.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: items
            .asMap()
            .entries
            .map(
              (entry) => Padding(
                padding: EdgeInsets.only(
                    right: entry.key == items.length - 1 ? 0 : spacing),
                child: entry.value,
              ),
            )
            .toList(),
      ),
    );
  }
}

class StraightCharitySkeleton extends StatelessWidget {
  final int itemCount;

  const StraightCharitySkeleton({
    Key? key,
    this.itemCount = 3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var lebar = MediaQuery.of(context).size.width;
    var tinggi = MediaQuery.of(context).size.height;

    return Container(
      height: tinggi * 0.465,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return Container(
            width: lebar * 0.49,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Skeleton Image
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: double.infinity,
                    height: 140,
                    color: Colors.white,
                  ),
                ),
                // Skeleton Content
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: double.infinity,
                          height: 20,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: 100,
                          height: 14,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: 150,
                          height: 16,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: double.infinity,
                          height: 40,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
