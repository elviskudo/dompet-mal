import 'package:avatar_stack/avatar_stack.dart';
import 'package:dompet_mal/component/donationSlider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:dompet_mal/models/pilihanKategoriModel.dart';
import 'package:dompet_mal/color/color.dart';

class EmergencyFundSection extends StatefulWidget {
  final List<CharityByCategory> banners;
  final int maxItems;

  const EmergencyFundSection(
      {Key? key, required this.banners, required this.maxItems})
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Bantuan Dana Darurat',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to the full list
                  },
                  child: const Text(
                    'Lihat Lainnya',
                    style: TextStyle(color: secondary),
                  ),
                ),
              ],
            ),
          ),

          // Cards section
          SizedBox(
            height: 420, // Adjust the height to fit the cards
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: displayBanners.length,
              itemBuilder: (context, index) {
                final banner = displayBanners[index];
                return Padding(
                  padding: EdgeInsets.only(
                    right: index == displayBanners.length - 1 ? 0 : 16,
                  ),
                  child: SizedBox(
                    width: 300, // Adjust the width of the card
                    child: EmergencyFundCard(
                      fund: banner,
                      onTap: () {
                        // Handle tap, navigate to the donation details page
                        Get.toNamed('/donation-detail-page', arguments: banner);
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
  final CharityByCategory fund;
  final VoidCallback onTap;

  const EmergencyFundCard({
    Key? key,
    required this.fund,
    required this.onTap,
  }) : super(key: key);

  // Format currency in Rupiah
  String formatCurrency(int amount) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
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
                fund.imageUrls.isNotEmpty
                    ? fund.imageUrls[0]
                    : 'https://via.placeholder.com/150',
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
                    fund.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: fund.progress / 100,
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
                          Text(
                            formatCurrency(fund.totalCharities),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
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
                          Text(
                            '35',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
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
                              contributor.avatarUrl ??
                                  'https://via.placeholder.com/40',
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${fund.contributors.length} penyumbang',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  Gap(8),
                  Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          Get.bottomSheet(
                            SlidingDonationSheet(
                              kategori: fund.category.name,
                            ),
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            backgroundColor: const Color(0xff4B76D9),
                            foregroundColor: Colors.white),
                        child: const Text("Donasi")),
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
