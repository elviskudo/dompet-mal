import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class Category {
  String? id;
  String? name;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;

  Category({
    this.id,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        description: json["description"],
       
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

Map<String, dynamic> toJson() => {
      "id": id ?? const Uuid().v4(),
      "name": name,
      "description": description,
      "created_at": createdAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
      "updated_at": updatedAt?.toIso8601String(),
    };

}


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
          .order('created_at', ascending: false);

      categories.value = (response as List)
          .map((item) => Category.fromJson(item))
          .toList();
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