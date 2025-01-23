import 'package:dompet_mal/app/modules/bankAdmin/controllers/bank_admin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dompet_mal/models/BankModel.dart';

class BankAdminView extends GetView<BankAdminController> {
  const BankAdminView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bank Admin'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.errorMessage.value.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        }

        return ListView.builder(
          itemCount: controller.bankList.length,
          itemBuilder: (context, index) {
            final bank = controller.bankList[index];
            return ListTile(
              title: Text(bank.name),
              subtitle: Text('Account Number: ${bank.accountNumber}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      final nameController = TextEditingController(text: bank.name);
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Update Bank'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: nameController,
                                decoration: const InputDecoration(
                                  labelText: 'Bank Name',
                                ),
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                controller.updateBank(bank, nameController.text);
                                Navigator.of(context).pop();
                              },
                              child: const Text('Update'),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: const Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () => controller.deleteBank(bank),
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final nameController = TextEditingController();
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Create Bank'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Bank Name',
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    controller.createBank(nameController.text);
                    Navigator.of(context).pop();
                  },
                  child: const Text('Create'),
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}