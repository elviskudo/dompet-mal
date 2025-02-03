import 'package:dompet_mal/app/modules/(home)/donationDetailPage/views/donation_detail_page_view.dart';
import 'package:dompet_mal/models/Category.dart';
import 'package:dompet_mal/models/CharityModel.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:shimmer/shimmer.dart';

class BannerSlider extends StatefulWidget {
  final List<Charity> banners;
  final List<Category> category;

  const BannerSlider({
    Key? key,
    required this.banners,
    required this.category,
  }) : super(key: key);

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  int _currentIndex = 0;

  String formatRupiah(num value) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatter.format(value);
  }

  double calculateProgress(int? total, int? targetTotal) {
    if (targetTotal == null || targetTotal == 0 || total == null) {
      return 0.0;
    }
    return total / targetTotal;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          CarouselSlider.builder(
            itemCount: widget.banners.length,
            itemBuilder: (context, index, realIndex) {
              final banner = widget.banners[index];
              var categoryName = widget.category
                  .firstWhere(
                    (cat) => cat.id == banner.categoryId,
                    orElse: () => Category(name: 'Unknown Category'),
                  )
                  .name!;
              double progressValue =
                  calculateProgress(banner.total, banner.targetTotal);

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
                      "targetDate": banner.targetDate ,
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
                  margin: const EdgeInsets.symmetric(horizontal: 0.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.transparent,
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          banner.image! ?? "",
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 215,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[300],
                              child: const Icon(Icons.image, size: 50),
                            );
                          },
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(0.6),
                              Colors.transparent,
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              banner.title! ?? "",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                shadows: [
                                  Shadow(
                                    color: Colors.black,
                                    offset: Offset(1, 1),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              banner.description! ?? "",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                color: Colors.white70,
                                fontSize: 12,
                                shadows: [
                                  Shadow(
                                    color: Colors.black,
                                    offset: Offset(1, 1),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              formatRupiah(banner.total ?? 0),
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                shadows: [
                                  Shadow(
                                    color: Colors.black,
                                    offset: Offset(1, 1),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: () {
                                Get.toNamed("/donation-detail-page",
                                    arguments: {
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
                                        "targetDate": banner.targetDate ,
                                        "companyImage":
                                            banner.companyImage ?? "",
                                        "created_at": banner.created_at,
                                        "contributors": banner.contributors
                                            .map((contributor) => {
                                                  "imageUrl": contributor
                                                          .user?.imageUrl ??
                                                      'https://via.placeholder.com/40'
                                                })
                                            .toList()
                                      }
                                    });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xffFFA450),
                                minimumSize: Size(80, 28),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                "Daftarkan sekarang",
                                style: GoogleFonts.poppins(
                                    color: Colors.white, fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            options: CarouselOptions(
              height: 215,
              viewportFraction: 0.9,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.banners.asMap().entries.map((entry) {
              return Container(
                width: 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue.withOpacity(
                    _currentIndex == entry.key ? 0.9 : 0.4,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class BannerSliderSkeleton extends StatelessWidget {
  const BannerSliderSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: Stack(
                  children: [
                    // Skeleton content mimicking the original banner
                    Positioned(
                      bottom: 18,
                      left: 18,
                      right: 18,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title skeleton
                          Container(
                            width: 200,
                            height: 24,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 8),
                          // Description skeleton
                          Container(
                            width: double.infinity,
                            height: 16,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: 150,
                            height: 16,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 12),
                          // Button skeleton
                          Container(
                            width: 150,
                            height: 40,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Indicator dots skeleton
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              3,
              (index) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
