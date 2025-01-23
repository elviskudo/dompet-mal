import 'package:dompet_mal/app/modules/(admin)/transactions/controllers/transactions_controller.dart';
import 'package:dompet_mal/models/BankModel.dart';
import 'package:dompet_mal/models/CharityModel.dart';
import 'package:dompet_mal/models/TransactionModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionsView extends GetView<TransactionsController> {
  const TransactionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTransactionDialog(context),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Transactions'),
        centerTitle: true,
        actions: [],
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: controller.transactions.length,
                itemBuilder: (context, index) {
                  final transaction = controller.transactions[index];
                  return ListTile(
                    title: Text(transaction.transactionNumber ??
                        'No Transaction Number'),
                    subtitle: Text(
                        'Donation: \$${transaction.donationPrice?.toStringAsFixed(2) ?? '0.00'}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          tooltip: 'edit',
                          onPressed: () => _showTransactionDialog(context,
                              transaction: transaction),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          tooltip: 'delete',
                          onPressed: () =>
                              _showDeleteConfirmation(transaction.id!),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }

  void _showTransactionDialog(BuildContext context,
      {Transaction? transaction}) {
    final transactionNumberController =
        TextEditingController(text: transaction?.transactionNumber);
    final donationPriceController = TextEditingController(
        text: transaction?.donationPrice?.toStringAsFixed(2));
    final userIdController = TextEditingController(text: transaction?.userId);

    // Reactive variables for bank and charity selection
    final RxString selectedBankId = (transaction?.bankId ?? '').obs;
    final RxString selectedCharityId = (transaction?.charityId ?? '').obs;

    Get.dialog(
      AlertDialog(
        title:
            Text(transaction == null ? 'Add Transaction' : 'Edit Transaction'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: transactionNumberController,
                decoration:
                    const InputDecoration(labelText: 'Transaction Number'),
              ),
              TextField(
                controller: donationPriceController,
                decoration: const InputDecoration(labelText: 'Donation Price'),
                keyboardType: TextInputType.number,
              ),
              // Bank Dropdown
              Obx(() => DropdownButtonFormField(
                    value: selectedBankId.value.isNotEmpty
                        ? selectedBankId.value
                        : null,
                    decoration: const InputDecoration(labelText: 'Bank'),
                    items:
                        controller.banks.map<DropdownMenuItem<String>>((bank) {
                      return DropdownMenuItem(
                        value: bank.id,
                        child: Text(bank.name),
                      );
                    }).toList(),
                    onChanged: (value) => selectedBankId.value = value ?? '',
                  )),
              // Charity Dropdown
              Obx(() => DropdownButtonFormField<String>(
                    value: selectedCharityId.value.isNotEmpty
                        ? selectedCharityId.value
                        : null,
                    decoration: const InputDecoration(labelText: 'Charity'),
                    items: controller.charities
                        .map<DropdownMenuItem<String>>((charity) {
                      return DropdownMenuItem(
                        value: charity.id,
                        child: Text(charity.title),
                      );
                    }).toList(),
                    onChanged: (value) => selectedCharityId.value = value ?? '',
                  )),
              TextField(
                controller: userIdController,
                decoration: const InputDecoration(labelText: 'User ID'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final newTransaction = Transaction(
                id: transaction?.id,
                transactionNumber: transactionNumberController.text,
                donationPrice: double.tryParse(donationPriceController.text),
                bankId: selectedBankId.value,
                charityId: selectedCharityId.value,
                userId: userIdController.text,
                updatedAt: DateTime.now(),
              );

              if (transaction == null) {
                controller.addTransaction(newTransaction);
              } else {
                controller.updateTransaction(newTransaction);
              }
              Get.back();
            },
            child: Text(transaction == null ? 'Add' : 'Update'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(String id) {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete Transaction'),
        content:
            const Text('Are you sure you want to delete this transaction?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              controller.deleteTransaction(id);
              Get.back();
            },
            child: const Text('Delete'),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
          ),
        ],
      ),
    );
  }
}
