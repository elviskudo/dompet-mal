import 'package:dompet_mal/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../controllers/list_user_controller.dart';

class ListUserView extends GetView<ListUserController> {
  ListUserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: controller.isAdmin(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError || !(snapshot.data ?? false)) {
          return Scaffold(
            appBar: AppBar(title: const Text('Access Denied')),
            body: const Center(
              child: Text('You do not have permission to access this page.'),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('User List'),
                Gap(20),
                InkWell(
                  onTap: () => controller.logout(),
                  child: const Text(
                    'Logout',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
          body: FutureBuilder<List<Users>>(
            future: controller.fetchUsers(),
            builder: (context, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              return Obx(
                () => ListView.builder(
                  itemCount: controller.usersList.length,
                  itemBuilder: (context, index) {
                    final user = controller.usersList[index];
                    // Check if this is the current user
                    final isCurrentUser = user.id == controller.currentUserId.value;
                    return ListTile(
                      title: Text(
                        '${user.name} (${user.role})${isCurrentUser ? ' (You)' : ''}' ?? 'No Name',
                      ),
                      subtitle: Text(user.email ?? 'No Email'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () =>
                                controller.showEditDialog(context, user),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            // Disable delete button for current user
                            onPressed: isCurrentUser 
                              ? null  // This will gray out the button
                              : () async {
                                  final confirm = await controller
                                      .showConfirmationDialog(context);
                                  if (confirm) {
                                    await controller.deleteUser(user.id);
                                  }
                                },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}