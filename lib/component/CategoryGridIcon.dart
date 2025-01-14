import 'package:dompet_mal/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dompet_mal/models/pilihanKategoriModel.dart'; // Pastikan untuk mengimpor model kategori

class CATEGORYGrid extends StatelessWidget {
  const CATEGORYGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Menampilkan hanya 4 kategori pertama
          ...List.generate(
            categories.take(4).toList().length,
            (index) {
              final category = categories[index];
              return InkWell(
                onTap: () {
                  if (category.name == "Lihat Semua") {
                    Get.toNamed(Routes.CATEGORY); // Navigasi ke halaman CATEGORY
                  } else {
                    Get.toNamed(Routes.ListDonation,
                        arguments: category.id); // Navigasi ke daftar donasi
                  }
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1), // Warna latar belakang
                        borderRadius: BorderRadius.circular(12), // Sudut melengkung
                      ),
                      child: Image.asset(
                        category.categoryImage, // Gambar kategori
                        width: 24,
                        height: 24,
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: 65,
                      child: Text(
                        category.name, // Nama kategori
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          height: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          // Menambahkan ikon "Lihat Semua" di luar list kategori
          InkWell(
            onTap: () {
              Get.toNamed(Routes.CATEGORY); // Navigasi ke halaman CATEGORY
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1), // Warna latar belakang
                    borderRadius: BorderRadius.circular(12), // Sudut melengkung
                  ),
                  child: Icon(
                    Icons.view_list, // Ikon untuk "Lihat Semua"
                    size: 24,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  width: 65,
                  child: Text(
                    "Lihat Semua", // Nama untuk ikon
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      height: 1.2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
