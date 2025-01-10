import 'package:dompet_mal/app/modules/category/views/category_view.dart';
import 'package:dompet_mal/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Contoh data JSON
const List<Map<String, String>> CATEGORYData = [
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

// Halaman CATEGORY yang akan dituju

class CATEGORYGrid extends StatelessWidget {
  final String label;
  final String iconPath;

  const CATEGORYGrid({
    required this.label,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              if (label == "Lihat Semua") {
                Get.toNamed(Routes.CATEGORY); // Navigasi ke halaman CATEGORY
              }
            },
            child: Image.asset(
              iconPath,
              width: 40,
              height: 40,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 12), // Spasi antara ikon dan teks
          Container(
            width: 65,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}

class CATEGORYGridIcon extends StatelessWidget {
  const CATEGORYGridIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          CATEGORYData.length,
          (index) {
            final item = CATEGORYData[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: CATEGORYGrid(
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
