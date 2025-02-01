import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dompet_mal/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class CharityCronJob {
  final supabase = Supabase.instance.client;

  Future<void> checkCharityTargetDate() async {
    try {
      final today = DateTime.now();
      final tomorrow = today.add(const Duration(days: 1));

      // Ambil charity dengan target date = H-1 dari sekarang
      final response = await supabase
          .from('charities')
          .select('id, title, target_date')
          .gte('target_date', today.toIso8601String())
          .lte('target_date', tomorrow.toIso8601String());

      print('chechking charity date...');

      if (response.isNotEmpty) {
        for (var charity in response) {
          final charityId = charity['id'];
          final charityTitle = charity['title'];

          // Kirim notifikasi
          await sendNotification(charityId, charityTitle);
        }
      }
    } catch (e) {
      print('Error checking charity target date: $e');
    }
  }

  Future<void> sendNotification(String charityId, String charityTitle) async {
    try {
      // Kirim notifikasi lokal
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 12342424, // ID unik untuk notifikasi
          channelKey: 'background_service',
          title: 'Charity Berakhir Besok!',
          body:
              'Charity "$charityTitle" akan berakhir besok. Jangan lupa berdonasi!',
          notificationLayout: NotificationLayout.Default,
        ),
      );
    
    } catch (e) {
      print('Gagal mengirim notifikasi: $e');
    }
  }
}
