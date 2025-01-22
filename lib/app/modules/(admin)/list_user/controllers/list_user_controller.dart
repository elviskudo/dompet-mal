import 'package:dompet_mal/app/routes/app_pages.dart';
import 'package:dompet_mal/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ListUserController extends GetxController {
  final supabase = Supabase.instance.client;
  final RxList<Users> usersList = <Users>[].obs;
  RxBool isLoading = false.obs;
  RxString roleUser = ''.obs;
  RxString currentUserId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getCurrentUser();
  }

  Future<void> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    currentUserId.value = prefs.getString('userId') ?? '';
  }

  Future<bool> isAdmin() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final role = prefs.getString('userRole');

      if (role != 'admin') {
        // Navigate back to previous page or login
        Get.offAllNamed(Routes.LOGIN);
        return false;
      }

      return role == 'admin';
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to verify admin role: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      Get.offAllNamed(Routes.LOGIN);
      return false;
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      isLoading.value = true;

      await supabase.from('user_roles').delete().eq('user_id', userId);
      // Hapus pengguna dari tabel `users`
      await supabase.from('users').delete().eq('id', userId);

      await fetchUsers();

      // Hapus entri dari tabel `user_roles`

      Get.snackbar(
        'Success',
        'User successfully deleted',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Perbarui daftar pengguna
      update();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to delete user: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateUser(
      String userId, Map<String, dynamic> updatedData) async {
    try {
      isLoading.value = true;
      await supabase.from('users').update(updatedData).eq('id', userId);

      // Fetch updated users list
      await fetchUsers();

      Get.snackbar(
        'Success',
        'User successfully updated',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update user: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateUserRole(String userId, String roleId) async {
    try {
      isLoading.value = true;

      // Perbarui role_id di tabel `user_roles`
      await supabase
          .from('user_roles')
          .update({'role_id': roleId}).eq('user_id', userId);

      // Fetch updated users list after role update
      await fetchUsers();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update user role: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<Users>> fetchUsers() async {
    try {
      final response = await supabase.from('users').select('*');
      final data = response as List<dynamic>;

      List<Users> users = [];

      for (final user in data) {
        final userRole = await supabase
            .from('user_roles')
            .select()
            .eq('user_id', user['id'])
            .single();

        final roles = await supabase
            .from('roles')
            .select()
            .eq('id', userRole['role_id'])
            .single();

        final roleName = roles['name'] ?? 'member';

        users.add(Users(
          id: user['id'] as String,
          name: user['name'] as String,
          email: user['email'] as String,
          role: roleName,
          phoneNumber: user['phone_number'] as String,
          accessToken: user['access_token'] as String,
          createdAt: DateTime.parse(user['created_at'] as String),
          updatedAt: DateTime.parse(user['updated_at'] as String),
        ));
      }

      // Update the reactive list
      usersList.value = users;
      return users;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to fetch users: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return [];
    }
  }

  Future<void> logout() async {
    try {
      isLoading.value = true;

      // Sign out from Supabase
      await supabase.auth.signOut();

      // Clear SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      Get.snackbar(
        'Success',
        'Successfully logged out',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
      );

      // Navigate to login page
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to logout: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<Map<String, String>>> fetchRoles() async {
    try {
      // Ambil semua role dari tabel `roles`
      final response = await supabase.from('roles').select('*');

      // Mapping hasil data ke List<Map<String, String>>
      return (response as List<dynamic>)
          .map((role) => {
                'id': role['id'] as String,
                'name': role['name'] as String,
              })
          .toList();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to fetch roles: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return [];
    }
  }

  Future<bool> showConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Delete User'),
              content: Text('Are you sure you want to delete this user?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: Text('Delete'),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  void showEditDialog(BuildContext context, Users user) async {
    final nameController = TextEditingController(text: user.name);
    final emailController = TextEditingController(text: user.email);
    String selectedRoleId = ''; // Role yang dipilih
    List<Map<String, String>> roles = []; // Daftar role

    // Ambil daftar role dari controller
    roles = await fetchRoles();
    selectedRoleId =
        roles.firstWhere((role) => role['name'] == user.role)['id'] ?? '';

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Edit User'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(labelText: 'Name'),
                    ),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(labelText: 'Email'),
                    ),
                    DropdownButtonFormField<String>(
                      value: selectedRoleId,
                      items: roles
                          .map((role) => DropdownMenuItem(
                                value: role['id'],
                                child: Text(role['name']!),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedRoleId = value!;
                        });
                      },
                      decoration: InputDecoration(labelText: 'Role'),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    final updatedData = {
                      'name': nameController.text,
                      'email': emailController.text,
                    };

                    // Perbarui data pengguna
                    await updateUser(user.id, updatedData);

                    // Perbarui role pengguna jika ada perubahan
                    if (selectedRoleId.isNotEmpty &&
                        selectedRoleId !=
                            roles.firstWhere(
                                (role) => role['name'] == user.role)['id']) {
                      await updateUserRole(user.id, selectedRoleId);
                    }
// Fetch the updated list one final time to ensure everything is in sync
                    await fetchUsers();
                    Navigator.pop(context); // Tutup dialog
                  },
                  child: Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
