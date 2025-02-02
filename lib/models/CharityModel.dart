// To parse this JSON data, do
//
//     final charity = charityFromJson(jsonString);

import 'dart:convert';

import 'package:dompet_mal/app/modules/(admin)/contributorAdmin/controllers/contributor_admin_controller.dart';

Charity charityFromJson(String str) => Charity.fromJson(json.decode(str));

String charityToJson(Charity data) => json.encode(data.toJson());

class Charity {
  String? id;
  String? categoryId;
  String? image;
  List<Contributor> contributors = [];
  String? companyId;
  String? title;
  String? description;
  String? companyImage;
  String? companyName;
  int? progress;
  int? total;
  int? targetTotal;
  String? targetDate;
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
    this.image,
    this.companyName,
    this.companyImage,
    this.targetDate,
    this.created_at,
    this.updated_at,
    this.status,
    this.contributors = const [],
  });

  factory Charity.fromJson(Map<String, dynamic> json) => Charity(
        id: json["id"],
        categoryId: json["category_id"],
        companyId: json["company_id"],
        title: json["title"],
        total: json["total"],
        description: json["description"],
        progress: json["progress"],
        targetDate: json["target_date"],
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
        "target_date": targetDate,
        "created_at":
            created_at?.toIso8601String() ?? DateTime.now().toIso8601String(),
        "updated_at": updated_at?.toIso8601String(),
        "status": status,
      };
}
