import 'package:avatar_stack/avatar_stack.dart';
import 'package:dompet_mal/color/color.dart';
import 'package:dompet_mal/component/donationSlider.dart';
import 'package:dompet_mal/models/pilihanKategoriModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BannerKategori extends StatefulWidget {
  final List<CharityByCategory> banners;

  const BannerKategori({super.key, required this.banners});

  @override
  State<BannerKategori> createState() => _BannerKategoriState();
}

class _BannerKategoriState extends State<BannerKategori> {
  // Format currency
  String formatRupiah(num value) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatter.format(value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: List.generate(
      3,
      (index) {
        final banner = widget.banners[index];
        return GestureDetector(
          onTap: () {
            Get.toNamed("/donation-detail-page", arguments: banner);
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 235,
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
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align content to top
              children: [
                Stack(
                  children: [
                    Container(
                      width: 140,
                      height: 235, // Make image full height
                      decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.horizontal(left: Radius.circular(10)),
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://storage.googleapis.com/a1aa/image/0qqXRyBOOW6DN1p8PQe1fBSNBQ5y3rSnVbuE5LhRhOV3W8CUA.jpg',
                          ),
                          fit: BoxFit.cover,
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
                        child: const Text(
                          '120 hari',
                          style: TextStyle(
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
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween, // Distribute space evenly
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              banner.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              maxLines: 2, // Limit to 2 lines
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              banner.category.name,
                              style: TextStyle(
                                color: Colors.grey[800],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 5,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                Container(
                                  height: 5,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    color: basecolor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Terkumpul',
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              formatRupiah(banner.totalCharities),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: AvatarStack(
                                height: 30,
                                avatars: banner.contributors.map((contributor) {
                                  return NetworkImage(
                                    contributor.avatarUrl ??
                                        'https://via.placeholder.com/40',
                                  );
                                }).toList(),
                              ),
                            ),
                            Text(
                              '${banner.contributors.length} penyumbang',
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                Get.bottomSheet(
                                   SlidingDonationSheet(),
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
                ),
              ],
            ),
          ),
        );
      },
    ));
  }
}