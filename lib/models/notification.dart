import 'package:uuid/uuid.dart';

class NotificationModels {
  String? id;
  String? title;
  String? body;
  String? userId;
  String? uniqueId;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool isDeleted;  // New field

  NotificationModels({
    this.id,
    this.title,
    this.body,
    this.userId,
    this.uniqueId,
    this.createdAt,
    this.updatedAt,
    this.isDeleted = false,  // Default to false
  });

  factory NotificationModels.fromJson(Map json) => NotificationModels(
        id: json["id"],
        title: json["title"],
        body: json["body"],
        userId: json["user_id"],
        uniqueId: json["unique_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        isDeleted: json["is_deleted"] ?? false,
      );

  Map toJson() => {
        "id": id ?? const Uuid().v4(),
        "title": title,
        "body": body,
        "user_id": userId,
        "unique_id": uniqueId,
        "created_at":
            createdAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "is_deleted": isDeleted,
      };
}