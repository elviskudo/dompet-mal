import 'package:dompet_mal/models/PaymentModel.dart';
import 'package:get/get.dart';

class ListPaymentController extends GetxController {
  // Ubah dummyPayments menjadi reactive
  final RxList<Payment> payments = <Payment>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Inisialisasi data dummy saat controller dimulai
    loadDummyPayments();
  }

  void loadDummyPayments() {
    payments.assignAll([
      Payment(
        transactionId: "202401-001-A",
        donationAmount: 500000,
        donationDate: DateTime.parse("2024-01-08"),
      ),
      Payment(
        transactionId: "202401-002-B",
        donationAmount: 750000,
        donationDate: DateTime.parse("2024-01-09"),
      ),
      Payment(
        transactionId: "202401-003-A",
        donationAmount: 1000000,
        donationDate: DateTime.parse("2024-01-10"),
      ),
    ]);

    // Mengurutkan payments berdasarkan tanggal (terlama ke terbaru)
    payments.sort((a, b) => a.donationDate.compareTo(b.donationDate));
  }

  // Fungsi untuk mendapatkan total donasi
  double getTotalDonations() {
    return payments.fold(0, (sum, payment) => sum + payment.donationAmount);
  }

  final count = 0.obs;
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
