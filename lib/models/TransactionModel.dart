import 'package:uuid/uuid.dart';

class Transaction {
 final String? id;
 final String? bankId;
 final String? charityId;
 final String? userId;
 final String? transactionNumber;
 final double? donationPrice;
 final DateTime? createdAt;
 final DateTime? updatedAt;

 Transaction({
   this.id,
   this.bankId,
   this.charityId,
   this.userId,
   this.transactionNumber,
   this.donationPrice,
   this.createdAt,
   this.updatedAt,
 });

 factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
   id: json['id'],
   bankId: json['bank_id'],
   charityId: json['charity_id'], 
   userId: json['user_id'],
   transactionNumber: json['transaction_number'],
   donationPrice: json['donation_price']?.toDouble(),
   createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
   updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
 );

 Map<String, dynamic> toJson() => {
   'id': id ?? const Uuid().v4(),
   'bank_id': bankId,
   'charity_id': charityId,
   'user_id': userId,
   'transaction_number': transactionNumber,
   'donation_price': donationPrice,
   'created_at': createdAt?.toIso8601String(),
   'updated_at': updatedAt?.toIso8601String(),
 };
}