// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dompet_mal/app/modules/(home)/notification/controllers/notification_controller.dart';
import 'package:dompet_mal/service/cron_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:workmanager/workmanager.dart';
import 'app/routes/app_pages.dart';

// void initServices() async {
//   await Get.putAsync(() async => CronService());
// }

void requestNotificationPermission() async {
  await AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });
}

Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
  // Handle different routes based on channel key
  switch (receivedAction.channelKey) {
    case 'background_service':
      Get.toNamed(Routes.NOTIFICATION);
      break;
    case 'transaction_service':
      // If you need to pass transaction data
      final payload =
          receivedAction.payload; // Get any additional data if needed
      Get.toNamed(Routes.KONFIRMASI_TRANSFER, arguments: payload);
      break;
    default:
      Get.toNamed(Routes.NOTIFICATION); // Default route
  }
}

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await initializeDateFormatting('id_ID', null);
    await Supabase.initialize(
      url: 'https://clvoxiwvogfbditaqpdy.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNsdm94aXd2b2dmYmRpdGFxcGR5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzY5OTIyNzIsImV4cCI6MjA1MjU2ODI3Mn0.Plif2x-_VtEQ0vCjYG6xiWzQ7g39LEivn2y4fRworXM',
    );
    Get.put(NotificationController());

    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      await AwesomeNotifications().requestPermissionToSendNotifications();
    }
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
        NotificationChannel(
          channelKey: 'transaction_service',
          channelName: 'Transaction Service',
          channelDescription:
              'Notifications for transaction updates and reminders',
          defaultColor: Colors.green,
          importance: NotificationImportance.High,
        ),
      ],
    );
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
    );

//  requestNotificationPermission();

    await CronService().initializeService();

    FlutterBackgroundService().invoke("setAsForeground");

    // Cek koneksi dengan mencoba query sederhana

    print('Database connection successful!');

    runApp(
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Application",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        theme: ThemeData(useMaterial3: true),
      ),
    );

  } catch (e) {
    print('Database connection failed: $e');
    // Tampilkan dialog error atau handling sesuai kebutuhan
    runApp(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 48,
                ),
                const SizedBox(height: 16),
                Text(
                  'Koneksi database gagal',
                  style: GoogleFonts.poppins(fontSize: 18),
                ),
                const SizedBox(height: 8),
                Text(
                  e.toString(),
                  style: GoogleFonts.poppins(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Implementasi retry logic di sini
                    main();
                  },
                  child: Text('Coba Lagi'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
