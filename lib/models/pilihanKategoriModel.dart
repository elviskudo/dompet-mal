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
        "Sedekah Jariyah 10.000 Quran ke seluruh negeri Sedekah Jariyah 10.000 Quran ke seluruh negeri Sedekah Jariyah 10.000 Quran ke seluruh negeriSedekah Jariyah 10.000 Quran ke seluruh negeri Sedekah Jariyah 10.000 Quran ke seluruh negeri Sedekah Jariyah 10.000 Quran ke seluruh negeriSedekah Jariyah 10.000 Quran ke seluruh negeri Sedekah Jariyah 10.000 Quran ke seluruh negeri Sedekah Jariyah 10.000 Quran ke seluruh negeriSedekah Jariyah 10.000 Quran ke seluruh negeri Sedekah Jariyah 10.000 Quran ke seluruh negeri Sedekah Jariyah 10.000 Quran ke seluruh negeriSedekah Jariyah 10.000 Quran ke seluruh negeri Sedekah Jariyah 10.000 Quran ke seluruh negeri Sedekah Jariyah 10.000 Quran ke seluruh negeriSedekah Jariyah 10.000 Quran ke seluruh negeri Sedekah Jariyah 10.000 Quran ke seluruh negeri Sedekah Jariyah 10.000 Quran ke seluruh negeriSedekah Jariyah 10.000 Quran ke seluruh negeri Sedekah Jariyah 10.000 Quran ke seluruh negeri Sedekah Jariyah 10.000 Quran ke seluruh negeriSedekah Jariyah 10.000 Quran ke seluruh negeri Sedekah Jariyah 10.000 Quran ke seluruh negeri Sedekah Jariyah 10.000 Quran ke seluruh negeriSedekah Jariyah 10.000 Quran ke seluruh negeri Sedekah Jariyah 10.000 Quran ke seluruh negeri Sedekah Jariyah 10.000 Quran ke seluruh negeriSedekah Jariyah 10.000 Quran ke seluruh negeri Sedekah Jariyah 10.000 Quran ke seluruh negeri Sedekah Jariyah 10.000 Quran ke seluruh negeri ",
    imageUrls: [
      "https://picsum.photos/id/235/400/600",
      "https://picsum.photos/id/235/400/600",
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
      "https://picsum.photos/id/23/400/600",
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
      "https://picsum.photos/id/5/400/600",
      "https://picsum.photos/id/235/400/600",
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
      "https://picsum.photos/id/235/400/600",
      "https://picsum.photos/id/235/400/600",
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
  CharityByCategory(
    id: 4,
    uuid: "uuid-1",
    title: "Operasional Server dan Maintenance, CV optimis",
    description: '''
1. Biaya Infrastruktur dan Hosting
- Server dan Cloud Hosting: Biaya untuk menyewa server untuk menyimpan data aplikasi dan menjalankan backend.
- Content Delivery Network (CDN): Layanan yang digunakan untuk mendistribusikan konten aplikasi (seperti gambar, video, file) ke berbagai lokasi pengguna secara efisien.
- Database Hosting: Biaya untuk penyimpanan dan manajemen database.

2. Biaya Pengembangan dan Pemeliharaan
- Gaji Pengembang (Developer): Pembayaran untuk pengembang aplikasi yang bekerja untuk membangun, menguji, dan memperbarui aplikasi.
- Desainer UI/UX: Biaya untuk desainer yang menciptakan antarmuka pengguna yang intuitif dan pengalaman pengguna yang baik.
- QA dan Pengujian: Biaya untuk tim pengujian (Quality Assurance) yang memastikan aplikasi bebas dari bug dan berfungsi dengan baik di berbagai perangkat.
- Pembaharuan dan Peningkatan Fitur: Biaya untuk menambahkan fitur baru dan memperbarui aplikasi agar tetap relevan dan sesuai dengan kebutuhan pasar.

3. Biaya Keamanan dan Perlindungan Data
- Keamanan Data: Pengeluaran untuk melindungi data pengguna, termasuk penggunaan enkripsi, firewall, dan perlindungan terhadap potensi serangan siber.
- Audit Keamanan: Biaya untuk melakukan audit keamanan secara berkala guna memastikan aplikasi tetap aman dan sesuai dengan peraturan yang berlaku, seperti GDPR atau CCPA.
- Penyimpanan Cadangan (Backup): Biaya untuk menjaga cadangan data aplikasi agar dapat dipulihkan jika terjadi kehilangan data atau kerusakan.

4. Biaya Lisensi dan Perangkat Lunak
- Lisensi Perangkat Lunak: Biaya untuk menggunakan perangkat lunak atau alat pihak ketiga yang dibutuhkan oleh aplikasi.
- Perangkat Lunak Pengembangan: Lisensi untuk alat pengembangan seperti IDE (Integrated Development Environment), alat kolaborasi, alat desain grafis, dll.

5. Biaya Pemasaran dan Akuisisi Pengguna (dalam progres)
- Iklan Digital: Pengeluaran untuk kampanye iklan di platform seperti Google Ads, Facebook Ads, Instagram, atau iklan di platform lainnya untuk menarik pengguna baru.
- SEO (Search Engine Optimization): Biaya untuk mengoptimalkan aplikasi agar lebih mudah ditemukan melalui pencarian di mesin pencari (misalnya, Google).
- Pemasaran Afiliasi: Biaya untuk menggandeng mitra atau afiliasi yang mempromosikan aplikasi dengan imbalan komisi.
- Konten dan Media Sosial: Biaya untuk membuat dan mengelola konten pemasaran di berbagai platform sosial media.

6. Biaya Pembayaran dan Transaksi
- Biaya Platform Pembayaran: Jika aplikasi melibatkan transaksi, biaya platform pembayaran Xendit untuk memproses pembayaran pengguna.

7. Biaya Pengelolaan dan Administrasi
- Gaji Manajer Proyek: Pembayaran untuk manajer proyek atau tim operasional yang mengelola pengembangan aplikasi dan operasional sehari-hari.
- Biaya Administrasi: Pengeluaran untuk perizinan, pengurusan pajak, biaya hukum, dan berbagai keperluan administratif.
- Support Pelanggan: Biaya untuk menyediakan dukungan pelanggan, dan biaya lainnya terkait dengan layanan pelanggan.

8. Biaya Pengujian dan Penelitian
- Uji Coba A/B: Biaya untuk pengujian fitur baru, UI/UX, dan eksperimen lainnya untuk meningkatkan pengalaman pengguna dan konversi.
- Analitik dan Pelaporan: Pengeluaran untuk menggunakan alat analitik (misalnya, Google Analytics, Mixpanel) untuk memonitor penggunaan aplikasi dan menilai kinerja aplikasi.

9. Biaya untuk Sertifikasi dan Kepatuhan
- Kepatuhan Regulasi: Biaya yang terkait dengan memastikan aplikasi mematuhi undang-undang dan peraturan terkait, atau aturan perlindungan data lainnya.
- Sertifikasi: Biaya untuk memperoleh sertifikasi yang diperlukan, seperti sertifikat keamanan atau sertifikasi lainnya yang dapat meningkatkan kredibilitas aplikasi.
''',
    imageUrls: [
      "https://picsum.photos/id/235/400/600",
      "https://picsum.photos/id/235/400/600",
      "https://example.com/image2-2.png"
    ],
    category: Category(
      id: 17,
      name: 'Dana Operasional',
      categoryImage: 'assets/images/Group 323.png',
    ),
    progress: 50,
    totalCharities: 98234562,
    targetCharityDonation: 150000000.0,
    company: Company(
      id: 3,
      uuid: "company-uuid-2",
      companyName: "Dusun Web",
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
  )
];
final List<Category> categories = [
  Category(
      id: 2,
      name: 'Bencana Alam',
      categoryImage: 'assets/icons/icon_bencana.png'),
  Category(id: 3, name: 'Balita & Anak Sakit', categoryImage: 'icons/bayi.png'),
  Category(
      id: 4,
      name: 'Bantuan Medis & Kesehatan',
      categoryImage: 'icons/icon_medis.png'),
  Category(id: 5, name: 'Bantuan Pendidikan', categoryImage: 'icons/tas.png'),
  Category(
      id: 6, name: 'Lingkungan', categoryImage: 'icons/icon_lingkungan.png'),
  Category(
      id: 7, name: 'Kegiatan Sosial', categoryImage: 'icons/icon_kegiatan.png'),
  Category(
      id: 8,
      name: 'Infrastruktur Umum',
      categoryImage: 'icons/infrastruktur.png'),
  Category(
      id: 9,
      name: 'Karya Kreatif & Modal Usaha',
      categoryImage: 'icons/karya_kreatif.png'),
  Category(id: 10, name: 'Menolong Hewan', categoryImage: 'icons/disable.png'),
  Category(
      id: 11, name: 'Rumah Ibadah', categoryImage: 'icons/icon_lainnya.png'),
  Category(id: 12, name: 'Difabel', categoryImage: 'icons/disable.png'),
  Category(id: 13, name: 'Zakat', categoryImage: 'icons/zakat.png'),
  Category(
      id: 14,
      name: 'Panti Asuhan dan Kaum Du\'afa',
      categoryImage: 'icons/panti_asuhan.png'),
  Category(id: 15, name: 'Kemanusiaan', categoryImage: 'icons/kemanusiaan.png'),
  Category(id: 16, name: 'Panti Jompo', categoryImage: 'icons/panti_jompo.png'),
  Category(
      id: 17,
      name: 'Dana Operasional',
      categoryImage: 'assets/images/Group 323.png'),
];
