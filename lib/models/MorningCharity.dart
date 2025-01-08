class MorningCharity {
  final int id;
  final String uuid;
  final String title;
  final String caption;
  final String buttonTitle;
  final String imageUrl;
  final String createdAt;
  final String updatedAt;

  MorningCharity({
    required this.id,
    required this.uuid,
    required this.title,
    required this.caption,
    required this.buttonTitle,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });
}
final List<MorningCharity> dummyMorningCharity = [
  MorningCharity(
    id: 1,
    uuid: "1234-4534-3455",
    title: "Sedekah Subuh Hari Ini",
    caption: "Bahagiakan Anak Yatim & Dhuafa",
    buttonTitle: "Daftarkan Sekarang",
    imageUrl: "assets/banner2.png",
    createdAt: "2024-01-08",
    updatedAt: "2024-01-08",
  ),
  MorningCharity(
    id: 2,
    uuid: "1234-4534-3456",
    title: "Program Sedekah Subuh",
    caption: "Mari Berbagi Kebahagiaan",
    buttonTitle: "Daftarkan Sekarang",
    imageUrl: "assets/images/banner1.jpg",
    createdAt: "2024-01-08",
    updatedAt: "2024-01-08",
  ),
  MorningCharity(
    id: 3,
    uuid: "1234-4534-3457",
    title: "Wakaf Produktif",
    caption: "Bantu Sesama dengan Wakaf",
    buttonTitle: "Daftarkan Sekarang",
    imageUrl: "assets/images/banner1.jpg",
    createdAt: "2024-01-08",
    updatedAt: "2024-01-08",
  ),
];