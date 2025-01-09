class BankAccount {
  final int id;
  final String uuid;
  final String name;
  final String accountName;
  final String accountNumber;
  final int status;
  final String createdAt;
  final String updatedAt;

  BankAccount({
    required this.id,
    required this.uuid,
    required this.name,
    required this.accountName,
    required this.accountNumber,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });
}
