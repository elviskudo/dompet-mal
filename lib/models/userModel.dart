class Users {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String role;
  final String? accessToken; // Bisa null
  final DateTime createdAt;
  final DateTime updatedAt;

  Users({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.phoneNumber,
    this.accessToken, // Tidak wajib
    required this.createdAt,
    required this.updatedAt,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['id'] as String? ?? '', // Mengatasi null dengan string kosong
      name: json['name'] as String? ?? '', // Mengatasi null dengan string kosong
      email: json['email'] as String? ?? '', // Mengatasi null dengan string kosong
      role: json['role'] as String? ?? '', // Mengatasi null dengan string kosong
      phoneNumber: json['phone_number'] as String? ?? '', // Mengatasi null dengan string kosong
      accessToken: json['access_token'] != null && json['access_token'] != '' 
          ? json['access_token'] as String? 
          : null, // Mengatasi null atau string kosong
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at'] as String) 
          : DateTime.now(), // Mengatasi null dengan tanggal saat ini
      updatedAt: json['updated_at'] != null 
          ? DateTime.parse(json['updated_at'] as String) 
          : DateTime.now(), // Mengatasi null dengan tanggal saat ini
    );
  }
}
