import 'package:dompet_mal/app/modules/(admin)/contributorAdmin/controllers/contributor_admin_controller.dart';
import 'package:dompet_mal/models/TransactionModel.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ParticipantPageController extends GetxController {
  final supabase = Supabase.instance.client;
  var contributorsWithTransactions = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;

  Future<void> fetchContributorsAndTransactions(String charityId) async {
    try {
      isLoading.value = true;

      // First, fetch contributors for this charity
      final contributorsResponse =
          await supabase.from('contributors').select('''
          *,
          users:user_id (*)
        ''').eq('charity_id', charityId);

      // Modified transactions query to explicitly select all fields
      final transactionsResponse =
          await supabase.from('transactions').select('''
          id,
          bank_id,
          charity_id,
          user_id,
          status,
          transaction_number,
          donation_price,
          created_at,
          updated_at
        ''').eq('charity_id', charityId).eq('status', 1);

      print('Raw transactions response: $transactionsResponse'); // Debug print

      // Convert responses to proper models
      final List<Map<String, dynamic>> contributorsData = [];

      for (var contributorData in contributorsResponse) {
        final contributor = Contributor.fromJson(contributorData);

        // Find all transactions for this user in this charity
        final userTransactions = transactionsResponse
            .where((trans) => trans['user_id'] == contributor.userId)
            .map((trans) {
          print('Processing transaction: $trans'); // Debug print
          return Transaction.fromJson(trans);
        }).toList();

        // Calculate total donation from transactions
        final totalDonation = userTransactions.fold<double>(
          0,
          (sum, trans) {
            final donationAmount = trans.donationPrice ?? 0;
            print('Adding donation: $donationAmount'); // Debug print
            return sum + donationAmount;
          },
        );

        contributorsData.add({
          'contributor': contributor,
          'transactions': userTransactions,
          'totalDonation': totalDonation,
          'lastTransaction':
              userTransactions.isNotEmpty ? userTransactions.first : null,
        });
      }

      contributorsWithTransactions.value = contributorsData;
    } catch (e) {
      print('Error fetching data: $e');
      Get.snackbar('Error', 'Failed to fetch participants data');
    } finally {
      isLoading.value = false;
    }
  }
}
