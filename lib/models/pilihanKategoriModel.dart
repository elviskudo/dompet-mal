class CharityByCategory {
  final int id;
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
    title: "",
    description: "",
    imageUrls: [
      "https://picsum.photos/id/237/400/600",
      "https://picsum.photos/id/237/400/600"
          "https://example.com/image1-2.png"
    ],
    category: Category(
        id: 7,
        name: "Kegiatan Sosial",
        categoryImage: "assets/icons/icon_kegiatan.png"),
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
];
final List<Category> categories = [
  Category(
      id: 2,
      name: 'Bencana Alam',
      categoryImage: 'assets/icons/icon_bencana.png'),
];
