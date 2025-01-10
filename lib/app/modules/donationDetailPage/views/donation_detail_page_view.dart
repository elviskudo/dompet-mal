import 'package:avatar_stack/avatar_stack.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dompet_mal/app/modules/donationDetailPage/controllers/donation_detail_page_controller.dart';
import 'package:dompet_mal/app/modules/participantPage/views/participant_page_view.dart';
import 'package:dompet_mal/models/pilihanKategoriModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DonationDetailView extends GetView<DonationDetailPageController> {
  @override
  String formatRupiah(num value) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatter.format(value);
  }
  final List<String> images = [
    'https://picsum.photos/id/237/400/600',
    'https://picsum.photos/id/238/400/600',
    'https://picsum.photos/id/239/400/600',
  ];
  Widget build(BuildContext context) {
    CharityByCategory bannerData = Get.arguments;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        // elevation: 0,
        title: Text(bannerData.title, maxLines: 1, style: TextStyle(
        overflow: TextOverflow.ellipsis
        ),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite, color: Colors.black),
            onPressed: () {
              print('---- ${bannerData}');
              print('---- ${bannerData.title}');
            },
          ),
          IconButton(
            icon: Icon(Icons.share, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: 350,
                    viewportFraction: 1.0,
                    onPageChanged: (index, reason) {
                      controller.updateSliderIndex(index);
                    },
                  ),
                  items: controller.imageList.map((item) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(
                        item,
                        fit: BoxFit.cover,
                      ),
                    );
                  }).toList(),
                ),
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: controller.imageList.asMap().entries.map((entry) {
                        return Container(
                          width: 8,
                          height: 8,
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: controller.currentSliderIndex.value == entry.key
                                ? Colors.white
                                : Colors.white.withOpacity(0.5),
                          ),
                        );
                      }).toList(),
                    ),
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
                    bannerData.title,
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
                                bannerData.category.name,
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
                            value: bannerData.progress / 100,
                            backgroundColor: Colors.grey[200],
                            color: Colors.blue,
                            minHeight: 6,
                          ),
                        ),
                        SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '${bannerData.progress}%',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Text(
                          'Terkumpul ${formatRupiah(bannerData.totalCharities)}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text(
                          'Target Rp200.000.000',
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
                        backgroundImage:
                            NetworkImage('https://placehold.co/40x40'),
                        radius: 20,
                      ),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Peduli Sahabat',
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
                        DateFormat('dd MMMM yyyy', 'id_ID').format(bannerData.createdAt)  ,
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 14.0,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'bannerData',
                        style: TextStyle(
                          // color: Colors.grey[700],
                          fontSize: 14.0,
                        ),
                      ),
                      SizedBox(height: 24.0),
                      Center(
                        child: Center(
                            child: ElevatedButton(
                          onPressed: () {
                            // Tambahkan aksi yang ingin dilakukan saat tombol ditekan
                            print('Tombol ditekan!');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Color(0xFFD6E1FF), // Warna latar belakang
                            foregroundColor: Color(0xFF4B76D9), // Warna teks
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  16), // Sesuaikan radius sesuai keinginan
                            ),
                            minimumSize: Size(160, 40), // Ukuran tombol
                          ),
                          child: Text('Baca Selengkapnya'),
                        )),
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
                            child:AvatarStack(
                                height: 30,
                                avatars: bannerData.contributors.map((contributor) {
                                  return NetworkImage(
                                    contributor.avatarUrl ??
                                        'https://via.placeholder.com/40',
                                  );
                                }).toList(),
                              ),
                          ),
                          Text(
                            bannerData.contributors.length.toString(),
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 5,),
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
                      Container(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff4B76D9),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
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
