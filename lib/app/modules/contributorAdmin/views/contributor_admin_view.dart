import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dompet_mal/app/modules/contributorAdmin/controllers/contributor_admin_controller.dart';
import 'package:dompet_mal/models/userModel.dart';

class ContributorAdminView extends GetView<ContributorAdminController> {
  const ContributorAdminView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contributor Management'),
        centerTitle: true,
        backgroundColor: Colors.blue[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Add New Contributor',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[700],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () => _showUserSelectionDialog(context),
                          icon: const Icon(Icons.person_add),
                          label: Text(
                            controller.selectedUserId.value.isEmpty
                                ? 'Select User'
                                : controller.users
                                    .firstWhere((user) => user.id == controller.selectedUserId.value)
                                    .name,
                            style: const TextStyle(fontSize: 16),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[100],
                            foregroundColor: Colors.blue[800],
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    )),
                    const SizedBox(height: 16),
                    Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () => _showCharitySelectionDialog(context),
                          icon: const Icon(Icons.heart_broken),
                          label: Text(
                            controller.selectedCharityId.value.isEmpty
                                ? 'Select Charity'
                                : controller.charities
                                    .firstWhere((charity) => charity.id == controller.selectedCharityId.value)
                                    .title,
                            style: const TextStyle(fontSize: 16),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[100],
                            foregroundColor: Colors.blue[800],
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    )),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: controller.addContributor,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue[700],
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Add Contributor',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                return ListView.builder(
                  itemCount: controller.contributors.length,
                  itemBuilder: (context, index) {
                    final contributor = controller.contributors[index];
                    final user = contributor.user;

                    return Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue[100],
                          child: Text(
                            user?.name?.substring(0, 1) ?? '?',
                            style: TextStyle(color: Colors.blue[800]),
                          ),
                        ),
                        title: Text(
                          user?.name ?? 'Unknown User',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(user?.email ?? ''),
                            Text(
                              'Added: ${contributor.createdAt.toString().split('.')[0]}',
                              style: TextStyle(color: Colors.grey[600], fontSize: 12),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => controller.deleteContributor(contributor.id),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  void _showUserSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Obx(() => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search Users',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onChanged: controller.filterUsers,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.filteredUsers.length,
                  itemBuilder: (context, index) {
                    final user = controller.filteredUsers[index];
                    return ListTile(
                      title: Text(user.name),
                      subtitle: Text(user.email),
                      onTap: () {
                        controller.selectedUserId.value = user.id;
                        Navigator.of(context).pop();
                      },
                    );
                  },
                ),
              ),
            ],
          )),
        );
      },
    );
  }

  void _showCharitySelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Obx(() => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search Charities',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onChanged: controller.filterCharities,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.filteredCharities.length,
                  itemBuilder: (context, index) {
                    final charity = controller.filteredCharities[index];
                    return ListTile(
                      title: Text(charity.title),
                      subtitle: Text(charity.description, maxLines: 1, overflow: TextOverflow.ellipsis),
                      onTap: () {
                        controller.selectedCharityId.value = charity.id;
                        Navigator.of(context).pop();
                      },
                    );
                  },
                ),
              ),
            ],
          )),
        );
      },
    );
  }
}