import 'package:avatar_stack/avatar_stack.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dompet_mal/app/modules/(admin)/contributorAdmin/controllers/contributor_admin_controller.dart';
import 'package:dompet_mal/app/modules/(admin)/transactions/controllers/transactions_controller.dart';
import 'package:dompet_mal/app/modules/(home)/donationDetailPage/controllers/donation_detail_page_controller.dart';
import 'package:dompet_mal/app/modules/(home)/myFavorite/controllers/my_favorite_controller.dart';
import 'package:dompet_mal/app/modules/(home)/myFavorite/views/my_favorite_view.dart';
import 'package:dompet_mal/app/modules/(home)/navigation/controllers/navigation_controller.dart';
import 'package:dompet_mal/app/modules/(home)/participantPage/views/participant_page_view.dart';
import 'package:dompet_mal/app/routes/app_pages.dart';
import 'package:dompet_mal/component/donationSlider.dart';
import 'package:dompet_mal/component/laporanCard.dart';
import 'package:dompet_mal/component/shareButton.dart';
import 'package:dompet_mal/models/Category.dart';
import 'package:dompet_mal/models/CharityModel.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DonationDetailView extends GetView<DonationDetailPageController> {
  @override
  final RxBool isExpanded = false.obs;
  final int collapsedLines = 3;
  formatRupiah(num value) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatter.format(value);
  }

  Widget build(BuildContext context) {
    final TransactionsController transactionsController =
        Get.put(TransactionsController());
    final MyFavoriteController favController = Get.put(MyFavoriteController());
    final arguments = Get.arguments as Map<String, dynamic>;
    final Map<String, dynamic>? detail = Get.arguments;

    if (detail == null) {
      print('Detail tidak ditemukan: $detail');
      return Scaffold(
        body: Center(
          child: Text('Data tidak tersedia'),
        ),
      );
    }

    final charity = detail['charity'];
    final categoryName = detail['categoryName'] ?? 'Kategori tidak tersedia';
    final targetDate = detail['targetDate'];
    double calculateProgress(int? total, int? targetTotal) {
      if (targetTotal == null || targetTotal == 0 || total == null) {
        return 0.0;
      }
      // Calculate progress as a percentage (0.0 to 1.0)
      return total / targetTotal;
    }

    double progressValue =
        calculateProgress(charity["total"], charity["targetTotal"]);
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

    print("Target Date Raw: ${charity["targetDate"]}");
    print("Target Date Type: ${charity["targetDate"].runtimeType}");
    print("Target Date: ${charity["targetDate"]}");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        // elevation: 0,
        title: Text(
          charity["title"],
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.poppins(),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: Obx(() {
              final isFavorited = favController.favorites.any((f) =>
                  f['charity_id'] == charity["id"] && f['is_favorite'] == true);
              return Icon(
                Icons.favorite,
                color: isFavorited ? Colors.red : Colors.grey,
              );
            }),
            onPressed: () => favController.toggleFavorite(charity["id"]),
          ),
          ShareButton(
            title: charity["title"] ?? "kk",
            contentToShare: 'Konten yang ingin dibagikan https://example.com',
          ),
          // IconButton(
          //   icon: Icon(Icons.more_vert, color: Colors.black),
          //   onPressed: () {},
          // ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    charity["image"] ?? 'https://via.placeholder.com/40',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Icon(Icons.image, size: 50, color: Colors.grey),
                      );
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    charity["title"] ?? 'Unknown',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 6,
                                horizontal: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xffFFE5CD),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                categoryName ?? "ss",
                                style: GoogleFonts.poppins(
                                  color: Color(0xffFF7B00),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Text(
                              calculateRemainingDays(charity["targetDate"]),
                              style: GoogleFonts.poppins(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            // charity["title"] ?? 'Unknown'
                            value: progressValue,
                            backgroundColor: Colors.grey[200],
                            color: Colors.blue,
                            minHeight: 6,
                          ),
                        ),
                        SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '${charity["progress"] <= 100 ? charity["progress"] : 100}%',
                            style: GoogleFonts.poppins(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Text(
                          'Terkumpul ${formatRupiah(charity["total"])}',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Target ${formatRupiah(charity["targetTotal"] ?? 0)}',
                          style: GoogleFonts.poppins(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Text(
                    'Penyelenggara',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          charity["companyImage"] ??
                              'https://via.placeholder.com/40',
                        ),
                        radius: 20,
                      ),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                charity["companyName"] ?? "s",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(
                                Icons.check_circle,
                                color: Colors.blue,
                                size: 16,
                              ),
                            ],
                          ),
                          Text(
                            'Penyelenggara terverifikasi',
                            style: GoogleFonts.poppins(
                              color: Color(0xff4B76D9),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Detail Donasi',
                        style: GoogleFonts.poppins(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        DateFormat('dd MMMM yyyy', 'id_ID')
                            .format(charity["created_at"]),
                        style: GoogleFonts.poppins(
                          color: Colors.grey[500],
                          fontSize: 14.0,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Dompet Mal',
                                style: GoogleFonts.poppins(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.toNamed(Routes.REPORT);
                                },
                                child: Text(
                                  'Lihat Semuanya >',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12.0,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Obx(() => Text(
                                charity["description"] ?? "",
                                style: GoogleFonts.poppins(fontSize: 14.0),
                                maxLines:
                                    isExpanded.value ? null : collapsedLines,
                                overflow: isExpanded.value
                                    ? TextOverflow.visible
                                    : TextOverflow.ellipsis,
                              )),
                        ],
                      ),
                      SizedBox(height: 24.0),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            // Toggle the expanded state
                            isExpanded.value = !isExpanded.value;
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFD6E1FF),
                            foregroundColor: Color(0xFF4B76D9),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            minimumSize: Size(160, 40),
                          ),
                          // Change button text based on expanded state
                          child: Obx(() => Text(isExpanded.value
                              ? 'Tutup'
                              : 'Baca Selengkapnya')),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Partisipan',
                        style: GoogleFonts.poppins(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween, // Mengatur spasi antar elemen
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(
                            child: AvatarStack(
                              height: 30,
                              avatars: (charity["contributors"] as List)
                                  .map((contributor) {
                                return NetworkImage(contributor["imageUrl"]);
                              }).toList(),
                            ),
                          ),
                          Text(
                            (charity["contributors"] as List).length.toString(),
                            style: GoogleFonts.poppins(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Partisipan',
                            style: GoogleFonts.poppins(
                              fontSize: 14.0,
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Tambahkan aksi yang ingin dilakukan saat tombol ditekan
                              Get.to(
                                ParticipantPage(),
                                arguments: {'charityId': charity["id"]},
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color(0xFFD6E1FF), // Warna latar belakang
                              foregroundColor: Color(0xFF4B76D9), // Warna teks
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    16), // Sesuaikan radius sesuai keinginan
                              ),
                              minimumSize: Size(110, 45), // Ukuran tombol
                            ),
                            child: Text('Lihat Donasi'),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Obx(() {
                        final relevantTransactions = transactionsController
                            .transactions
                            .where((t) => t.charityId == charity["id"])
                            .toList();

                        if (relevantTransactions.isNotEmpty) {
                          final latestTransaction = relevantTransactions.first;
                          // Show card only if status is delivered (4)
                          if (latestTransaction.status == 4) {
                            return Column(
                              children: [
                                laporanCard(
                                  context,
                                  transactionsController.banks
                                      .firstWhere((bank) =>
                                          bank.id == latestTransaction.bankId)
                                      .name,
                                  latestTransaction.donationPrice!
                                      .toStringAsFixed(0),
                                  latestTransaction.createdAt!,
                                ),
                                Gap(26),
                                Container(
                                  width: double.infinity,
                                  height: 60,
                                  child: ElevatedButton(
                                    onPressed: null, // Button is disabled
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey[
                                          400], // Using grey to indicate disabled state
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Text(
                                      'Penyerahan Dana',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                        }

                        // If not delivered, show regular donation button
                        return Container(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.bottomSheet(
                                SlidingDonationSheet(
                                  kategoriId: charity["categoryId"] ?? "",
                                  charityId: charity["id"] ?? "",
                                  kategori: categoryName ?? "",
                                  targetDate: targetDate ?? "",
                                  title: charity["title"] ?? "",
                                ),
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: (charity["total"] ?? 0) >=
                                      (charity["targetTotal"] ?? 0)
                                  ? Colors.green
                                  : const Color(0xff4B76D9),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              (charity["total"] ?? 0) >=
                                      (charity["targetTotal"] ?? 0)
                                  ? 'Target Tercapai'
                                  : 'Lanjut pembayaran',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        );
                      })
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
