class CharityByCategory {
  final int id;
  final String uuid;
  final String title;
  final List<String> imageUrls; // Perubahan di sini
  final Category category;
  final int progress;
  final int totalCharities;
  final double targetCharityDonation; // Perubahan di sini
  final Company company; // Perubahan di sini
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

  Category({
    required this.id,
    required this.name,
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
      "https://example.com/image1.png",
      "https://example.com/image1-2.png"
    ],
    category: Category(id: 1, name: "Kegiatan Sosial"),
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
    category: Category(id: 2, name: "Bantuan Kemanusiaan"),
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
      "https://example.com/image2.png",
      "https://example.com/image2-2.png"
    ],
    category: Category(id: 2, name: "Bantuan Kemanusiaan"),
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
