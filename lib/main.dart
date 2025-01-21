import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);

  try {
    EmailOTP.config(
      appName: 'Dompet Mal',
      otpType: OTPType.numeric,
      emailTheme: EmailTheme.v1,
    );
    await Supabase.initialize(
      url: 'https://clvoxiwvogfbditaqpdy.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNsdm94aXd2b2dmYmRpdGFxcGR5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzY5OTIyNzIsImV4cCI6MjA1MjU2ODI3Mn0.Plif2x-_VtEQ0vCjYG6xiWzQ7g39LEivn2y4fRworXM',
    );

    // Cek koneksi dengan mencoba query sederhana
    final supabase = Supabase.instance.client;

    var users = await supabase.from('users').select().limit(10);
    print('users: $users');
    print('============================================================');
    var roles = await supabase.from('roles').select().limit(10);
    print('role: $roles');
    print('============================================================');

    var user_roles = await supabase.from('user_roles').select().limit(10);
    print('user roles: $user_roles');

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
                const Text(
                  'Koneksi database gagal',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 8),
                Text(
                  e.toString(),
                  style: const TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Implementasi retry logic di sini
                    main();
                  },
                  child: const Text('Coba Lagi'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
