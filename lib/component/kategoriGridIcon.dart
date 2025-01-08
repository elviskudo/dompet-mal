import 'package:flutter/material.dart';

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
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          iconPath,
          width: 40,
          height: 40,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 8), // Spasi antara ikon dan teks
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
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