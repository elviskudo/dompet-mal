class CharityByCategory {
  final int id;
  final String uuid;
  final String title;
  final List<String> imageUrls;
  final Category category;
  final int progress;
  final int totalCharities;
  final double targetCharityDonation;
  final Company company;
  final List<Contributor> contributors;
  final DateTime createdAt;
  final String updatedAt;
  final String description;

  CharityByCategory({
    required this.id,
    required this.uuid,
    required this.title,
    required this.imageUrls,
    required this.category,
    required this.progress,
    required this.totalCharities,
    required this.targetCharityDonation,
    required this.company,
    required this.contributors,
    required this.createdAt,
    required this.updatedAt,
    required this.description,
  });
}

class Category {
  final int id;
  final String name;
  final String categoryImage;
  Category({
    required this.id,
    required this.name,
    required this.categoryImage,
  });
}

class Company {
  final int id;
  final String uuid;
  final String companyName;
  final String image;

  Company({
    required this.id,
    required this.uuid,
    required this.companyName,
    required this.image,
  });
}

class Contributor {
  final int id;
  final String uuid;
  final String username;
  final String email;
  final String avatarUrl;
  final String createdAt;
  final String updatedAt;

  Contributor({
    required this.id,
    required this.uuid,
    required this.username,
    required this.email,
    required this.avatarUrl,
    required this.createdAt,
    required this.updatedAt,
  });
}

