import 'package:dompet_mal/app/modules/(admin)/categories/controllers/categories_controller.dart';
import 'package:dompet_mal/app/modules/(admin)/contributorAdmin/controllers/contributor_admin_controller.dart';
import 'package:dompet_mal/models/Category.dart';
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
  var contributors = <Contributor>[].obs;

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
  var charitySummary = CharitySummary(totalDonors: 0, totalDonations: 0).obs;

  @override
  void onInit() {
    super.onInit();
    fetchCharitiesWithContributors();
    fetchCategories();
    fetchCompanies();
    calculateCharitySummary();
  }

  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    progressController.dispose();
    targetTotalController.dispose();
    targetDateController.dispose();
    super.onClose();
  }

  Future<void> fetchCharitiesWithContributors() async {
    try {
      isCharitiesLoading.value = true;
      errorMessage.value = '';

      final response =
          await supabase.from('charities').select().eq('status', 1);
      List<Charity> charitiesWithDetails = [];

      for (var item in response) {
        final charity = Charity.fromJson(item);

        // Fetch contributors for this charity
        final contributorsResponse = await supabase
            .from('contributors')
            .select('*, users:user_id(*)')
            .eq('charity_id', charity.id!);

        // Process contributors and add image URLs
        charity.contributors =
            await Future.wait((contributorsResponse as List).map((data) async {
          final contributor = Contributor.fromJson(data);

          // Fetch image for the user from files table
          final userFileResponse = await supabase
              .from('files')
              .select('file_name')
              .eq('module_class', 'users')
              .eq('module_id', contributor.user!.id)
              .limit(1)
              .maybeSingle();

          // Update user's image if found
          if (userFileResponse != null) {
            contributor.user?.imageUrl = userFileResponse['file_name'];
          }

          return contributor;
        }));

        // Fetch charity image if needed
        final fileResponse = await supabase
            .from('files')
            .select('file_name')
            .eq('module_class', 'charities')
            .eq('module_id', charity.id!)
            .limit(1)
            .maybeSingle();

        if (fileResponse != null) {
          charity.image = fileResponse['file_name'];
        }

        final companyFileResponse = await supabase
            .from('files')
            .select('file_name')
            .eq('module_class', 'companies')
            .eq('module_id', charity.companyId!)
            .limit(1)
            .maybeSingle();

        if (companyFileResponse != null) {
          charity.companyImage = companyFileResponse['file_name'];
        }

        charity.companyName = item['companies']?['name'];

        charitiesWithDetails.add(charity);
      }

      charities.value = charitiesWithDetails;
    } catch (e) {
      errorMessage.value =
          'Failed to fetch charities with contributors: ${e.toString()}';
      print('Failed to fetch charities: ${e.toString()}');
      Get.snackbar('Error', errorMessage.value,
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isCharitiesLoading.value = false;
    }
  }

  // Add this method to your CharityAdminController class

  Future<Charity?> getCharityById(String charityId) async {
    try {
      // Fetch charity data
      final response = await supabase
          .from('charities')
          .select('*, companies(*)')
          .eq('id', charityId)
          .eq('status', 1)
          .single();

      if (response == null) {
        return null;
      }

      // Create charity object
      final charity = Charity.fromJson(response);

      // Fetch charity image from files table
      final fileResponse = await supabase
          .from('files')
          .select('file_name')
          .eq('module_class', 'charities')
          .eq('module_id', charityId)
          .limit(1)
          .maybeSingle();

      if (fileResponse != null) {
        charity.image = fileResponse['file_name'];
      }

      // Fetch company image if company_id exists
      if (charity.companyId != null) {
        final companyFileResponse = await supabase
            .from('files')
            .select('file_name')
            .eq('module_class', 'companies')
            .eq('module_id', charity.companyId!)
            .limit(1)
            .maybeSingle();

        if (companyFileResponse != null) {
          charity.companyImage = companyFileResponse['file_name'];
        }
      }

      // Set company name from the joined companies table data
      charity.companyName = response['companies']?['name'];

      return charity;
    } catch (e) {
      errorMessage.value = 'Failed to fetch charity: ${e.toString()}';
      print('Error fetching charity: $e');
      Get.snackbar(
        'Error',
        'Failed to fetch charity details',
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
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

  Future<void> updateCharityTotal(
      String charityId, int newTotal, int newProgress) async {
    try {
      await supabase.from('charities').update({
        'total': newTotal,
        'progress': newProgress,
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('id', charityId);
    } catch (e) {
      errorMessage.value = 'Failed to update charity total: ${e.toString()}';
      Get.snackbar('Error', errorMessage.value,
          snackPosition: SnackPosition.BOTTOM);
      throw e;
    }
  }

  Future<void> calculateCharitySummary() async {
    try {
      // Fetch all transactions
      final donorsResponse =
          await supabase.from('transactions').select().eq('status', 3);

      // Calculate total donations by summing donation prices
      final totalDonations = donorsResponse.fold(0.0,
          (sum, transaction) => sum + (transaction['donation_price'] ?? 0.0));

      // Get unique donors by user_id

      charitySummary.value = CharitySummary(
        totalDonors: donorsResponse.length,
        totalDonations: totalDonations.toInt(),
      );

      print('Total Donors: ${donorsResponse.length}');
      print('Total Donations: $totalDonations');
    } catch (e) {
      errorMessage.value =
          'Failed to calculate charity summary: ${e.toString()}';
      Get.snackbar('Error', errorMessage.value,
          snackPosition: SnackPosition.BOTTOM);
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
        targetDate: targetDateController.text,
        created_at: DateTime.now(),
        updated_at: DateTime.now(),
        status: 1,
      );

      await supabase.from('charities').insert(newCharity.toJson());
      await fetchCharitiesWithContributors();

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
        targetDate: targetDateController.text,
        created_at: DateTime.now(), // Optionally keep the original created_at
        updated_at: DateTime.now(),
        status: 1,
      );

      await supabase
          .from('charities')
          .update(updatedCharity.toJson())
          .eq('id', charityId);
      await fetchCharitiesWithContributors();

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

      await fetchCharitiesWithContributors(); // Refresh data

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
    targetDateController.clear();
    targetTotalController.clear();
    // Reset tanggal
  }

  // Show category selection dialog
  // Show category selection dialog
  void showCategorySelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Category'),
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
          title: Text('Select Company'),
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

class CharitySummary {
  final int totalDonors;
  final int totalDonations;

  CharitySummary({
    required this.totalDonors,
    required this.totalDonations,
  });
}
