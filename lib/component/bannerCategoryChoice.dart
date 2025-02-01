import 'package:avatar_stack/avatar_stack.dart';
import 'package:dompet_mal/app/modules/(admin)/contributorAdmin/controllers/contributor_admin_controller.dart';
import 'package:dompet_mal/app/modules/(admin)/transactions/controllers/transactions_controller.dart';
import 'package:dompet_mal/app/modules/(home)/donationDetailPage/views/donation_detail_page_view.dart';
import 'package:dompet_mal/app/routes/app_pages.dart';
import 'package:dompet_mal/color/color.dart';
import 'package:dompet_mal/component/donationSlider.dart';
import 'package:dompet_mal/models/BankModel.dart';
import 'package:dompet_mal/models/Category.dart';
import 'package:dompet_mal/models/CharityModel.dart';
import 'package:dompet_mal/models/TransactionModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:google_fonts/google_fonts.dart';

class BannerKategori extends StatefulWidget {
  final List<Charity> banners;
  final List<Category> category;
  final int maxItems;
  const BannerKategori(
      {super.key,
      required this.banners,
      required this.maxItems,
      required this.category});

  @override
  State<BannerKategori> createState() => _BannerKategoriState();
}

class _BannerKategoriState extends State<BannerKategori> {
  final TransactionsController transactionController =
      Get.put(TransactionsController());

  List<Contributor> getUniqueContributors(List<Contributor> contributors) {
    // Create a map using userId as key to ensure uniqueness
    final Map<String?, Contributor> uniqueContributors = {};

    for (var contributor in contributors) {
      if (contributor.user?.id != null) {
        // Only add if we haven't seen this user ID before
        uniqueContributors.putIfAbsent(contributor.user?.id, () => contributor);
      }
    }

    // Convert back to list
    return uniqueContributors.values.toList();
  }

  String calculateRemainingDays(String? targetDateStr) {
    if (targetDateStr == null) return 'N/A';

    try {
      // Parse target date string ke DateTime
      final targetDate = DateTime.parse(targetDateStr);
      final now = DateTime.now();

      // Hitung selisih hari dari sekarang sampai target date
      final difference = targetDate.difference(now);
      final days = difference.inDays;

      if (days < 0) {
        return 'Berakhir';
      } else if (days == 0) {
        // Jika tersisa kurang dari 24 jam, hitung jam
        final hours = difference.inHours;
        if (hours > 0) {
          return '$hours jam';
        }
        return 'Hari Terakhir';
      } else {
        return '$days hari';
      }
    } catch (e) {
      print('Error parsing date: $e');
      return 'N/A';
    }
  }

  // Modify the contributor section in the build method
  Widget buildContributorSection(List<Contributor> contributors) {
    final uniqueContributors = getUniqueContributors(contributors);

    return Row(
      children: [
        Flexible(
          child: AvatarStack(
            height: 30,
            avatars: uniqueContributors.map((contributor) {
              return NetworkImage(
                contributor.user?.imageUrl ?? 'https://via.placeholder.com/40',
              );
            }).toList(),
          ),
        ),
        Text(
          '${uniqueContributors.length} penyumbang',
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  // Format currency
  String formatRupiah(num value) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatter.format(value);
  }

  // Show pending transaction warning

  Widget _buildDonationButton(
      BuildContext context, String charityId, String categoryName, targetDate) {
    return Obx(() {
      final latestTransaction = transactionController.transactionsNoGroup.value
          .where((t) =>
              t.charityId == charityId &&
              t.userId == transactionController.userId.value &&
              (t.status == 1 || t.status == 2))
          .toList();
      // Sort berdasarkan created_at untuk mendapatkan transaksi terbaru
      latestTransaction.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

      if (latestTransaction.isEmpty) {
        return _normalDonationButton(context, charityId, categoryName, targetDate);
      }

      final mostRecentTransaction = latestTransaction.first;
      final status = mostRecentTransaction.status;
      // print('duit: $duit');
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
        return _normalDonationButton(context, charityId, categoryName, targetDate);
      }
    });
  }

  Widget _normalDonationButton(
      BuildContext context, String charityId, String categoryName, targetDate) {
    var lebar = MediaQuery.of(context).size.width;
    return ElevatedButton(
      onPressed: () {
        Get.bottomSheet(
          SlidingDonationSheet(
            targetDate: targetDate,
            kategoriId: charityId,
            charityId: charityId,
            kategori: categoryName,
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

  double calculateProgress(int? total, int? targetTotal) {
    if (targetTotal == null || targetTotal == 0 || total == null) {
      return 0.0;
    }
    // Calculate progress as a percentage (0.0 to 1.0)
    return total / targetTotal;
  }

  @override
  Widget build(BuildContext context) {
    final displayBanners = widget.maxItems > 0
        ? widget.banners.take(widget.maxItems).toList()
        : widget.banners;
    var lebar = MediaQuery.of(context).size.width;

    return Column(
        children: List.generate(
      displayBanners.length,
      (index) {
        final banner = displayBanners[index];
        double progressValue =
            calculateProgress(banner.total, banner.targetTotal);
        int progressPercentage = (progressValue * 100).round();
        var categoryName = widget.category
            .firstWhere(
              (cat) => cat.id == banner.categoryId,
              orElse: () => Category(name: 'Unknown Category'),
            )
            .name!;
        return GestureDetector(
          onTap: () {
            Get.toNamed("/donation-detail-page", arguments: {
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
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      width: 120,
                      height: MediaQuery.of(context).size.height * 0.3,
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
                    Positioned(
                      bottom: 12,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          calculateRemainingDays(banner.targetDate),
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              banner.title ?? 'Unnamed Charity',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            // You might need to adjust this based on how you fetch category
                            Text(
                              widget.category
                                  .firstWhere(
                                    (cat) => cat.id == banner.categoryId,
                                    orElse: () =>
                                        Category(name: 'Unknown Category'),
                                  )
                                  .name!,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.grey[800],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: progressValue,
                                backgroundColor: Colors.grey[200],
                                color: Colors.blue,
                                minHeight: 6,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Terkumpul',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              formatRupiah(banner.total ?? 0),
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        buildContributorSection(banner.contributors),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          width: double.infinity,
                          child: _buildDonationButton(
                            context,
                            banner.id!,
                            categoryName,
                            banner.targetDate
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ));
  }
}

class BannerSkeletonLoader extends StatelessWidget {
  final int itemCount;

  const BannerSkeletonLoader({Key? key, this.itemCount = 1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(itemCount, (index) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.3,
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Skeleton for image
                Container(
                  width: 120,
                  height: MediaQuery.of(context).size.height * 0.3,
                  color: Colors.white,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Skeleton for title
                        Container(
                          width: double.infinity,
                          height: 20,
                          color: Colors.white,
                        ),
                        // Skeleton for category
                        Container(
                          width: 100,
                          height: 15,
                          color: Colors.white,
                        ),
                        // Skeleton for progress bar
                        Container(
                          width: double.infinity,
                          height: 6,
                          color: Colors.white,
                        ),
                        // Skeleton for amount
                        Container(
                          width: 80,
                          height: 15,
                          color: Colors.white,
                        ),
                        // Skeleton for contributors
                        Row(
                          children: [
                            Container(
                              width: 80,
                              height: 30,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Container(
                              width: 50,
                              height: 15,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        // Skeleton for button
                        Container(
                          width: double.infinity,
                          height: 40,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
