import 'package:avatar_stack/avatar_stack.dart';
import 'package:dompet_mal/app/modules/(home)/donationDetailPage/views/donation_detail_page_view.dart';
import 'package:dompet_mal/color/color.dart';
import 'package:dompet_mal/component/donationSlider.dart';
import 'package:dompet_mal/models/Category.dart';
import 'package:dompet_mal/models/CharityModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
    final displayBanners = widget.maxItems > 0
        ? widget.banners.take(widget.maxItems).toList()
        : widget.banners;

    return Column(
        children: List.generate(
      displayBanners.length,
      (index) {
        final banner = displayBanners[index];
        return GestureDetector(
          onTap: () {
            Get.toNamed("/donation-detail-page", arguments: Gabungan(
                    category: widget.category ,
                    charity: banner,
                  ));
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              banner.title ?? 'Unnamed Charity',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
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
                              style: TextStyle(
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
                                value: (banner.progress ?? 0) / 100,
                                backgroundColor: Colors.grey[200],
                                color: Colors.blue,
                                minHeight: 6,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Terkumpul',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              formatRupiah(banner.total ?? 0),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
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
                                  print(
                                      'user avatar: ${contributor.user?.imageUrl}');
                                  return NetworkImage(
                                    contributor.user?.imageUrl ??
                                        'https://via.placeholder.com/40',
                                  );
                                }).toList(),
                              ),
                            ),
                            Text(
                              '${banner.contributors.length} penyumbang',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                Get.bottomSheet(
                                  SlidingDonationSheet(
                                    kategoriId: banner.categoryId!,
                                    charityId: banner.id!,
                                    kategori:  widget.category
                              .firstWhere(
                                (cat) => cat.id == banner.categoryId,
                                orElse: () =>
                                    Category(name: 'Unknown Category'),
                              )
                              .name!,
                                  ),
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  backgroundColor: Color(0xff4B76D9),
                                  foregroundColor: Colors.white),
                              child: Text(
                                "Donasi",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              )),
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
