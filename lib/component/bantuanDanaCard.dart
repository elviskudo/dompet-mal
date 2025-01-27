import 'package:avatar_stack/avatar_stack.dart';
import 'package:dompet_mal/app/modules/(admin)/transactions/controllers/transactions_controller.dart';
import 'package:dompet_mal/app/routes/app_pages.dart';
import 'package:dompet_mal/component/donationSlider.dart';
import 'package:dompet_mal/component/sectionHeader.dart';
import 'package:dompet_mal/models/BankModel.dart';
import 'package:dompet_mal/models/Category.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:dompet_mal/models/CharityModel.dart';
import 'package:dompet_mal/color/color.dart';
import 'package:shimmer/shimmer.dart';

class EmergencyFundSection extends StatefulWidget {
  final List<Charity> banners;
  final List<Category> category;

  final int maxItems;

  const EmergencyFundSection(
      {Key? key,
      required this.banners,
      required this.maxItems,
      required this.category})
      : super(key: key);

  @override
  State<EmergencyFundSection> createState() => _EmergencyFundSectionState();
}

class _EmergencyFundSectionState extends State<EmergencyFundSection> {
  @override
  Widget build(BuildContext context) {
    // Filter the banners based on maxItems
    final displayBanners = widget.maxItems > 0
        ? widget.banners.take(widget.maxItems).toList()
        : widget.banners;

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // Header section
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 6),
            child: SectionHeader(
              title: 'Bantuan Dana Darurat',
              actionText: 'Lihat lainnya',
              onActionPressed: () {
                Get.toNamed(Routes.ListDonation);
              },
            ),
          ),

          // Cards section
          SizedBox(
            height: MediaQuery.of(context).size.height *
                0.51, // Adjust the height to fit the cards
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: displayBanners.length,
              itemBuilder: (context, index) {
                final banner = displayBanners[index];
                var categoryName = widget.category
                    .firstWhere(
                      (cat) => cat.id == banner.categoryId,
                      orElse: () => Category(name: 'Unknown Category'),
                    )
                    .name!;
                return Padding(
                  padding: EdgeInsets.only(
                    right: index == displayBanners.length - 1 ? 0 : 16,
                  ),
                  child: SizedBox(
                    width: 300, // Adjust the width of the card
                    child: EmergencyFundCard(
                      fund: banner,
                      category: widget.category,
                      onTap: () {
                        // Handle tap, navigate to the donation details page
                        Get.toNamed('/donation-detail-page', arguments: {
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
                    ),
                  ),
                );
              },
            ),
          ),
          Gap(24)
        ],
      ),
    );
  }
}

class EmergencyFundCard extends StatelessWidget {
  final Charity fund;
  final List<Category> category;
  final VoidCallback onTap;
  final TransactionsController transactionController =
      Get.put(TransactionsController());

  EmergencyFundCard({
    Key? key,
    required this.fund,
    required this.category,
    required this.onTap,
  }) : super(key: key);

