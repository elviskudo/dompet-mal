class Users {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String role;
  final String accessToken;
  final DateTime createdAt;
  final DateTime updatedAt;

  Users({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.phoneNumber,
    required this.accessToken,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      phoneNumber: json['phone_number'] as String,
      accessToken: json['access_token'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }
}
