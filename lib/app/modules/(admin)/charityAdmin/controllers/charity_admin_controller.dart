import 'package:dompet_mal/app/modules/(admin)/categories/controllers/categories_controller.dart';
import 'package:dompet_mal/models/CharityModel.dart';
import 'package:dompet_mal/models/Companies.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class CharityAdminController extends GetxController {
  final supabase = Supabase.instance.client;

  // Observables
  var charities = <Charity>[].obs;
  var categories = <Category>[].obs;
  var companies = <Companies>[].obs;
  final TextEditingController targetTotalController = TextEditingController();
final TextEditingController totalController = TextEditingController();
final TextEditingController progressController = TextEditingController();
final TextEditingController targetDateController = TextEditingController();


  // Loading states
  var isLoading = false.obs;
  var isCharitiesLoading = false.obs;
  var isCategoriesLoading = false.obs;
  var isCompaniesLoading = false.obs;
  var isAddingCharity = false.obs;
  var isUpdatingCharity = false.obs;
  var isDeletingCharity = false.obs;
 final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  // Error handling
  var errorMessage = ''.obs;

  // Form Fields
  var selectedCategoryId = ''.obs;
  var selectedCompanyId = ''.obs;
  RxString title = ''.obs;
  RxString description = ''.obs;
  var progress = 0.obs;
  var total = 0.obs;
  var targetTotal = 0.obs;
  var targetDate = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();
    fetchCharities();
    fetchCategories();
    fetchCompanies();
  }

  // Fetch charities
  Future<void> fetchCharities() async {
    try {
      isCharitiesLoading.value = true;
      errorMessage.value = '';

      final response = await supabase.from('charities').select().eq('status', 1);
      charities.value =
          (response as List).map((e) => Charity.fromJson(e)).toList();
    } catch (e) {
      errorMessage.value = 'Failed to fetch charities: ${e.toString()}';
      print('Failed to fetch charities: ${e.toString()}');
      Get.snackbar('Error', errorMessage.value,
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isCharitiesLoading.value = false;
    }
  }

  // Fetch categories
  Future<void> fetchCategories() async {
    try {
      isCategoriesLoading.value = true;
      errorMessage.value = '';

      final response = await supabase.from('categories').select();
      categories.value =
          (response as List).map((e) => Category.fromJson(e)).toList();
    } catch (e) {
      errorMessage.value = 'Failed to fetch categories: ${e.toString()}';
      Get.snackbar('Error', errorMessage.value,
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isCategoriesLoading.value = false;
    }
  }

  // Fetch companies
  Future<void> fetchCompanies() async {
    try {
      isCompaniesLoading.value = true;
      errorMessage.value = '';

      final response = await supabase.from('companies').select();
      companies.value =
          (response as List).map((e) => Companies.fromJson(e)).toList();
    } catch (e) {
      errorMessage.value = 'Failed to fetch companies: ${e.toString()}';
      Get.snackbar('Error', errorMessage.value,
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isCompaniesLoading.value = false;
    }
  }

  // Add Charity
  Future<void> addCharity() async {
  try {
    isAddingCharity.value = true;
    errorMessage.value = '';

    final id = const Uuid().v4();
    final newCharity = Charity(
      id: id,
      categoryId: selectedCategoryId.value,
      companyId: selectedCompanyId.value,
      title: titleController.text,
      description: descriptionController.text,
      progress: int.parse(progressController.text),
      // total: int.parse(totalController.text),
      targetTotal: int.parse(targetTotalController.text),
      targetDate: DateTime.parse(targetDateController.text),
      created_at: DateTime.now(),
      updated_at: DateTime.now(),
      status: 1,
    );

    await supabase.from('charities').insert(newCharity.toJson());
    await fetchCharities();

    resetFormFields();

    Get.snackbar('Success', 'Charity added successfully',
        snackPosition: SnackPosition.BOTTOM);
  } catch (e) {
    errorMessage.value = 'Failed to add charity: ${e.toString()}';
    Get.snackbar('Error', errorMessage.value,
        snackPosition: SnackPosition.BOTTOM);
  } finally {
    isAddingCharity.value = false;
  }
}


  // Update Charity
Future<void> updateCharity(String charityId) async {
  try {
    isUpdatingCharity.value = true;
    errorMessage.value = '';

    final updatedCharity = Charity(
      id: charityId,
      categoryId: selectedCategoryId.value,
      companyId: selectedCompanyId.value,
      title: titleController.text,
      description: descriptionController.text,
      progress: int.parse(progressController.text),
      // total: int.parse(totalController.text),
      targetTotal: int.parse(targetTotalController.text),
       targetDate: DateTime.parse(targetDateController.text),
      created_at: DateTime.now(), // Optionally keep the original created_at
      updated_at: DateTime.now(),
      status: 1,
    );

    await supabase
        .from('charities')
        .update(updatedCharity.toJson())
        .eq('id', charityId);
    await fetchCharities();

    resetFormFields();

    Get.snackbar('Success', 'Charity updated successfully',
        snackPosition: SnackPosition.BOTTOM);
  } catch (e) {
    errorMessage.value = 'Failed to update charity: ${e.toString()}';
    Get.snackbar('Error', errorMessage.value,
        snackPosition: SnackPosition.BOTTOM);
  } finally {
    isUpdatingCharity.value = false;
  }
}


  // Delete Charity
  Future<void> deleteCharity(String id) async {
  try {
    isDeletingCharity.value = true;
    errorMessage.value = '';

    // Update status menjadi 0
    await supabase
        .from('charities')
        .update({'status': 0}) // Mengubah status menjadi 0
        .eq('id', id);

    await fetchCharities(); // Refresh data

    Get.snackbar('Success', 'Charity status updated successfully',
        snackPosition: SnackPosition.BOTTOM);
  } catch (e) {
    errorMessage.value = 'Failed to update charity status: ${e.toString()}';
    Get.snackbar('Error', errorMessage.value,
        snackPosition: SnackPosition.BOTTOM);
  } finally {
    isDeletingCharity.value = false;
  }
}


  // Reset form fields
  void resetFormFields() {
  titleController.clear();
  descriptionController.clear();
  selectedCategoryId.value = '';
  selectedCompanyId.value = '';
  progress.value = 0;
  total.value = 0;
  targetTotal.value = 0;
  targetDateController.clear(); // Reset tanggal
}


  // Show category selection dialog
  // Show category selection dialog
  void showCategorySelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Category'),
          content: Obx(
            () => isCategoriesLoading.value
                ? Center(child: CircularProgressIndicator())
                : categories.isEmpty
                    ? Text('No categories available')
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          return ListTile(
                            title: Text(category.name ?? ''),
                            onTap: () {
                              selectedCategoryId.value = category.id ?? '';
                              Navigator.pop(context);
                            },
                          );
                        },
                      ),
          ),
        );
      },
    );
  }

  // Show company selection dialog
  void showCompanySelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Company'),
          content: Obx(
            () => isCompaniesLoading.value
                ? Center(child: CircularProgressIndicator())
                : companies.isEmpty
                    ? Text('No companies available')
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: companies.length,
                        itemBuilder: (context, index) {
                          final company = companies[index];
                          return ListTile(
                            title: Text(company.name ?? ''),
                            onTap: () {
                              selectedCompanyId.value = company.id ?? '';
                              Navigator.pop(context);
                            },
                          );
                        },
                      ),
          ),
        );
      },
    );
  }
}
