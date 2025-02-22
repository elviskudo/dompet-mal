import 'package:dompet_mal/component/donationSlider.dart';
import 'package:dompet_mal/models/pilihanKategoriModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BannerDanaOperasional extends StatefulWidget {
  const BannerDanaOperasional({
    Key? key,
  }) : super(key: key);
  @override
  State<BannerDanaOperasional> createState() => _BannerDanaOperasionalState();
}

class _BannerDanaOperasionalState extends State<BannerDanaOperasional> {
  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Get.to(DetailDanaOperasionalView());
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () async {
              try {
                final allCharities = await supabase
                    .from('charities')
                    .select('id, title, category_id');

                print('All charities:');
                for (var charity in allCharities) {
                  print(
                      'Title: ${charity['title']}, ID: ${charity['id']}, Category: ${charity['category_id']}');
                }

                // Then try to find the specific charity
                final charityRes = await supabase
                    .from('charities')
                    .select()
                    .ilike('title',
                        '%dana operasional%')
                    .limit(1)
                    .single();

                Get.bottomSheet(
                  SlidingDonationSheet(
                    kategoriId: charityRes['category_id'],
                    charityId: charityRes['id'],
                    kategori: "Dana Operasional",
                    targetDate:
                        DateTime.now().add(Duration(days: 30)).toString(),
                    title: "Bantu Dana Operasional",
                  ),
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                );
              } catch (e) {
                print('Error fetching charity data: $e');
                Get.snackbar(
                  'Error',
                  'Tidak dapat memuat data donasi',
                  snackPosition: SnackPosition.BOTTOM,
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  // Icon container
                  Container(
                    width: 35,
                    height: 34,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset(
                      "assets/images/Group 323.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Text column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Bantu Dana Operasional",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue[600],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Kebaikan mu membantu kami",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Arrow icon
                  Icon(
                    Icons.chevron_right,
                    size: 32,
                    color: Colors.grey[800],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BannerDanaOperasionalSkeleton extends StatelessWidget {
  const BannerDanaOperasionalSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // Icon skeleton
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: 35,
                height: 34,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Text skeleton
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 200,
                      height: 20,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 150,
                      height: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            // Arrow skeleton
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: 32,
                height: 32,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
