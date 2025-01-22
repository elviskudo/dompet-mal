import 'package:dompet_mal/app/modules/(admin)/categories/controllers/categories_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesView extends GetView<CategoriesController> {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          FloatingActionButton(onPressed: () => _showCategoryDialog(context), child: Icon(Icons.add),),
      appBar: AppBar(
        title: const Text('Categories'),
        centerTitle: true,
        actions: [],
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: controller.categories.length,
                itemBuilder: (context, index) {
                  final category = controller.categories[index];
                  return ListTile(
                    // leading: category.icon != null
                    //     ? Image.network(
                    //         category.icon!,
                    //         width: 40,
                    //         height: 40,
                    //         errorBuilder: (context, error, stackTrace) =>
                    //             const Icon(Icons.category),
                    //       )
                    //     : const Icon(Icons.category),
                    title: Text(category.name ?? ''),
                    subtitle: Text(category.description ?? ''),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () =>
                              _showCategoryDialog(context, category: category),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () =>
                              _showDeleteConfirmation(category.id!),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }

  void _showCategoryDialog(BuildContext context, {Category? category}) {
    final nameController = TextEditingController(text: category?.name);
    final descController = TextEditingController(text: category?.description);

    Get.dialog(
      AlertDialog(
        title: Text(category == null ? 'Add Category' : 'Edit Category'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
           
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final newCategory = Category(
                id: category?.id,
                name: nameController.text,
                description: descController.text,
                updatedAt: DateTime.now(),
              );

              if (category == null) {
                controller.addCategory(newCategory);
              } else {
                controller.updateCategory(newCategory);
              }
              Get.back();
            },
            child: Text(category == null ? 'Add' : 'Update'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(String id) {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete Category'),
        content: const Text('Are you sure you want to delete this category?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              controller.deleteCategory(id);
              Get.back();
            },
            child: const Text('Delete'),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
          ),
        ],
      ),
    );
  }
}