final List<CharityByCategory> dummyDataListCategoryBanner = [
  CharityByCategory(
    id: 1,
    uuid: "uuid-1",
    title: "Sedekah Jariyah 10.000 Quran ke seluruh negeri",
    description:
        "Sedekah Jariyah 10.000 Quran ke seluruh negeri Sedekah Jariyah 10.000 Quran ke seluruh negeri Sedekah Jariyah 10.000 Quran ke seluruh negeri ",
    imageUrls: [
      "https://picsum.photos/id/237/400/600",
      "https://example.com/image1-2.png"
    ],
    category: Category(
        id: 7,
        name: "Kegiatan Sosial",
        categoryImage: "icons/icon_kegiatan.png"),
    progress: 20,
    totalCharities: 151472721,
    targetCharityDonation: 200000000.0,
    company: Company(
      id: 1,
      uuid: "company-uuid-1",
      companyName: "PT Amal Sosial",
      image: "https://example.com/company1.png",
    ),
    contributors: [
      Contributor(
        id: 1,
        uuid: "uuid-contributor-1",
        username: "faiz",
        email: "faiz@gmail.com",
        avatarUrl: "https://example.com/avatar1.png",
        createdAt: "2025-01-01T00:00:00Z",
        updatedAt: "2025-01-02T00:00:00Z",
      ),
    ],
    createdAt: DateTime.parse("2025-01-01T00:00:00Z"),
    updatedAt: "2025-01-02T00:00:00Z",
  ),
  CharityByCategory(
    id: 1,
    uuid: "uuid-1",
    title: "Sedekah Jariyah 10.000 Quran ke seluruh negeri",
    description:
        "Sedekah Jariyah 10.000 Quran ke seluruh negeri Sedekah Jariyah 10.000 Quran ke seluruh negeri Sedekah Jariyah 10.000 Quran ke seluruh negeri ",
    imageUrls: [
      "https://picsum.photos/id/237/400/600",
      "https://example.com/image1-2.png"
    ],
    category: Category(
        id: 7,
        name: "Kegiatan Sosial",
        categoryImage: "icons/icon_kegiatan.png"),
    progress: 20,
    totalCharities: 151472721,
    targetCharityDonation: 200000000.0,
    company: Company(
      id: 1,
      uuid: "company-uuid-1",
      companyName: "PT Amal Sosial",
      image: "https://example.com/company1.png",
    ),
    contributors: [
      Contributor(
        id: 1,
        uuid: "uuid-contributor-1",
        username: "faiz",
        email: "faiz@gmail.com",
        avatarUrl: "https://example.com/avatar1.png",
        createdAt: "2025-01-01T00:00:00Z",
        updatedAt: "2025-01-02T00:00:00Z",
      ),
    ],
    createdAt: DateTime.parse("2025-01-01T00:00:00Z"),
    updatedAt: "2025-01-02T00:00:00Z",
  ),
  CharityByCategory(
    id: 2,
    uuid: "uuid-2",
    title: "Bantuan untuk Korban Bencana Alam",
    description:
        "Sedekah Jariyah 10.000 Quran ke seluruh negeri Sedekah Jariyah 10.000 Quran ke seluruh negeri Sedekah Jariyah 10.000 Quran ke seluruh negeri ",
    imageUrls: [
      "https://picsum.photos/id/237/400/600",
      "https://picsum.photos/id/237/400/600"
    ],
    category: Category(
        id: 2, name: "Bencana Alam", categoryImage: "icons/icon_bencana.png"),
    progress: 50,
    totalCharities: 98234562,
    targetCharityDonation: 150000000.0,
    company: Company(
      id: 2,
      uuid: "company-uuid-2",
      companyName: "Yayasan Peduli Bencana",
      image: "https://example.com/company2.png",
    ),
    contributors: [
      Contributor(
        id: 2,
        uuid: "uuid-contributor-2",
        username: "andika",
        email: "andika@gmail.com",
        avatarUrl: "https://example.com/avatar2.png",
        createdAt: "2025-02-01T00:00:00Z",
        updatedAt: "2025-02-02T00:00:00Z",
      ),
    ],
    createdAt: DateTime.parse("2025-01-01T00:00:00Z"),
    updatedAt: "2025-02-02T00:00:00Z",
  ),
  CharityByCategory(
    id: 3,
    uuid: "uuid-2",
    title: "Bantuan untuk Korban Bencana Alam",
    description:
        "Sedekah Jariyah 10.000 Quran ke seluruh negeri Sedekah Jariyah 10.000 Quran ke seluruh negeri Sedekah Jariyah 10.000 Quran ke seluruh negeri ",
    imageUrls: [
      "https://picsum.photos/id/237/400/600",
      "https://example.com/image2-2.png"
    ],
    category: Category(
        id: 2, name: "Bencana alam", categoryImage: "icons/icon_bencana.png"),
    progress: 50,
    totalCharities: 98234562,
    targetCharityDonation: 150000000.0,
    company: Company(
      id: 2,
      uuid: "company-uuid-2",
      companyName: "Yayasan Peduli Bencana",
      image: "https://example.com/company2.png",
    ),
    contributors: [
      Contributor(
        id: 2,
        uuid: "uuid-contributor-2",
        username: "andika",
        email: "andika@gmail.com",
        avatarUrl: "https://example.com/avatar2.png",
        createdAt: "2025-02-01T00:00:00Z",
        updatedAt: "2025-02-02T00:00:00Z",
      ),
    ],
    createdAt: DateTime.parse("2025-01-01T00:00:00Z"),
    updatedAt: "2025-02-02T00:00:00Z",
  ),
];
 final List<Category> categories = [
    Category(id: 2, name: 'Bencana Alam', categoryImage: 'icons/icon_bencana.png'),
    Category(id: 3, name: 'Balita & Anak Sakit', categoryImage: 'icons/bayi.png'),
    Category(id: 4, name: 'Bantuan Medis & Kesehatan', categoryImage: 'icons/icon_medis.png'),
    Category(id: 5, name: 'Bantuan Pendidikan', categoryImage: 'icons/tas.png'),
    Category(id: 6, name: 'Lingkungan', categoryImage: 'icons/icon_lingkungan.png'),
    Category(id: 7, name: 'Kegiatan Sosial', categoryImage: 'icons/icon_kegiatan.png'),
    Category(id: 8, name: 'Infrastruktur Umum', categoryImage: 'icons/infrastruktur.png'),
    Category(id: 9, name: 'Karya Kreatif & Modal Usaha', categoryImage: 'icons/karya_kreatif.png'),
    Category(id: 10, name: 'Menolong Hewan', categoryImage: 'icons/disable.png'),
    Category(id: 11, name: 'Rumah Ibadah', categoryImage: 'icons/icon_lainnya.png'),
    Category(id: 12, name: 'Difabel', categoryImage: 'icons/disable.png'),
    Category(id: 13, name: 'Zakat', categoryImage: 'icons/zakat.png'),
    Category(id: 14, name: 'Panti Asuhan dan Kaum Du\'afa', categoryImage: 'icons/panti_asuhan.png'),
    Category(id: 15, name: 'Kemanusiaan', categoryImage: 'icons/kemanusiaan.png'),
    Category(id: 16, name: 'Panti Jompo', categoryImage: 'icons/panti_jompo.png'),
  ];