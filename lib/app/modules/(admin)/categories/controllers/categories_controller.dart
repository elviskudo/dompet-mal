import 'package:dompet_mal/models/Category.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class CategoriesController extends GetxController {
  final SupabaseClient supabase = Supabase.instance.client;
  RxList<Category> categories = <Category>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getCategories();
  }

  // Get all categories
  Future<void> getCategories() async {
    try {
      isLoading.value = true;
      final response = await supabase
          .from('categories')
          .select()
          .order('name', ascending: true);

      List<Category> categoriesWithImages = [];
      for (var item in response) {
        final category = Category.fromJson(item);

        final fileResponse = await supabase
            .from('files')
            .select('file_name')
            .eq('module_class', 'categories')
            .eq('module_id', category.id!)
            .limit(1) 
            .maybeSingle(); 

        if (fileResponse != null) {
          category.imageUrl = fileResponse['file_name'];
        }

        categoriesWithImages.add(category);
      }

      categories.value = categoriesWithImages;
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch categories: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Add new category
  Future<void> addCategory(Category category) async {
    try {
      isLoading.value = true;
      await supabase.from('categories').insert(category.toJson());
      await getCategories(); // Refresh the list
      Get.snackbar('Success', 'Category added successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to add category: $e');
      print('Error Failed to add category: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Update category
  Future<void> updateCategory(Category category) async {
    try {
      isLoading.value = true;
      await supabase
          .from('categories')
          .update(category.toJson())
          .eq('id', category.id as Object);
      await getCategories(); // Refresh the list
      Get.snackbar('Success', 'Category updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update category: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Delete category
  Future<void> deleteCategory(String id) async {
    try {
      isLoading.value = true;
      await supabase.from('categories').delete().eq('id', id);
      await getCategories(); // Refresh the list
      Get.snackbar('Success', 'Category deleted successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete category: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
