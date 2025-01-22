import 'dart:convert';

import 'package:dompet_mal/models/CharityModel.dart';
import 'package:dompet_mal/models/userModel.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// contributor_model.dart
import 'dart:convert';
import 'package:dompet_mal/models/userModel.dart';

class Contributor {
  final String? id;
  final String? userId;  // Changed to nullable
  final String? charityId;
  final DateTime? createdAt;  // Changed to nullable
  final DateTime? updatedAt;  // Changed to nullable
  final Users? user;

  Contributor({
    this.id,
    this.userId,  // Made optional
    this.charityId,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  factory Contributor.fromRawJson(String str) => 
      Contributor.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Contributor.fromJson(Map<String, dynamic> json) {
    print('Converting JSON to Contributor: $json'); // Debug log
    return Contributor(
        id: json["id"]?.toString(),
        userId: json["user_id"]?.toString(),
        charityId: json["charity_id"]?.toString(),
        createdAt: json["created_at"] == null 
            ? null 
            : DateTime.parse(json["created_at"].toString()),
        updatedAt: json["updated_at"] == null 
            ? null 
            : DateTime.parse(json["updated_at"].toString()),
        user: json["users"] == null ? null : Users.fromJson(json["users"]),
      );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "charity_id": charityId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

// contributor_admin_controller.dart
class ContributorAdminController extends GetxController {
  final supabase = Supabase.instance.client;
  
  var contributors = <Contributor>[].obs;
  var users = <Users>[].obs;
  var selectedUserId = ''.obs;
  var selectedCharityId = ''.obs;
  var isLoading = false.obs;
 var charities = <Charity>[].obs;
  @override
  void onInit() {
    super.onInit();
    fetchContributors();
    fetchUsers();
    fetchCharity();
  }

  Future<void> fetchContributors() async {
    isLoading.value = true;
    try {
      final response = await supabase
          .from('contributors')
          .select('*, users:user_id(*)')
          .order('created_at');
      
      print('Supabase response: $response'); // Debug log
      
      contributors.value = (response as List).map((data) {
        try {
          return Contributor.fromJson(data);
        } catch (e) {
          print('Error parsing contributor: $e');
          print('Problematic data: $data');
          return null;
        }
      }).whereType<Contributor>().toList();
      
    } catch (e, stackTrace) {
      print('Error Failed to fetch contributors: $e');
      print('Stack trace: $stackTrace');
      Get.snackbar('Error', 'Failed to fetch contributors: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchUsers() async {
    try {
      final response = await supabase
          .from('users')
          .select()
          .order('name');
      
      print('Users response: $response'); // Debug log
      
      users.value = (response as List).map((data) {
        try {
          return Users.fromJson(data);
        } catch (e) {
          print('Error parsing user: $e');
          print('Problematic data: $data');
          return null;
        }
      }).whereType<Users>().toList();
      
    } catch (e, stackTrace) {
      print('Error Failed to fetch users: $e');
      print('Stack trace: $stackTrace');
      Get.snackbar('Error', 'Failed to fetch users: $e');
    }
  }

  Future<void> addContributor() async {
    if (selectedUserId.isEmpty) {
      Get.snackbar('Error', 'Please select a user');
      return;
    }

    try {
      final now = DateTime.now();
      final newContributor = {
        "user_id": selectedUserId.value,
        "charity_id": selectedCharityId.value,
        "created_at": now.toIso8601String(),
        "updated_at": now.toIso8601String(),
      };

      print('Adding contributor: $newContributor'); // Debug log

      await supabase
          .from('contributors')
          .insert(newContributor);
      
      Get.snackbar('Success', 'Contributor added successfully');
      fetchContributors();
    } catch (e) {
      print('Error adding contributor: $e');
      Get.snackbar('Error', 'Failed to add contributor: $e');
    }
  }

  Future<void> deleteContributor(String? id) async {
    if (id == null) return;
    
    try {
      await supabase
          .from('contributors')
          .delete()
          .match({'id': id});
      Get.snackbar('Success', 'Contributor deleted successfully');
      fetchContributors();
    } catch (e) {
      print('Error deleting contributor: $e');
      Get.snackbar('Error', 'Failed to delete contributor: $e');
    }
  }
   Future<void> fetchCharity() async {
    isLoading.value = true;
    try {
      final response = await supabase
          .from('charities')
          .select()
          .order('created_at');
      
      print('charity response: $response'); 
      
      charities.value = (response).map((data) {
        try {
          return Charity.fromJson(data);
        } catch (e) {
          print('Error parsing charirty: $e');
          print('Problematic data: $data');
          return null;
        }
      }).whereType<Charity>().toList();
      
    } catch (e, stackTrace) {
      print('Error Failed to fetch charirty: $e');
      print('Stack trace: $stackTrace');
      Get.snackbar('Error', 'Failed to fetch charirty: $e');
    } finally {
      isLoading.value = false;
    }
  }
}