import 'package:dompet_mal/models/BankModel.dart';
import 'package:dompet_mal/models/CharityModel.dart';
import 'package:dompet_mal/models/TransactionModel.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:uuid/uuid.dart';

class TransactionsController extends GetxController {
  final SupabaseClient supabase = Supabase.instance.client;
  RxList transactions = <Transaction>[].obs;
  RxBool isLoading = false.obs;
  RxList banks = <Bank>[].obs;
  RxList charities = <Charity>[].obs;

  @override
  void onInit() {
    super.onInit();
    getTransactions();
  }

  // Get all transactions
  Future getTransactions() async {
    try {
      isLoading.value = true;
      final response = await supabase
          .from('transactions')
          .select()
          .order('created_at', ascending: false);

      transactions.value = 
        (response as List).map((item) => Transaction.fromJson(item)).toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch transactions: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future getBanks() async {
    try {
      final response = await supabase.from('banks').select('id, name');
      banks.value = response;
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch banks: $e');
    }
  }

  // Get all charities
  Future getCharities() async {
    try {
      final response = await supabase.from('charities').select('id, name');
      charities.value = response;
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
  Future updateTransaction(Transaction transaction) async {
    try {
      isLoading.value = true;
      await supabase
          .from('transactions')
          .update(transaction.toJson())
          .eq('id', transaction.id as Object);
      await getTransactions(); // Refresh the list
      Get.snackbar('Success', 'Transaction updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update transaction: $e');
    } finally {
      isLoading.value = false;
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