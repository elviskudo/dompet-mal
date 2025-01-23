import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:dompet_mal/models/Companies.dart';

class CompaniesController extends GetxController {
  final SupabaseClient supabase = Supabase.instance.client;

  // Data companies akan disimpan di sini
  var companiesList = <Companies>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCompanies(); // Ambil data saat controller diinisialisasi
  }

  // Fetch all companies
  Future<void> fetchCompanies() async {
    isLoading(true);
    try {
      final response = await supabase
          .from('companies')
          .select()
          .order('name', ascending: true);
      print('res: $response');
      companiesList.value =
          (response as List).map((item) => Companies.fromJson(item)).toList();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Add a new company
  Future<void> addCompany(Companies company) async {
    try {
      isLoading.value = true;

      await supabase.from('companies').insert(company.toJson());
      fetchCompanies(); // Refresh data
      Get.snackbar('Success', 'Company added successfully');
    } catch (e) {
      print('erorr $e');
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Update an existing company
  Future<void> updateCompany(String id, Companies company) async {
    try {
      final response = await supabase
          .from('companies')
          .update(company.toJson())
          .eq('id', id);
      if (response == null) {
        fetchCompanies(); // Refresh data
        Get.snackbar('Success', 'Company updated successfully');
      } else {
        Get.snackbar('Error', response.error!.message);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // Delete a company by ID
  Future<void> deleteCompany(String id) async {
    try {
      final response = await supabase.from('companies').delete().eq('id', id);
      if (response == null) {
        fetchCompanies(); // Refresh data
        Get.snackbar('Success', 'Company deleted successfully');
      } else {
        Get.snackbar('Error', response);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
