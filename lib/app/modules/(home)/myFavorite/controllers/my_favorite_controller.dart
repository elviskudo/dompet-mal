import 'package:dompet_mal/app/modules/(admin)/charityAdmin/controllers/charity_admin_controller.dart';
import 'package:dompet_mal/models/CharityModel.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MyFavoriteController extends GetxController {
  final supabase = Supabase.instance.client;
  final favorites = <Map<String, dynamic>>[].obs;
  final filteredCharities = <Charity>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getFavorites();
  }

  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  Future<void> getFavorites() async {
    try {
      isLoading.value = true;
      final userId = await getUserId();
      if (userId == null) return;

      // Mengambil data favorites yang is_favorite = true
      final response = await supabase
          .from('favorites')
          .select('*, charities(*)')
          .eq('user_id', userId)
          .eq('is_favorite', true);

      favorites.value = response as List<Map<String, dynamic>>;
      
      // Filter charity berdasarkan data favorites
      filterCharities();
    } catch (e) {
      print('Error getting favorites: $e');
      Get.snackbar(
        'Error',
        'Failed to load favorites',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Method baru untuk memfilter charities
  void filterCharities() {
    final charityController = Get.find<CharityAdminController>();
    
    // Filter charity yang ada di favorites
    filteredCharities.value = charityController.charities.value.where((charity) {
      return favorites.any((favorite) => 
        favorite['charity_id'] == charity.id && 
        favorite['is_favorite'] == true
      );
    }).toList();
  }

  Future<bool> isFavorited(String charityId) async {
    try {
      final userId = await getUserId();
      if (userId == null) return false;

      final response = await supabase
          .from('favorites')
          .select()
          .eq('charity_id', charityId)
          .eq('user_id', userId)
          .eq('is_favorite', true)
          .single();

      return response != null;
    } catch (e) {
      return false;
    }
  }

  Future<void> toggleFavorite(String charityId) async {
    try {
      final userId = await getUserId();
      if (userId == null) {
        Get.snackbar(
          'Error',
          'Please login first',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      final existingFavorite = await supabase
          .from('favorites')
          .select()
          .eq('charity_id', charityId)
          .eq('user_id', userId)
          .maybeSingle();

      if (existingFavorite == null) {
        await supabase.from('favorites').insert({
          'charity_id': charityId,
          'user_id': userId,
          'is_favorite': true,
        });
      } else {
        await supabase
            .from('favorites')
            .update({'is_favorite': !existingFavorite['is_favorite']})
            .eq('id', existingFavorite['id']);
      }

      await getFavorites();
      // Update filtered charities setelah toggle
      filterCharities();
      
      Get.snackbar(
        'Success',
        existingFavorite == null ? 'Added to favorites' : 'Updated favorites',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      print('Error toggling favorite: $e');
      Get.snackbar(
        'Error',
        'Failed to update favorites',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}