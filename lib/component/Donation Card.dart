// in beranda_view.dart

import 'package:dompet_mal/color/color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EmergencyFundSection extends StatelessWidget {
  const EmergencyFundSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample data
    final List<EmergencyFund> funds = [
      EmergencyFund(
        title: 'Bantu Korban Bencana Banjir Kalimantan Barat',
        imageUrl: 'assets/images/banjir.jpg', // pastikan image ada di assets
        collectedAmount: 151472721,
        daysLeft: 35,
        totalDonors: 1500,
      ),
      EmergencyFund(
        title: 'Bantu Korban Gempa Bumi',
        imageUrl: 'assets/images/gempa.jpg',
        collectedAmount: 98650000,
        daysLeft: 28,
        totalDonors: 1200,
      ),
    ];

    return Column(
      children: [
        // Header section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                  // Navigate to list
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
          height: 380, // Sesuaikan dengan tinggi card
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: funds.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  right: index == funds.length - 1 ? 0 : 16,
                ),
                child: SizedBox(
                  width: 300, // Sesuaikan dengan lebar yang diinginkan
                  child: EmergencyFundCard(
                    fund: funds[index],
                    onTap: () {
                      // Handle tap
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class EmergencyFund {
  final String title;
  final String imageUrl;
  final int collectedAmount;
  final int daysLeft;
  final int totalDonors;

  EmergencyFund({
    required this.title,
    required this.imageUrl,
    required this.collectedAmount,
    required this.daysLeft,
    required this.totalDonors,
  });
}

class EmergencyFundCard extends StatelessWidget {
  final EmergencyFund fund;
  final VoidCallback onTap;

  const EmergencyFundCard({
    Key? key,
    required this.fund,
    required this.onTap,
  }) : super(key: key);

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
        hoverColor: Colors.white,
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.asset(
                fund.imageUrl,
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
                  LinearProgressIndicator(
                    value: 0.7,
                    minHeight: 8,
                    backgroundColor: baseGray,
                    valueColor: AlwaysStoppedAnimation<Color>(basecolor),
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
                            formatCurrency(fund.collectedAmount),
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
                            '${fund.daysLeft}',
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
                      SizedBox(
                        width: 70,
                        height: 30,
                        child: Stack(
                          children: List.generate(
                            3,
                            (index) => Positioned(
                              left: index * 20.0,
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.person,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${fund.totalDonors} penyumbang',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
