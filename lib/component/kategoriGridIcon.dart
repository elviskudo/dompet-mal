import 'package:flutter/material.dart';

class KategoriGridIcon extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color iconColor;

  const KategoriGridIcon({
    required this.label,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: iconColor,
          size: 40, // Ukuran ikon
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

class KategoriGridScreen extends StatelessWidget {
  const KategoriGridScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GridView.count(
          crossAxisCount: 4,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          padding: const EdgeInsets.all(16),
          children: const [
            KategoriGridIcon(
              label: "Bencana\nAlam",
              icon: Icons.home, // Ganti dengan ikon khusus
              iconColor: Colors.orange,
            ),
            KategoriGridIcon(
              label: "Bantuan\nMedis & Kesehatan",
              icon: Icons.favorite,
              iconColor: Colors.red,
            ),
            KategoriGridIcon(
              label: "Lingkungan",
              icon: Icons.nature,
              iconColor: Colors.green,
            ),
            KategoriGridIcon(
              label: "Kegiatan\nSosial",
              icon: Icons.people,
              iconColor: Colors.blue,
            ),
            KategoriGridIcon(
              label: "Lihat Semua",
              icon: Icons.grid_view,
              iconColor: Colors.lightBlue,
            ),
          ],
        ),
      ),
    );
  }
}