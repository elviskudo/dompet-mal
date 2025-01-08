import 'package:dompet_mal/app/modules/kategori/views/kategori_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Contoh data JSON
const List<Map<String, String>> kategoriData = [
  {
    "label": "Bencana Alam",
    "iconPath": "icons/icon_bencana.png",
  },
  {
    "label": "Bantuan Medis & Kesehatan",
    "iconPath": "icons/icon_medis.png",
  },
  {
    "label": "Lingkungan",
    "iconPath": "icons/icon_lingkungan.png",
  },
  {
    "label": "Kegiatan Sosial",
    "iconPath": "icons/icon_kegiatan.png",
  },
  {
    "label": "Lihat Semua",
    "iconPath": "icons/icon_lainnya.png",
  },
];

// Halaman kategori yang akan dituju


class KategoriGrid extends StatelessWidget {
  final String label;
  final String iconPath;

  const KategoriGrid({
    required this.label,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            if (label == "Lihat Semua") {
              Get.to(
                  () => const KategoriView()); // Navigasi ke halaman kategori
            }
          },
          child: Image.asset(
            iconPath,
            width: 30,
            height: 30,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 12), // Spasi antara ikon dan teks
        Container(
          width: 55,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}

class KategoriGridIcon extends StatelessWidget {
  const KategoriGridIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          kategoriData.length,
          (index) {
            final item = kategoriData[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: KategoriGrid(
                label: item["label"] ?? "",
                iconPath: item["iconPath"] ?? "",
              ),
            );
          },
        ),
      ),
    );
  }
}
