// To parse this JSON data, do
//
//     final notification = notificationFromJson(jsonString);

import 'dart:convert';

List<Notification> notificationFromJson(String str) => List<Notification>.from(json.decode(str).map((x) => Notification.fromJson(x)));

String notificationToJson(List<Notification> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Notification {
    String title;
    String userAvatar;
    DateTime createdAt;
    int amount;

    Notification({
        required this.title,
        required this.userAvatar,
        required this.createdAt,
        required this.amount,
    });

    factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        title: json["title"],
        userAvatar: json["userAvatar"],
        createdAt: DateTime.parse(json["created_at"]),
        amount: json["amount"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "userAvatar": userAvatar,
        "created_at": "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
        "amount": amount,
    };
}
