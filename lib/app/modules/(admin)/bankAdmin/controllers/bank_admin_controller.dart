import 'package:dompet_mal/models/BankModel.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BankAdminController extends GetxController {
  final supabase = Supabase.instance.client;
  final bankList = <Bank>[].obs;
  final errorMessage = ''.obs;
  RxString username = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getCurrentUser();
    fetchBankList();
  }

  Future<void> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    username.value = prefs.getString('userName') ?? '';
  }

  void fetchBankList() async {
    try {
      final response = await supabase.from('banks').select();
      List<Bank> bankWithImages = [];
      for (var item in response) {
        final bank = Bank.fromJson(item);

        final fileResponse = await supabase
            .from('files')
            .select('file_name')
            .eq('module_class', 'banks')
            .eq('module_id', bank.id!)
            .limit(1)
            .maybeSingle();

        if (fileResponse != null) {
          bank.image = fileResponse['file_name'];
        }

        bankWithImages.add(bank);
      }
      bankList.value = bankWithImages;
    } catch (e) {
      errorMessage.value = 'Error fetching bank list: $e';
    }
  }

  void selectBankAccount(Bank account) {
    // Handle the bank account selection logic here
    print('Selected bank account: ${account.name}');
    Get.back(result: account);
  }

  void createBank(String name) async {
    try {
      final newBank = Bank(
        id: const Uuid().v4(),
        name: name,
        accountNumber: const Uuid().v4(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await supabase.from('banks').insert(newBank);
      bankList.add(newBank);
      errorMessage.value = '';
      Get.snackbar('Success', 'Bank created successfully');
    } catch (e) {
      errorMessage.value = 'Error creating bank: $e';
      print('Error creating bank: $e');
      Get.snackbar('Error', 'Failed to create bank');
    }
  }

  void updateBank(Bank bank, String name) async {
    try {
      await supabase.from('banks').update({
        'name': name,
        'updated_at': DateTime.now().toIso8601String()
      }).eq('id', bank.id ?? '');

      final index = bankList.indexWhere((b) => b.id == bank.id);
      if (index != -1) {
        bankList[index] = Bank(
          id: bank.id,
          name: name,
          accountNumber: bank.accountNumber,
          createdAt: bank.createdAt,
          updatedAt: DateTime.now(),
        );
      }

      Get.snackbar('Success', 'Bank updated successfully');
    } catch (e) {
      print('Error updating bank: $e');
      Get.snackbar('Error', 'Failed to update bank');
    }
  }

  void deleteBank(Bank bank) async {
    try {
      await supabase.from('banks').delete().eq('id', bank.id ?? '');
      bankList.removeWhere((b) => b.id == bank.id);
      errorMessage.value = '';
      Get.snackbar('Success', 'Bank deleted successfully');
    } catch (e) {
      errorMessage.value = 'Error deleting bank: $e';
      print('Error deleting bank: $e'); // Tambahkan log di sini
      Get.snackbar('Error', 'Failed to delete bank');
    }
  }
}
