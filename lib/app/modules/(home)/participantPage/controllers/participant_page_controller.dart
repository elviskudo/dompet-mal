import 'package:dompet_mal/app/modules/(admin)/contributorAdmin/controllers/contributor_admin_controller.dart';
import 'package:dompet_mal/models/TransactionModel.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ParticipantPageController extends GetxController {
  final supabase = Supabase.instance.client;
  var transactions = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;

  Future<void> fetchTransactions(String charityId) async {
    try {
      isLoading.value = true;

      // Fetch transactions for the charity
      final transactionsResponse = await supabase
          .from('transactions')
          .select(
              'id, bank_id, charity_id, user_id, transaction_number, status, donation_price, created_at, updated_at')
          .eq('charity_id', charityId)
          .eq('status', 3)
          .order('created_at', ascending: false);

      // Map untuk menyimpan transaksi yang digroup
      final Map<String, Map<String, dynamic>> groupedTransactions = {};

      for (final transData in transactionsResponse) {
        final key = '${transData['user_id']}-${transData['charity_id']}';

        if (groupedTransactions.containsKey(key)) {
          // Jika key sudah ada, tambahkan donation_price ke total
          groupedTransactions[key]!['donation_price'] +=
              transData['donation_price'] ?? 0;
        } else {
          // Jika key belum ada, tambahkan transaksi baru
          groupedTransactions[key] = Map<String, dynamic>.from(transData);
        }
      }

      // Ambil data user untuk setiap transaksi yang digroup
      final transactionsList = [];
      for (final groupedTrans in groupedTransactions.values) {
        final userId = groupedTrans['user_id'];

        // Fetch user data
        final userResponse = await supabase
            .from('users')
            .select('id, name')
            .eq('id', userId)
            .single();

        final fileResponse = await supabase
            .from('files')
            .select('file_name')
            .eq('module_class', 'users')
            .eq('module_id', userId)
            .single();

        final imageUrl = fileResponse['file_name'] ?? '';

        transactionsList.add({
          'transaction': Transaction.fromJson(groupedTrans),
          'user': {
            'name': userResponse['name'] ?? 'Anonymous',
            'image_url': imageUrl
          },
        });
      }

      // Set hasil ke transaksi
      transactions.value = List<Map<String, dynamic>>.from(transactionsList);
    } catch (e) {
      print('Error fetching transactions: $e');
      Get.snackbar('Error', 'Failed to fetch transactions data');
    } finally {
      isLoading.value = false;
    }
  }
}
