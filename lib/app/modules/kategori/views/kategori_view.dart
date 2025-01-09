import 'package:dompet_mal/app/routes/app_pages.dart';
import 'package:dompet_mal/component/AppBar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/kategori_controller.dart';

class KategoriView extends GetView<KategoriController> {
  KategoriView({super.key});
  final List<Map<String, dynamic>> categories = [
    {
      'image': 'icons/lihat_semua.png',
      'label': 'Semua\nKategori',
      'color': Colors.blue,
    },
    {
      'image': 'icons/icon_bencana.png',
      'label': 'Bencana\nAlam',
      'color': Colors.orange,
    },
    {
      'image': 'icons/bayi.png',
      'label': 'Balita &\nAnak Sakit',
      'color': Colors.blue,
    },
    {
      'image': 'icons/icon_medis.png',
      'label': 'Bantuan Medis\n& Kesehatan',
      'color': Colors.red,
    },
    {
      'image': 'icons/tas.png',
      'label': 'Bantuan\nPendidikan',
      'color': Colors.blue,
    },
    {
      'image': 'icons/icon_lingkungan.png',
      'label': 'Lingkungan',
      'color': Colors.green,
    },
    {
      'image': 'icons/icon_kegiatan.png',
      'label': 'Kegiatan\nSosial',
      'color': Colors.blue,
    },
    {
      'image': 'icons/infrastruktur.png',
      'label': 'Infrastruktur\nUmum',
      'color': Colors.blue,
    },
    {
      'image': 'icons/karya_kreatif.png',
      'label': 'Karya Kreatif &\nModal Usaha',
      'color': Colors.blue,
    },
    {
      'image': 'icons/disable.png',
      'label': 'Menolong\nHewan',
      'color': Colors.grey,
    },
    {
      'image': 'icons/icon_lainnya.png',
      'label': 'Rumah\nIbadah',
      'color': Colors.grey,
    },
    {
      'image': 'icons/disable.png',
      'label': 'Difabel',
      'color': Colors.orange,
    },
    {
      'image': 'icons/zakat.png',
      'label': 'Zakat',
      'color': Colors.green,
    },
    {
      'image': 'icons/panti_asuhan.png',
      'label': 'Panti Asuhan\ndan Kaum Du\'afa',
      'color': Colors.orange,
    },
    {
      'image': 'icons/foto_dummy.png',
      'label': 'Pelari Baik',
      'color': Colors.blue,
    },
    {
      'image': 'icons/kemanusiaan.png',
      'label': 'Kemanusiaan',
      'color': Colors.blue,
    },
    {
      'image': 'icons/panti_jompo.png',
      'label': 'Panti Jompo',
      'color': Colors.blue,
    },
  ];

  void handleCategoryTap(int index) {
    if (index == 0) {
      Get.toNamed(Routes.LIST_DONASI); // Navigate using GetX
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar2(
        title: 'Kategori',
        color: Colors.white,
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 0.8,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () => handleCategoryTap(index),
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: categories[index]['color'].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.asset(
                    categories[index]['image'],
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text(
                categories[index]['label'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  height: 1.2,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
