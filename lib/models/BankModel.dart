import 'dart:convert';

import 'package:uuid/uuid.dart';

Bank bankFromJson(String str) => Bank.fromJson(json.decode(str));

String bankToJson(Bank data) => json.encode(data.toJson());

class Bank {
  String? id;
  String name;
  String accountNumber;
  DateTime createdAt;
  DateTime updatedAt;

  Bank({
    this.id,
    required this.name,
    required this.accountNumber,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
        id: json["id"],
        name: json["name"],
        accountNumber: json["account_number"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? const Uuid().v4(),
        "name": name,
        "account_number": accountNumber,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
