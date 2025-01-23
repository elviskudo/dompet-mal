import 'package:uuid/uuid.dart';

class Companies {
  final String? id;
  final String? name;
  final String? email;
  final String? phoneNumber;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Companies({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.createdAt,
    this.updatedAt,
  });

  // Factory method untuk membuat instance dari JSON
  factory Companies.fromJson(Map<String, dynamic> json) => Companies(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        phoneNumber: json['phone_number'],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  // Method untuk mengubah instance menjadi JSON
  Map<String, dynamic> toJson() => {
        "id": id ?? const Uuid().v4(),
        'name': name,
        'email': email,
        'phone_number': phoneNumber,
        "created_at":
            createdAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
