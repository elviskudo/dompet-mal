import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dompet_mal/app/modules/(home)/notification/controllers/notification_controller.dart';
import 'package:dompet_mal/models/notification.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TransactionCronJob {
  final supabase = Supabase.instance.client;
 

  Future<bool> isValidUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');

      if (userId == null || userId.isEmpty) {
        print('❌ Validation Failed: User ID is null or empty');
        return false;
      }

      // Validasi tambahan: cek apakah user exists di database
      final userResponse =
          await supabase.from('users').select('id').eq('id', userId).single();

      if (userResponse == null) {
        print('❌ Validation Failed: User not found in database');
        return false;
      }

      print('✅ User validation successful for ID: $userId');
      return true;
    } catch (e) {
      print('❌ Error validating user: $e');
      return false;
    }
  }

  Future<void> checkPendingTransactions() async {
    try {
      final isValid = await isValidUser();
      if (!isValid) {
        print('⛔ Skipping transaction check: Invalid user');
        return;
      }

      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');

      if (userId == null) {
        print('No user ID found in SharedPreferences');
        return;
      }

      final response = await supabase
          .from('transactions')
          .select(
              'id, transaction_number, donation_price, status, created_at, user_id, bank_id, charity_id')
          .inFilter('status', [1, 2]).eq('user_id', userId);

      print('Checking transactions for user $userId...');

      if (response != null && (response as List).isNotEmpty) {
        for (var transaction in response) {
          final status = transaction['status'];
          String notificationType;

          switch (status) {
            case 1:
              notificationType = 'pending_payment';
              break;
            case 2:
              notificationType = 'pending_verification';
              break;
            default:
              continue;
          }

          final uniqueNotificationId =
              '${transaction['id']}_${notificationType}_status_$status';

          // Enhanced notification validation
          final existingNotifications = await supabase
              .from('notifications')
              .select('id, is_deleted')
              .eq('unique_id', uniqueNotificationId);

          // Check if we have any existing notifications
          if (existingNotifications != null &&
              (existingNotifications as List).isNotEmpty) {
            bool shouldSkip = false;

            for (var notification in existingNotifications) {
              // For status 1, skip if any non-deleted notification exists
              if (status == 1 && notification['is_deleted'] == false) {
                shouldSkip = true;
                break;
              }
              // For status 2, skip if ANY notification exists (deleted or not)
              if (status == 2) {
                shouldSkip = true;
                break;
              }
            }

            if (shouldSkip) {
              print(
                  'Skipping notification for transaction ${transaction['id']} (Status: $status)');
              continue;
            }
          }

          final createdAt = DateTime.parse(transaction['created_at']);
          final now = DateTime.now();
          final elapsedMinutes = now.difference(createdAt).inMinutes;

          print('Elapsed minutes: $elapsedMinutes');
          print('now : $now');
          print('create_at : $createdAt');

          final positiveElapsedMinutes =
              elapsedMinutes > 0 ? elapsedMinutes : 0;

          if (elapsedMinutes >= -417) {
            if (existingNotifications == null ||
                (existingNotifications as List).isEmpty) {
              print('Transaction is eligible for notification. Sending...');

              // Fetch charity data
              final charityData = await supabase
                  .from('charities')
                  .select('id, title, category_id')
                  .eq('id', transaction['charity_id'])
                  .single();

              // Fetch bank data
              final bankData = await supabase
                  .from('banks')
                  .select('id, name, account_number')
                  .eq('id', transaction['bank_id'])
                  .single();

              final categori = await supabase
                  .from('categories')
                  .select('name')
                  .eq('id', charityData['category_id'])
                  .single();

              // Define notification content based on status
              String notificationTitle;
              String notificationBody;

              switch (status) {
                case 1:
                  notificationTitle = 'Pembayaran Tertunda!';
                  notificationBody =
                      'Transaksi untuk "${charityData['title']}" senilai Rp${transaction['donation_price'].toStringAsFixed(0)} masih tertunda. Segera selesaikan pembayaran Anda!';
                  break;
                case 2:
                  notificationTitle = 'Menunggu Verifikasi';
                  notificationBody =
                      'Pembayaran untuk "${charityData['title']}" senilai Rp${transaction['donation_price'].toStringAsFixed(0)} sedang dalam proses verifikasi.';
                  break;

                default:
                  continue;
              }

              // Insert notification to database
              await supabase.from('notifications').insert({
                'title': notificationTitle,
                'body': notificationBody,
                'user_id': transaction['user_id'],
                'unique_id': uniqueNotificationId,
              });

              // Send notification
              await sendNotification(
                transaction['id'],
                transaction['transaction_number'],
                charityData['title'] ?? 'Unknown Charity',
                (transaction['donation_price']),
                categori["name"] ?? '',
                charityData['id'] ?? '',
                bankData['id'] ?? '',
                bankData['name'] ?? '',
                bankData['account_number'] ?? '',
                null,
                transaction['user_id'] ?? '',
                status,
              );

              print('📢 Transaction Notification:');
              print('Status: $status');
              print('Transaction Number: ${transaction['transaction_number']}');
              print('Charity: ${charityData['title']}');
              print('Amount: ${transaction['donation_price']}');
              print('Transaction Created At: $createdAt');
              print('-------------------');
            } else {
              print(
                  'Skipping notification for transaction ${transaction['id']}');
            }
          }
        }
      }
    } catch (e) {
      print('Error checking transactions: $e');
    }
  }

  Future<void> _reloadNotifications() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');
      final response = await supabase
          .from('notifications')
          .select()
          .eq('user_id', userId!)
          .eq('is_deleted', false)
          .order('created_at', ascending: false);

      if (response != null) {
        final List<NotificationModels> loadedNotifications =
            (response as List<dynamic>)
                .map((json) => NotificationModels.fromJson(json))
                .toList();

        // Update di GetX controller
        if (Get.isRegistered<NotificationController>()) {
          final controller = Get.find<NotificationController>();
          controller.notifications.value = loadedNotifications;
        }
      }
    } catch (e) {
      print('Error reloading notifications: $e');
    }
  }

  Future<void> sendNotification(
    String transactionId,
    String transactionNumber,
    String charityTitle,
    int amount,
    String kategori,
    String charityId,
    String bankId,
    String bankAccount,
    String bankNumber,
    String? bankImage,
    String userId,
    int status,
  ) async {
    try {
      String title;
      String body;

      switch (status) {
        case 1:
          title = 'Pembayaran Tertunda!';
          body =
              'Transaksi #$transactionNumber untuk "$charityTitle" senilai Rp${amount.toStringAsFixed(0)} masih tertunda. Segera selesaikan pembayaran Anda!';
          break;
        case 2:
          title = 'Menunggu Verifikasi';
          body =
              'Pembayaran #$transactionNumber untuk "$charityTitle" senilai Rp${amount.toStringAsFixed(0)} sedang dalam proses verifikasi.';
          break;

        default:
          return;
      }

      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
          channelKey: 'transaction_service',
          title: title,
          body: body,
          payload: {
            'kategori': kategori,
            'charityId': charityId,
            'bankImage': bankImage,
            'transactionNumber': transactionNumber,
            'transactionId': transactionId,
            'bankId': bankId,
            'bankAccount': bankAccount,
            'userId': userId,
            'bankNumber': bankNumber,
            'amount': amount.toString(),
            'status': status.toString(),
          },
          notificationLayout: NotificationLayout.Default,
        ),
      );
      await _reloadNotifications();
      print('✅ Notifikasi berhasil dikirim dan data diperbarui');
    } catch (e) {
      print('Gagal mengirim notifikasi: $e');
    }
  }
}
