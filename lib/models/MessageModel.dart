// To parse this JSON data, do
//
//     final message = messageFromJson(jsonString);

import 'dart:convert';

List<Message> messageFromJson(String str) => List<Message>.from(json.decode(str).map((x) => Message.fromJson(x)));

String messageToJson(List<Message> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Message {
    String username;
    String avatar;
    String body;
    String createdAt;

    Message({
        required this.username,
        required this.avatar,
        required this.body,
        required this.createdAt,
    });

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        username: json["username"],
        avatar: json["avatar"],
        body: json["body"],
        createdAt: json["created_at"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "avatar": avatar,
        "body": body,
        "created_at": createdAt,
    };
}
