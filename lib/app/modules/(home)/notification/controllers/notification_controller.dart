import 'package:dompet_mal/models/notification.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotificationController extends GetxController {
  final supabase = Supabase.instance.client;
  final notifications = <NotificationModels>[].obs;
  final isLoading = false.obs;

  // Computed property for grouped notifications
  Map<String, List<NotificationModels>> get groupedNotifications {
    final grouped = <String, List<NotificationModels>>{};

    for (var notification in notifications) {
      if (notification.createdAt != null) {
        final monthYear =
            DateFormat('MMMM yyyy', 'id_ID').format(notification.createdAt!);

        if (!grouped.containsKey(monthYear)) {
          grouped[monthYear] = [];
        }
        grouped[monthYear]!.add(notification);
      }
    }

    // Sort the groups by date (newest first)
    final sortedKeys = grouped.keys.toList()
      ..sort((a, b) {
        final aDate = DateFormat('MMMM yyyy', 'id_ID').parse(a);
        final bDate = DateFormat('MMMM yyyy', 'id_ID').parse(b);
        return bDate.compareTo(aDate);
      });

    return Map.fromEntries(
      sortedKeys.map((key) => MapEntry(key, grouped[key]!)),
    );
  }

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  Future<void> loadNotifications() async {
    // if (currentUserId.value.isEmpty) return;
    final prefs = await SharedPreferences.getInstance();
    var currentUserId = prefs.getString('userId') ?? '';

    try {
      isLoading.value = true;
      final response = await supabase
          .from('notifications')
          .select()
          .eq('user_id', currentUserId)
          .eq('is_deleted', false) 
          .order('created_at', ascending: false);

      if (response != null) {
        final List<NotificationModels> loadedNotifications =
            (response as List<dynamic>)
                .map((json) => NotificationModels.fromJson(json))
                .toList();

        notifications.value = loadedNotifications;
      }
    } catch (e) {
      print('Error loading notifications: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteNotification(NotificationModels notification) async {
    try {
      if (notification.id != null) {
        // Update is_deleted to true instead of deleting
        await supabase
            .from('notifications')
            .update({'is_deleted': true}).eq('id', notification.id!);

        // Remove from local list
        notifications.remove(notification);

        
      }
    } catch (e) {
      print('Error soft deleting notification: $e');
      Get.snackbar(
        'Error',
        'Gagal menghapus notifikasi',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Optional: Method to restore deleted notifications
  Future<void> restoreNotification(String notificationId) async {
    try {
      await supabase
          .from('notifications')
          .update({'is_deleted': false}).eq('id', notificationId);

      // Reload notifications after restore
      await loadNotifications();

      Get.snackbar(
        'Sukses',
        'Notifikasi berhasil dipulihkan',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      print('Error restoring notification: $e');
      Get.snackbar(
        'Error',
        'Gagal memulihkan notifikasi',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
