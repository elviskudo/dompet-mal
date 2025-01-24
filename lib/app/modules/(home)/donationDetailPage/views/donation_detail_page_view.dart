import 'package:avatar_stack/avatar_stack.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dompet_mal/app/modules/(admin)/transactions/controllers/transactions_controller.dart';
import 'package:dompet_mal/app/modules/(home)/donationDetailPage/controllers/donation_detail_page_controller.dart';
import 'package:dompet_mal/app/modules/(home)/myFavorite/views/my_favorite_view.dart';
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
import 'package:intl/intl.dart';

class Gabungan {
  Charity? charity;
  List<Category> category;

  Gabungan({
    required this.category,
    required this.charity,
  });
}

class DonationDetailView extends GetView<DonationDetailPageController> {
  @override
  final RxBool isExpanded = false.obs;
  final int collapsedLines = 3;
  Future formatRupiah(num value) async {
    await value;
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatter.format(value);
  }

  final TransactionsController transactionsController =
      Get.put(TransactionsController());

  Widget build(BuildContext context) {
    Gabungan gabungan = Get.arguments as Gabungan;
    var categoryName = gabungan.category
        .firstWhere(
          (cat) => cat.id == gabungan.charity!.categoryId,
          orElse: () => Category(name: 'Unknown Category'),
        )
        .name!;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        // elevation: 0,
        title: Text(
          gabungan.charity!.title!,
          maxLines: 1,
          style: TextStyle(overflow: TextOverflow.ellipsis),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite, color: Colors.black),
            onPressed: () {
              print('---- ${gabungan.charity!}');
              print('---- ${gabungan.charity!.title}');
              Get.to(MyFavoriteView());
            },
          ),
          ShareButton(
            title: gabungan.charity!.title!,
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
                    gabungan.charity!.image!,
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
                    gabungan.charity!.title!,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
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
                                categoryName,
                                style: TextStyle(
                                  color: Color(0xffFF7B00),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              '1 Hari 5 Jam 30 Menit',
                              style: TextStyle(
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
                            value: gabungan.charity!.progress! / 100,
                            backgroundColor: Colors.grey[200],
                            color: Colors.blue,
                            minHeight: 6,
                          ),
                        ),
                        SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '${gabungan.charity!.progress}%',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Text(
                          'Terkumpul ${formatRupiah(gabungan.charity!.total!)}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Target ${formatRupiah(gabungan.charity!.targetTotal!)}',
                          style: TextStyle(
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
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            gabungan.charity!.companyImage ??
                                'https://placehold.co/40x40'),
                        radius: 20,
                      ),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                gabungan.charity!.companyName!,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
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
                            style: TextStyle(
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
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        DateFormat('dd MMMM yyyy', 'id_ID')
                            .format(gabungan.charity!.created_at!),
                        style: TextStyle(
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
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.toNamed(Routes.REPORT);
                                },
                                child: Text(
                                  'Lihat Semuanya >',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Obx(() => Text(
                                gabungan.charity!.description!,
                                style: TextStyle(fontSize: 14.0),
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
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
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
                              avatars: gabungan.charity!.contributors
                                  .map((contributor) {
                                return NetworkImage(
                                  contributor.user!.imageUrl ??
                                      'https://via.placeholder.com/40',
                                );
                              }).toList(),
                            ),
                          ),
                          Text(
                            gabungan.charity!.contributors.length.toString(),
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Partisipan',
                            style: TextStyle(
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
                              Get.to(ParticipantPage());
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
                      Obx(
                        () {
                          if (transactionsController.transactions.isNotEmpty) {
                            final latestTransaction =
                                transactionsController.transactions.first;
                            return laporanCard(
                              context,
                              transactionsController.banks
                                  .firstWhere((bank) =>
                                      bank.id == latestTransaction.bankId)
                                  .name,
                              latestTransaction.donationPrice!
                                  .toStringAsFixed(0),
                              latestTransaction.createdAt!,
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        },
                      ),
                      Gap(26),
                      Container(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.bottomSheet(
                              SlidingDonationSheet(
                                kategoriId: gabungan.charity!.categoryId!,
                                charityId: gabungan.charity!.id!,
                                kategori: categoryName,
                              ),
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff4B76D9),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Lanjut pembayaran',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
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
