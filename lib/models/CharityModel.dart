// To parse this JSON data, do
//
//     final charity = charityFromJson(jsonString);

import 'dart:convert';

Charity charityFromJson(String str) => Charity.fromJson(json.decode(str));

String charityToJson(Charity data) => json.encode(data.toJson());

class Charity {
  String? id;
  String? categoryId;
  String? companyId;
  String? title;
  String? description;
  int? progress;
  int? total;
  int? targetTotal;
  DateTime? targetDate;
  DateTime? created_at;
  DateTime? updated_at;
  int? status;

  Charity({
     this.id,
     this.categoryId,
     this.companyId,
     this.title,
     this.description,
     this.progress,
    this.total,
     this.targetTotal,
     this.targetDate,
     this.created_at,
     this.updated_at,
     this.status,
  });

  factory Charity.fromJson(Map<String, dynamic> json) => Charity(
        id: json["id"],
        categoryId: json["category_id"],
        companyId: json["company_id"],
        title: json["title"],
        description: json["description"],
        progress: json["progress"],
        total: json["total"],
        targetTotal: json["target_total"],
        targetDate: json["target_date"] == null
            ? null
            : DateTime.parse(json["target_date"]),
        created_at: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updated_at: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "company_id": companyId,
        "title": title,
        "description": description,
        "progress": progress,
        "total": total,
        "target_total": targetTotal,
        "target_date": targetDate?.toIso8601String(),
        "created_at":
            created_at?.toIso8601String() ?? DateTime.now().toIso8601String(),
        "updated_at": updated_at?.toIso8601String(),
        "status": status,
      };
}
