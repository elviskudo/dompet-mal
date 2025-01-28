import 'package:dompet_mal/app/modules/(admin)/list_user/controllers/list_user_controller.dart';
import 'package:dompet_mal/app/modules/(admin)/transactions/controllers/transactions_controller.dart';
import 'package:dompet_mal/models/BankModel.dart';
import 'package:dompet_mal/models/CharityModel.dart';
import 'package:dompet_mal/models/TransactionModel.dart';
import 'package:dompet_mal/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class TransactionsView extends GetView<TransactionsController> {
  const TransactionsView({super.key});

  String formatToRupiah(double? amount) {
    if (amount == null) return 'Rp 0';
    final formatCurrency = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatCurrency.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTransactionDialog(context),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Transactions'),
        centerTitle: true,
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.transactions.length,
                itemBuilder: (context, index) {
                  final transaction = controller.transactions[index];
                  // Find related data
                  final user = controller.users.firstWhere(
                    (u) => u.id == transaction.userId,
                    orElse: () => Users(id: '', name: 'Unknown User'),
                  );
                  final bank = controller.banks.firstWhere(
                    (b) => b.id == transaction.bankId,
                    orElse: () => Bank(id: '', name: 'Unknown Bank'),
                  );
                  final charity = controller.charities.firstWhere(
                    (c) => c.id == transaction.charityId,
                    orElse: () => Charity(id: '', title: 'Unknown Charity'),
                  );

                  return Card(
                    color: Colors.white,
                    margin: const EdgeInsets.only(bottom: 16),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  transaction.transactionNumber ??
                                      'No Transaction Number',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(transaction.status),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  _getStatusText(transaction.status),
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          _buildInfoRow('User', user.name),
                          _buildInfoRow('Bank', bank.name),
                          _buildInfoRow('Charity', charity.title),
                          _buildInfoRow(
                            'Amount',
                            formatToRupiah(transaction.donationPrice),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon:
                                    const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () => _showTransactionDialog(
                                  context,
                                  transaction: transaction,
                                  id: transaction.id!,
                                ),
                              ),
                              IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () =>
                                    _showDeleteConfirmation(transaction.id!),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: GoogleFonts.poppins(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ),
          Text(': '),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(int? status) {
    switch (status) {
      case 1:
        return Colors.orange;
      case 2:
        return Colors.blue;
      case 3:
        return Colors.green;
      default:
        return Colors.white;
    }
  }

  void _showTransactionDialog(BuildContext context,
      {Transaction? transaction, String id = ''}) {
    final transactionNumberController =
        TextEditingController(text: transaction?.transactionNumber);
    final donationPriceController = TextEditingController(
        text: transaction?.donationPrice?.toStringAsFixed(2));
    final userIdController = TextEditingController(text: transaction?.userId);

    // Reactive variables for bank and charity selection
    final RxString selectedBankId = (transaction?.bankId ?? '').obs;
    final RxString selectedCharityId = (transaction?.charityId ?? '').obs;
    final RxString selectedUserId = (transaction?.userId ?? '').obs;
    final RxInt selectedStatus = (transaction?.status ?? 1).obs;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    Get.dialog(
      AlertDialog(
        title:
            Text(transaction == null ? 'Add Transaction' : 'Edit Transaction'),
        content: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: transactionNumberController,
                  decoration:
                      const InputDecoration(labelText: 'Transaction Number'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Transaction Number is required';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: donationPriceController,
                  decoration:
                      const InputDecoration(labelText: 'Donation Price'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Donation Price is required';
                    }
                    return null;
                  },
                ),
                // Bank Dropdown
                Obx(() => DropdownButtonFormField<int>(
                      value: selectedStatus.value,
                      decoration: const InputDecoration(labelText: 'Status'),
                      items: [
                        DropdownMenuItem(value: 1, child: Text('Pending')),
                        DropdownMenuItem(value: 2, child: Text('Processed')),
                        DropdownMenuItem(value: 3, child: Text('Completed')),
                      ],
                      onChanged: (value) => selectedStatus.value = value ?? 1,
                    )),
                Obx(() => DropdownButtonFormField(
                      value: selectedBankId.value.isNotEmpty
                          ? selectedBankId.value
                          : null,
                      decoration: const InputDecoration(labelText: 'Bank'),
                      items: controller.banks
                          .map<DropdownMenuItem<String>>((bank) {
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
                      onChanged: (value) =>
                          selectedCharityId.value = value ?? '',
                    )),

                Obx(() => DropdownButtonFormField<String>(
                      value: selectedUserId.value.isNotEmpty
                          ? selectedUserId.value
                          : null,
                      decoration: const InputDecoration(labelText: 'User'),
                      items: controller.users
                          .map<DropdownMenuItem<String>>((user) {
                        return DropdownMenuItem(
                          value: user.id,
                          child: Text(user.name),
                        );
                      }).toList(),
                      onChanged: (value) => selectedUserId.value = value ?? '',
                    )),
                // TextField(
                //   controller: userIdController,
                //   decoration: const InputDecoration(labelText: 'User ID'),
                // ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final newTransaction = Transaction(
                id: transaction?.id,
                transactionNumber: transactionNumberController.text,
                status: selectedStatus.value,
                donationPrice: double.tryParse(donationPriceController.text),
                bankId:
                    selectedBankId.value.isEmpty ? null : selectedBankId.value,
                charityId: selectedCharityId.value.isEmpty
                    ? null
                    : selectedCharityId.value,
                userId:
                    selectedUserId.value.isEmpty ? null : selectedUserId.value,
                updatedAt: DateTime.now(),
              );

              if (transaction == null) {
                controller.addTransaction(newTransaction);
                print(
                    'newTransaction ${newTransaction.id} ===== ${newTransaction.bankId}');
              } else {
                controller.updateTransaction(newTransaction, id);
                print(
                    'newTransaction ${newTransaction.id} ===== ${newTransaction.bankId}');
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
        title: Text('Delete Transaction'),
        content: Text('Are you sure you want to delete this transaction?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              controller.deleteTransaction(id);
              Get.back();
            },
            child: Text('Delete'),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
          ),
        ],
      ),
    );
  }

  String _getStatusText(int? status) {
    switch (status) {
      case 1:
        return 'Pending';
      case 2:
        return 'Processed';
      case 3:
        return 'Completed';
      default:
        return 'Unknown';
    }
  }
}
