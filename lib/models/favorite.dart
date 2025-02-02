import 'package:uuid/uuid.dart';

class Favorite {
  String? id;
  String? charityId;
  String? userId;
  bool? isFavorite;
  DateTime? createdAt;
  DateTime? updatedAt;

  Favorite({
    this.id,
    this.charityId,
    this.userId,
    this.isFavorite,
    this.createdAt,
    this.updatedAt,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
        id: json["id"],
        charityId: json["charity_id"],
        userId: json["user_id"],
        isFavorite: json["is_favorite"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? const Uuid().v4(),
        "charity_id": charityId,
        "user_id": userId,
        "is_favorite": isFavorite ?? true,
        "created_at":
            createdAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
        "updated_at":
            updatedAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
      };
}
