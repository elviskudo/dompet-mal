class CharityByCategory {
  final int id;
  final String uuid;
  final String title;
  final String imageUrl;
  final Category category;
  final int progress;
  final int totalCharities;
  final List<Contributor> contributors;
  final DateTime createdAt;
  final String updatedAt;

  CharityByCategory({
    required this.id,
    required this.uuid,
    required this.title,
    required this.imageUrl,
    required this.category,
    required this.progress,
    required this.totalCharities,
    required this.contributors,
    required this.createdAt,
    required this.updatedAt,
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
      imageUrl: "https://example.com/image1.png",
      category: Category(
        id: 1,
        name: "Kegiatan Sosial",
      ),
      progress: 20,
      totalCharities: 151472721,
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
        Contributor(
          id: 2,
          uuid: "uuid-contributor-1",
          username: "faiz2",
          email: "faiz2@gmail.com",
          avatarUrl: "https://example.com/avatar1.png",
          createdAt: "2025-01-01T00:00:00Z",
          updatedAt: "2025-01-02T00:00:00Z",
        ),
        Contributor(
          id: 3,
          uuid: "uuid-contributor-1",
          username: "faiz3",
          email: "faiz3@gmail.com",
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
      imageUrl: "https://example.com/image2.png",
      category: Category(
        id: 2,
        name: "Bantuan Kemanusiaan",
      ),
      progress: 50,
      totalCharities: 98234562,
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
      createdAt:  DateTime.parse("2025-01-01T00:00:00Z"),
      updatedAt: "2025-02-02T00:00:00Z",
    ),
    CharityByCategory(
      id: 3,
      uuid: "uuid-3",
      title: "Pembangunan Masjid di Daerah Terpencil",
      imageUrl: "https://example.com/image3.png",
      category: Category(
        id: 3,
        name: "Keagamaan",
      ),
      progress: 70,
      totalCharities: 76432312,
      contributors: [
        Contributor(
          id: 3,
          uuid: "uuid-contributor-3",
          username: "siti",
          email: "siti@gmail.com",
          avatarUrl: "https://example.com/avatar3.png",
          createdAt: "2025-03-01T00:00:00Z",
          updatedAt: "2025-03-02T00:00:00Z",
        ),
      ],
      createdAt:  DateTime.parse("2025-01-01T00:00:00Z"),
      updatedAt: "2025-03-02T00:00:00Z",
    ),
    CharityByCategory(
      id: 4,
      uuid: "uuid-4",
      title: "Beasiswa untuk Anak Yatim dan Dhuafa",
      imageUrl: "https://example.com/image4.png",
      category: Category(
        id: 4,
        name: "Pendidikan",
      ),
      progress: 85,
      totalCharities: 132455623,
      contributors: [
        Contributor(
          id: 4,
          uuid: "uuid-contributor-4",
          username: "agus",
          email: "agus@gmail.com",
          avatarUrl: "https://example.com/avatar4.png",
          createdAt: "2025-04-01T00:00:00Z",
          updatedAt: "2025-04-02T00:00:00Z",
        ),
      ],
      createdAt:  DateTime.parse("2025-01-01T00:00:00Z"),
      updatedAt: "2025-04-02T00:00:00Z",
    ),
  ];