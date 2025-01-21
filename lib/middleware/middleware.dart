import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthMiddleware extends GetMiddleware {
  AuthMiddleware() {
    // Initialize SharedPreferences and store it in GetX dependency injection
    SharedPreferences.getInstance().then((prefs) {
      Get.put<SharedPreferences>(prefs, permanent: true);
    });
  }

  @override
  RouteSettings? redirect(String? route) {
    // Retrieve SharedPreferences from GetX
    final prefs = Get.find<SharedPreferences>();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (!isLoggedIn) {
      return RouteSettings(name: '/login');
    }
    return null; // Allow navigation to proceed
  }
}
