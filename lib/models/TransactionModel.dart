import 'package:uuid/uuid.dart';

class Transaction {
  final String? id;
  final String? bankId;
  final String? charityId;
  final String? userId;
  final String? transactionNumber;
  final int? status;
  final double? donationPrice;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Transaction({
    this.id,
    this.bankId,
    this.charityId,
    this.status,
    this.userId,
    this.transactionNumber,
    this.donationPrice,
    this.createdAt,
    this.updatedAt,
  });

  // Factory method to create a Transaction object from JSON
  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json['id'],
        bankId: json['bank_id'],
        charityId: json['charity_id'],
        userId: json['user_id'],
        status: json['status'],
        transactionNumber: json['transaction_number'],
        donationPrice: json['donation_price']?.toDouble(),
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : null,
        updatedAt: json['updated_at'] != null
            ? DateTime.parse(json['updated_at'])
            : null,
      );

  // Convert a Transaction object to JSON
  Map<String, dynamic> toJson() => {
        'id': id ?? const Uuid().v4(),
        'bank_id': bankId,
        'charity_id': charityId,
        'user_id': userId,
        'status': status ?? 0,
        'transaction_number': transactionNumber,
        'donation_price': donationPrice,
        "created_at":
            createdAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };

  // Add the copyWith method
  Transaction copyWith({
    String? id,
    String? bankId,
    String? charityId,
    String? userId,
    int? status,
    String? transactionNumber,
    double? donationPrice,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Transaction(
      id: id ?? this.id,
      bankId: bankId ?? this.bankId,
      charityId: charityId ?? this.charityId,
      status: status ?? this.status,
      userId: userId ?? this.userId,
      transactionNumber: transactionNumber ?? this.transactionNumber,
      donationPrice: donationPrice ?? this.donationPrice,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
