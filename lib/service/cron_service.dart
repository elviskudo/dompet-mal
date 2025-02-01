import 'dart:async';
import 'package:cron/cron.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dompet_mal/app/modules/(home)/notification/controllers/notification_controller.dart';
import 'package:dompet_mal/service/transactions/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:ui';

import 'charity/charity.cron.dart';

class CronService {
  Future<void> initializeService() async {
    final service = FlutterBackgroundService();

    await service.startService();
    // Inisialisasi Awesome Notifications
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'background_service',
          channelName: 'Background Service',
          channelDescription: 'Notifications from background service',
          defaultColor: Colors.blue,
          importance: NotificationImportance.High,
        ),
      ],
    );

    // Konfigurasi service
    await service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        autoStart: true,
        isForegroundMode: true,
        foregroundServiceNotificationId: 888,
        notificationChannelId: 'background_service',
        autoStartOnBoot: true,
        initialNotificationTitle: 'Dompet Mal Service',
        initialNotificationContent: 'Initializing',
        foregroundServiceTypes: [
          AndroidForegroundType.dataSync,
          AndroidForegroundType.shortService,
        ],
      ),
      iosConfiguration: IosConfiguration(
        autoStart: true,
        onForeground: onStart,
        onBackground: onIosBackground,
      ),
    );

    // Langsung jalankan service dalam mode background

    // Set sebagai background service setelah start
    // if (service is AndroidServiceInstance) {
    //   service.setAsBackgroundService();
    // }
  }

  @pragma('vm:entry-point')
  static Future<bool> onIosBackground(ServiceInstance service) async {
    WidgetsFlutterBinding.ensureInitialized();
    DartPluginRegistrant.ensureInitialized();
    return true;
  }

  @pragma('vm:entry-point')
  static void onStart(ServiceInstance service) async {
    DartPluginRegistrant.ensureInitialized();

    // Inisialisasi Supabase sebelum menggunakannya
    await Supabase.initialize(
      url: 'https://clvoxiwvogfbditaqpdy.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNsdm94aXd2b2dmYmRpdGFxcGR5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzY5OTIyNzIsImV4cCI6MjA1MjU2ODI3Mn0.Plif2x-_VtEQ0vCjYG6xiWzQ7g39LEivn2y4fRworXM',
    );

    if (service is AndroidServiceInstance) {
      await service.setForegroundNotificationInfo(
        title: "Dompet Mal Service",
        content: "Running in foreground",
      );
      await service.setAsForegroundService();
    }

    // service.on('stopService').listen((event) async {
    //   service.stopSelf();
    // });

    // Setup periodic task
    Timer.periodic(Duration(seconds: 15), (timer) async {
      if (service is AndroidServiceInstance) {
        print("Service berjalan di foreground.");

        // Get.put(NotificationController());

        // await TransactionCronJob().notificationController;/
        await TransactionCronJob().checkPendingTransactions();
        // await service.setForegroundNotificationInfo(
        //   title: "Dompet Mal Service",
        //   content: "Last check: ${DateTime.now()}",
        // );
      }

      print("Background service is running: ${DateTime.now()}");
      // await TransactionCronJob().checkPendingTransactions();

      // **PASTIKAN Supabase SUDAH DIINISIALISASI sebelum CharityCronJob dipanggil**
      // await CharityCronJob().checkCharityTargetDate();

      service.invoke('update');
    });

    // Setup cron job
    final cron = Cron();
    cron.schedule(Schedule.parse('*/15 * * * *'), () async {
      print('Running cron job');
    });
  }
}
