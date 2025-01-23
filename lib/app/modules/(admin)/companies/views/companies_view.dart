import 'package:dompet_mal/models/Companies.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/companies_controller.dart';

class CompaniesView extends StatelessWidget {
  final CompaniesController controller = Get.put(CompaniesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Companies'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddCompanyDialog(context),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.companiesList.isEmpty) {
          return const Center(child: Text('No companies found.'));
        }

        return ListView.builder(
          itemCount: controller.companiesList.length,
          itemBuilder: (context, index) {
            final company = controller.companiesList[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(company.logoUrl ?? ""),
              ),
              title: Text(company.name ?? ""),
              subtitle: Text(company.email ?? ""),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => _showEditCompanyDialog(context, company),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => controller.deleteCompany(company.id ?? ""),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }

  // Dialog untuk menambah company
  void _showAddCompanyDialog(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final logoUrlController = TextEditingController();
    final phoneNumberController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Company'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Name')),
                TextField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'Email')),
                TextField(
                    controller: logoUrlController,
                    decoration: const InputDecoration(labelText: 'Logo URL')),
                TextField(
                    controller: phoneNumberController,
                    decoration:
                        const InputDecoration(labelText: 'Phone Number')),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                controller.addCompany(Companies(
                  name: nameController.text,
                  logoUrl: logoUrlController.text,
                  email: emailController.text,
                  phoneNumber: phoneNumberController.text,
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                ));
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  // Dialog untuk mengedit company
  void _showEditCompanyDialog(BuildContext context, Companies company) {
    final nameController = TextEditingController(text: company.name);
    final emailController = TextEditingController(text: company.email);
    final logoUrlController = TextEditingController(text: company.logoUrl);
    final phoneNumberController =
        TextEditingController(text: company.phoneNumber);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Company'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Name')),
                TextField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'Email')),
                TextField(
                    controller: logoUrlController,
                    decoration: const InputDecoration(labelText: 'Logo URL')),
                TextField(
                    controller: phoneNumberController,
                    decoration:
                        const InputDecoration(labelText: 'Phone Number')),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                controller.updateCompany(
                  company.id ?? "",
                  Companies(
                    name: nameController.text,
                    logoUrl: logoUrlController.text,
                    email: emailController.text,
                    phoneNumber: phoneNumberController.text,
                    createdAt: company.createdAt,
                    updatedAt: DateTime.now(),
                  ),
                );
                Navigator.of(context).pop();
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }
}
