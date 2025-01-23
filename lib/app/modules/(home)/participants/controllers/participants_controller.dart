import 'package:get/get.dart';
import 'package:dompet_mal/models/participantsModel.dart';

class ParticipantsController extends GetxController {
  final participants = <Contributor>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchParticipants();
  }

  void fetchParticipants() {
    participants.assignAll([
      Contributor(
        id: 1,
        uuid: "23-234-234-01",
        name: "Shane",
        accountBank: "BANK BCA",
        accountName: "Shane Smith",
        accountNumber: "1234567890",
        amount: 10000,
        date: "2021-12-23",
        imageUrl: "images/Ellipse 53.png",
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
        imageUrl: "images/Ellipse 54.png",
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
        imageUrl: "images/Ellipse 55.png",
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
        imageUrl: "images/Ellipse 56.png",
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
        imageUrl: "images/Ellipse 54.png",
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
        imageUrl: "images/Ellipse 55.png",
        createdAt: "2021-12-23 10:00:00",
        updatedAt: "2021-12-23 10:00:00",
      ),
    ]);
  }
}
