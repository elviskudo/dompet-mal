// To parse this JSON data, do
//
//     final payment = paymentFromJson(jsonString);

import 'dart:convert';

List<Payment> paymentFromJson(String str) => List<Payment>.from(json.decode(str).map((x) => Payment.fromJson(x)));

String paymentToJson(List<Payment> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Payment {
    String transactionId;
    int donationAmount;
    DateTime donationDate;

    Payment({
        required this.transactionId,
        required this.donationAmount,
        required this.donationDate,
    });

    factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        transactionId: json["transactionId"],
        donationAmount: json["donationAmount"],
        donationDate: DateTime.parse(json["donationDate"]),
    );

    Map<String, dynamic> toJson() => {
        "transactionId": transactionId,
        "donationAmount": donationAmount,
        "donationDate": "${donationDate.year.toString().padLeft(4, '0')}-${donationDate.month.toString().padLeft(2, '0')}-${donationDate.day.toString().padLeft(2, '0')}",
    };
}
