import 'dart:convert';

import 'package:dompet_mal/models/CharityModel.dart';
import 'package:dompet_mal/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ContributorAdminController extends GetxController {
  final supabase = Supabase.instance.client;
  
  var contributors = <Contributor>[].obs;
  var users = <Users>[].obs;
  var charities = <Charity>[].obs;

  var filteredUsers = <Users>[].obs;
  var filteredCharities = <Charity>[].obs;
  
  var selectedUserId = ''.obs;
  var selectedCharityId = ''.obs;
  var isLoading = false.obs;

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
          .select('*, users:user_id(*), charities:charity_id(*)')
          .order('created_at');
      
      contributors.value = (response as List).map((data) {
        try {
          return Contributor.fromJson(data);
        } catch (e) {
          print('Error parsing contributor: $e');
          return null;
        }
      }).whereType<Contributor>().toList();
      
    } catch (e, stackTrace) {
      print('Error Failed to fetch contributors: $e');
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
      
      users.value = (response as List).map((data) {
        try {
          return Users.fromJson(data);
        } catch (e) {
          print('Error parsing user: $e');
          return null;
        }
      }).whereType<Users>().toList();
      
      filteredUsers.value = users.value; // Initially show all users
      
    } catch (e, stackTrace) {
      print('Error Failed to fetch users: $e');
      Get.snackbar('Error', 'Failed to fetch users: $e');
    }
  }

  void filterUsers(String query) {
    if (query.isEmpty) {
      filteredUsers.value = users.value;
    } else {
      filteredUsers.value = users.value.where((user) {
        return user.name.toLowerCase().contains(query.toLowerCase()) ||
               user.email.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }

  void filterCharities(String query) {
    if (query.isEmpty) {
      filteredCharities.value = charities.value;
    } else {
      filteredCharities.value = charities.value.where((charity) {
        return charity.title!.toLowerCase().contains(query.toLowerCase()) ||
               charity.description!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }

  Future<void> updateContributor(String contributorId) async {
  if (selectedUserId.isEmpty || selectedCharityId.isEmpty) {
    Get.snackbar('Error', 'Please select both a user and a charity');
    return;
  }

  try {
    // Check for existing contributor with same user and charity
    final existingContributor = await checkExistingContributor(
      selectedUserId.value, 
      selectedCharityId.value
    );

    if (existingContributor != null) {
      Get.snackbar(
        'Error', 
        'This user has already been assigned to this charity',
        backgroundColor: Colors.red,
        colorText: Colors.white
      );
      return;
    }

    final now = DateTime.now();
    final updatedContributor = {
      "user_id": selectedUserId.value,
      "charity_id": selectedCharityId.value,
      "updated_at": now.toIso8601String(),
    };

    await supabase
        .from('contributors')
        .update(updatedContributor)
        .match({'id': contributorId});
    
    Get.snackbar('Success', 'Contributor updated successfully');
    fetchContributors();
    selectedUserId.value = '';
    selectedCharityId.value = '';
  } catch (e) {
    print('Error updating contributor: $e');
    Get.snackbar('Error', 'Failed to update contributor: $e');
  }
}

Future<Map<String, dynamic>?> checkExistingContributor(String userId, String charityId) async {
  try {
    final response = await supabase
        .from('contributors')
        .select()
        .eq('user_id', userId)
        .eq('charity_id', charityId)
        .maybeSingle();
    
    return response;
  } catch (e) {
    print('Error checking existing contributor: $e');
    return null;
  }
}

Future<void> addContributor() async {
  if (selectedUserId.isEmpty || selectedCharityId.isEmpty) {
    Get.snackbar('Error', 'Please select both a user and a charity');
    return;
  }

  try {
    // Check for existing contributor with same user and charity
    final existingContributor = await checkExistingContributor(
      selectedUserId.value, 
      selectedCharityId.value
    );

    if (existingContributor != null) {
      Get.snackbar(
        'Error', 
        'This user has already been assigned to this charity',
        backgroundColor: Colors.red,
        colorText: Colors.white
      );
      return;
    }

    final now = DateTime.now();
    final newContributor = {
      "user_id": selectedUserId.value,
      "charity_id": selectedCharityId.value,
      "created_at": now.toIso8601String(),
      "updated_at": now.toIso8601String(),
    };

    await supabase
        .from('contributors')
        .insert(newContributor);
    
    Get.snackbar('Success', 'Contributor added successfully');
    fetchContributors();
    selectedUserId.value = '';
    selectedCharityId.value = '';
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
          .eq('status', 1);
      
      charities.value = (response).map((data) {
        try {
          return Charity.fromJson(data);
        } catch (e) {
          print('Error parsing charity: $e');
          return null;
        }
      }).whereType<Charity>().toList();
      
      filteredCharities.value = charities.value; // Initially show all charities
      
    } catch (e, stackTrace) {
      print('Error Failed to fetch charity: $e');
      Get.snackbar('Error', 'Failed to fetch charity: $e');
    } finally {
      isLoading.value = false;
    }
  }
}

// Contributor Model
class Contributor {
  final String? id;
  final String? userId;
  final String? charityId;
  final DateTime? created_at;
  final DateTime? updated_at;
  final Users? user;
  final Charity? charity;

  Contributor({
    this.id,
    this.userId,
    this.charityId,
    this.created_at,
    this.updated_at,
    this.user,
    this.charity,
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
      created_at: json["created_at"] == null 
          ? null 
          : DateTime.parse(json["created_at"].toString()),
      updated_at: json["updated_at"] == null 
          ? null 
          : DateTime.parse(json["updated_at"].toString()),
      user: json["users"] == null ? null : Users.fromJson(json["users"]),
      charity: json["charities"] == null ? null : Charity.fromJson(json["charities"])
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "charity_id": charityId,
        "created_at": created_at?.toIso8601String(),
        "updated_at": updated_at?.toIso8601String(),
      };
}