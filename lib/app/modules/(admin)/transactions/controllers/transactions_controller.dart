import 'package:dompet_mal/models/BankModel.dart';
import 'package:dompet_mal/models/CharityModel.dart';
import 'package:dompet_mal/models/TransactionModel.dart';
import 'package:dompet_mal/models/userModel.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
// import 'package:uuid/uuid.dart';

class TransactionsController extends GetxController {
  final SupabaseClient supabase = Supabase.instance.client;
  RxList transactions = <Transaction>[].obs;
  RxBool isLoading = false.obs;
  RxList banks = <Bank>[].obs;
  RxList charities = <Charity>[].obs;
  RxList users = <Users>[].obs;
  RxString userId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getTransactions();
    getBanks();
    getCharities();
    getUsers();
    getCurrentUser();
  }

  Future<void> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    userId.value = prefs.getString('userId') ?? '';
  }

  Future getUsers() async {
    try {
      final response = await supabase.from('users').select('id, name');
      print('Users response: $response');
      users.value = (response as List)
          .map((item) => Users(
              id: item['id'],
              name: item['name'],
              email: '',
              role: '',
              phoneNumber: '',
              createdAt: DateTime.now(),
              updatedAt: DateTime.now()))
          .toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch users: $e');
    }
  }

  // Get all transactions
  Future getTransactions() async {
    try {
      isLoading.value = true;
      final response = await supabase
          .from('transactions')
          .select(
              'id, bank_id, charity_id, user_id, transaction_number, status, donation_price, created_at, updated_at')
          .order('created_at', ascending: false);

      // Map untuk menyimpan transaksi yang digroup
      final Map<String, Map<String, dynamic>> groupedTransactions = {};

      for (final item in response) {
        final key = '${item['user_id']}-${item['charity_id']}';

        if (groupedTransactions.containsKey(key)) {
          // Jika key sudah ada, tambahkan donation_price ke total
          groupedTransactions[key]!['donation_price'] +=
              item['donation_price'] ?? 0;
        } else {
          // Jika key belum ada, tambahkan transaksi baru
          groupedTransactions[key] = Map<String, dynamic>.from(item);
        }
      }

      // Konversi hasil group menjadi daftar transaksi
      transactions.value = groupedTransactions.values
          .map((item) => Transaction.fromJson(item))
          .toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch transactions: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future getBanks() async {
    try {
      final response = await supabase.from('banks').select('id, name');
      print('Banks response: $response'); // Tambahkan ini
      banks.value = (response as List)
          .map((item) => Bank(id: item['id'], name: item['name']))
          .toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch banks: $e');
    }
  }

  // Get all charities
  Future getCharities() async {
    try {
      final response = await supabase.from('charities').select('id, title');
      print('charities response: $response');
      charities.value = (response as List)
          .map((item) => Charity(id: item['id'], title: item['title']))
          .toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch charities: $e');
    }
  }

  // Add new transaction
  Future addTransaction(Transaction transaction) async {
    try {
      isLoading.value = true;

      await supabase.from('transactions').insert(transaction.toJson());
      await getTransactions(); // Refresh the list
      Get.snackbar('Success', 'Transaction added successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to add transaction: $e');
      print('Error Failed to add transaction: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Update transaction
  Future updateTransaction(Transaction transaction, String id) async {
    try {
      await supabase
          .from('transactions')
          .update(transaction.toJson())
          .eq('id', id);

      await getTransactions(); // Refresh the list
      Get.snackbar('Success', 'Transaction updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update transaction: $e');
      print('Detailed error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<Bank?> getBankById(String bankId) async {
    try {
      // Get bank data
      final bankResponse =
          await supabase.from('banks').select('*').eq('id', bankId).single();

      if (bankResponse != null) {
        // Get bank image from files table
        final fileResponse = await supabase
            .from('files')
            .select('file_name')
            .eq('module_class',
                'banks') // Menggunakan 'banks' sebagai module_class
            .eq('module_id', bankId) // Menggunakan bankId sebagai module_id
            .maybeSingle();

        // Create bank object
        final bank = Bank.fromJson(bankResponse);

        // Set image URL if file exists
        if (fileResponse != null) {
          bank.image = fileResponse['file_name'];
        }

        return bank;
      }
      return null;
    } catch (e) {
      print('Error fetching bank details: $e');
      return null;
    }
  }

  // Delete transaction
  Future deleteTransaction(String id) async {
    try {
      isLoading.value = true;
      await supabase.from('transactions').delete().eq('id', id);
      await getTransactions(); // Refresh the list
      Get.snackbar('Success', 'Transaction deleted successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete transaction: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
