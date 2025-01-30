class Contributor {
  final int id;
  final String uuid;
  final String name;
  final String accountBank;
  final String accountName;
  final String accountNumber;
  final int amount;
  final String date;
  final String imageUrl;
  final String createdAt;
  final String updatedAt;

  Contributor({
    required this.id,
    required this.uuid,
    required this.name,
    required this.accountBank,
    required this.accountName,
    required this.accountNumber,
    required this.amount,
    required this.date,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });
}

final List<Contributor> contributors = [
  Contributor(
    id: 1,
    uuid: "23-234-234-01",
    name: "Shane",
    accountBank: "BANK BCA",
    accountName: "Shane Smith",
    accountNumber: "1234567890",
    amount: 10000,
    date: "2021-12-23",
    imageUrl: "assets/images/Ellipse 53.png",
    createdAt: "2021-12-23 10:00:00",
    updatedAt: "2021-12-23 10:00:00",
  ),
  Contributor(
    id: 2,
    uuid: "23-234-234-02",
    name: "Mitchell",
    accountBank: "BANK BCA",
    accountName: "Mitchell Smith",
    accountNumber: "1234567890",
    amount: 50000,
    date: "2021-12-23",
    imageUrl: "assets/images/Ellipse 54.png",
    createdAt: "2021-12-23 10:00:00",
    updatedAt: "2021-12-23 10:00:00",
  ),
  Contributor(
    id: 3,
    uuid: "23-234-234-03",
    name: "Colleen",
    accountBank: "BANK BCA",
    accountName: "Colleen Smith",
    accountNumber: "1234567890",
    amount: 10000,
    date: "2021-12-23",
    imageUrl: "assets/images/Ellipse 55.png",
    createdAt: "2021-12-23 10:00:00",
    updatedAt: "2021-12-23 10:00:00",
  ),
  Contributor(
    id: 4,
    uuid: "23-234-234-04",
    name: "Anonim",
    accountBank: "BANK BCA",
    accountName: "Anonim Smith",
    accountNumber: "1234567890",
    amount: 100000,
    date: "2021-12-23",
    imageUrl: "assets/images/Ellipse 56.png",
    createdAt: "2021-12-23 10:00:00",
    updatedAt: "2021-12-23 10:00:00",
  ),
  Contributor(
    id: 5,
    uuid: "23-234-234-05",
    name: "Max",
    accountBank: "BANK BCA",
    accountName: "Max Smith",
    accountNumber: "1234567890",
    amount: 10000,
    date: "2021-12-23",
    imageUrl: "assets/images/Ellipse 54.png",
    createdAt: "2021-12-23 10:00:00",
    updatedAt: "2021-12-23 10:00:00",
  ),
  Contributor(
    id: 6,
    uuid: "23-234-234-06",
    name: "Angel",
    accountBank: "BANK BCA",
    accountName: "Angel Smith",
    accountNumber: "1234567890",
    amount: 10000,
    date: "2021-12-23",
    imageUrl: "assets/images/Ellipse 55.png",
    createdAt: "2021-12-23 10:00:00",
    updatedAt: "2021-12-23 10:00:00",
  ),
];