  // Format currency in Rupiah
  String formatCurrency(int? amount) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );
    return formatter.format(amount ?? 0);
  }

  double calculateProgress(int? total, int? targetTotal) {
    if (targetTotal == null || targetTotal == 0 || total == null) {
      return 0.0;
    }
    // Calculate progress as a percentage (0.0 to 1.0)
    return total / targetTotal;
  }

  Widget _buildDonationButton(
      BuildContext context, String charityId, String categoryName) {
    return Obx(() {
      final latestTransaction = transactionController.transactions
          .where((t) =>
              t.charityId == charityId &&
              t.userId == transactionController.userId.value)
          .toList()
        ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

      if (latestTransaction.isEmpty) {
        return _normalDonationButton(context, charityId, categoryName);
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
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                minimumSize: Size(80, 24),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                backgroundColor: const Color(0xffFFA500),
                foregroundColor: Colors.white,
              ),
              child: const Text(
                "Lanjutkan Pembayaran",
                style: TextStyle(fontSize: 14),
              ),
            );
          },
        );
      } else {
        return _normalDonationButton(context, charityId, categoryName);
      }
    });
  }

  Widget _normalDonationButton(
      BuildContext context, String charityId, String categoryName) {
    return ElevatedButton(
      onPressed: () {
        Get.bottomSheet(
          SlidingDonationSheet(
            kategoriId: charityId,
            charityId: charityId,
            kategori: categoryName,
          ),
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
        );
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        minimumSize: Size(80, 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: const Color(0xff4B76D9),
        foregroundColor: Colors.white,
      ),
      child: const Text(
        "Donasi",
        style: TextStyle(fontSize: 14),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double progressValue = calculateProgress(fund.total, fund.targetTotal);
    int progressPercentage = (progressValue * 100).round();
    var categoryName = category
        .firstWhere(
          (cat) => cat.id == fund.categoryId,
          orElse: () => Category(name: 'Unknown Category'),
        )
        .name!;
    return Card(
      shadowColor: Colors.black,
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                fund.image ?? 'https://via.placeholder.com/150',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.image, size: 50),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fund.title ?? 'Untitled Charity',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progressValue,
                      minHeight: 8,
                      backgroundColor: baseGray,
                      valueColor: AlwaysStoppedAnimation<Color>(basecolor),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Terkumpul',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          Gap(2),
                          Text(
                            formatCurrency(fund.total),
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 12),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'Sisa hari',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          Gap(2),
                          Text(
                            '35', // This was hardcoded in the original, you might want to calculate dynamically
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Flexible(
                        child: AvatarStack(
                          height: 30,
                          avatars: fund.contributors.map((contributor) {
                            return NetworkImage(
                              contributor.user?.imageUrl ??
                                  'https://via.placeholder.com/40', // Update with actual avatar URL if available
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${fund.contributors.length} penyumbang',
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    ],
                  ),
                  Gap(8),
                  Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    width: double.infinity,
                    child: _buildDonationButton(
                      context,
                      fund.id!,
                      categoryName,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmergencyFundSkeleton extends StatelessWidget {
  final int itemCount;

  const EmergencyFundSkeleton({
    Key? key,
    this.itemCount = 3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // Header skeleton
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 150,
                    height: 24,
                    color: Colors.white,
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 80,
                    height: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // Cards section
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.51,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: itemCount,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                    right: index == itemCount - 1 ? 0 : 16,
                  ),
                  child: SizedBox(
                    width: 300,
                    child: Card(
                      shadowColor: Colors.black,
                      color: Colors.white,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Image skeleton
                          Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: double.infinity,
                              height: 180,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Title skeleton
                                Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    width: double.infinity,
                                    height: 20,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                // Progress bar skeleton
                                Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    width: double.infinity,
                                    height: 8,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                // Collected and Days Left skeleton
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Shimmer.fromColors(
                                          baseColor: Colors.grey[300]!,
                                          highlightColor: Colors.grey[100]!,
                                          child: Container(
                                            width: 80,
                                            height: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Gap(2),
                                        Shimmer.fromColors(
                                          baseColor: Colors.grey[300]!,
                                          highlightColor: Colors.grey[100]!,
                                          child: Container(
                                            width: 100,
                                            height: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Shimmer.fromColors(
                                          baseColor: Colors.grey[300]!,
                                          highlightColor: Colors.grey[100]!,
                                          child: Container(
                                            width: 60,
                                            height: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Gap(2),
                                        Shimmer.fromColors(
                                          baseColor: Colors.grey[300]!,
                                          highlightColor: Colors.grey[100]!,
                                          child: Container(
                                            width: 40,
                                            height: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                // Contributors skeleton
                                Row(
                                  children: [
                                    Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Container(
                                        width: 100,
                                        height: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                Gap(8),
                                // Donate button skeleton
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
                    ),
                  ),
                );
              },
            ),
          ),
          Gap(24)
        ],
      ),
    );
  }
}
