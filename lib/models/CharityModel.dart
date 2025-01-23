// To parse this JSON data, do
//
//     final charity = charityFromJson(jsonString);

import 'dart:convert';

Charity charityFromJson(String str) => Charity.fromJson(json.decode(str));

String charityToJson(Charity data) => json.encode(data.toJson());

class Charity {
    String id;
    String categoryId;
    String companyId;
    String title;
    String description;
    int progress;
    int? total;
    int targetTotal;
    DateTime targetDate;
    DateTime created_at;
    DateTime updated_at;
    int status;

    Charity({
        required this.id,
        required this.categoryId,
        required this.companyId,
        required this.title,
        required this.description,
        required this.progress,
        this.total,
        required this.targetTotal,
        required this.targetDate,
        required this.created_at,
        required this.updated_at,
        required this.status,
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
        targetDate: DateTime.parse(json["target_date"]),
        created_at: DateTime.parse(json["created_at"]),
        updated_at: DateTime.parse(json["updated_at"]),
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
        "target_date": "${targetDate.year.toString().padLeft(4, '0')}-${targetDate.month.toString().padLeft(2, '0')}-${targetDate.day.toString().padLeft(2, '0')}",
        "created_at": created_at.toIso8601String(),
        "updated_at": updated_at.toIso8601String(),
        "status": status,
    };
}