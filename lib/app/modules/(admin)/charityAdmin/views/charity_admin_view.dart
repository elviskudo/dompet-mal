import 'package:dompet_mal/app/modules/(admin)/categories/controllers/categories_controller.dart';
import 'package:dompet_mal/models/Category.dart';
import 'package:dompet_mal/models/CharityModel.dart';
import 'package:dompet_mal/models/Companies.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/charity_admin_controller.dart';

class CharityAdminView extends GetView<CharityAdminController> {  
  const CharityAdminView({Key? key}) : super(key: key);  

  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      floatingActionButton: FloatingActionButton(onPressed: () {
        _showAddCharityBottomSheet(context);
      },
      child: Icon(Icons.add), 
      ),
      appBar: AppBar(  
      backgroundColor: Colors.white,

        title: const Text('Charities Management'),  
        centerTitle: true,  
        actions: [  
          // Refresh button  
          Obx(() => controller.isCharitiesLoading.value  
              ? const Padding(  
                  padding: EdgeInsets.all(8.0),  
                  child: SizedBox(  
                    width: 20,  
                    height: 20,  
                    child: CircularProgressIndicator(strokeWidth: 2),  
                  ),  
                )  
              : IconButton(  
                  icon: const Icon(Icons.refresh),  
                  onPressed: () => controller.fetchCharitiesWithContributors(),  
                ))  
        ],  
      ), 
      backgroundColor: Colors.white,

      body: Padding(  
        padding: const EdgeInsets.all(16.0),  
        child: Column(  
          crossAxisAlignment: CrossAxisAlignment.stretch,  
          children: [  
            // Add Charity Button with Loading State  
            // Obx(() => ElevatedButton(  
            //       onPressed: controller.isAddingCharity.value   
            //           ? null   
            //           : () => _showAddCharityBottomSheet(context),  
            //       child: controller.isAddingCharity.value  
            //           ? const SizedBox(  
            //               width: 20,  
            //               height: 20,  
            //               child: CircularProgressIndicator(strokeWidth: 2)  
            //             )  
            //           : const Text('Add Charity'),  
            //     )),  
            const SizedBox(height: 16),  
            
            // Charities List  
            Expanded(  
              child: Obx(() {  
                // Loading State  
                if (controller.isCharitiesLoading.value) {  
                  return const Center(child: CircularProgressIndicator());  
                }  

                // Error State  
                if (controller.errorMessage.isNotEmpty) {  
                  return Center(  
                    child: Column(  
                      mainAxisAlignment: MainAxisAlignment.center,  
                      children: [  
                        Text(  
                          controller.errorMessage.value,  
                          style: const TextStyle(color: Colors.red),  
                        ),  
                        const SizedBox(height: 16),  
                        ElevatedButton(  
                          onPressed: () => controller.fetchCharitiesWithContributors(),  
                          child: const Text('Retry'),  
                        )  
                      ],  
                    ),  
                  );  
                }  

                // Empty State  
                if (controller.charities.isEmpty) {  
                  return const Center(  
                    child: Text(  
                      'No charities found. Click "Add Charity" to create one.',  
                      textAlign: TextAlign.center,  
                    ),  
                  );  
                }  

                // Charities List  
                return ListView.builder(  
                  itemCount: controller.charities.length,  
                  itemBuilder: (context, index) {  
                    final charity = controller.charities[index];  
                    return Card(  
                      elevation: 4,  
                      margin: const EdgeInsets.symmetric(vertical: 8),  
                      child: ListTile(  
                        title: Text(charity.title!),  
                        subtitle: Text('Progress: ${charity.progress}%'),  
                        trailing: PopupMenuButton(  
                          onSelected: (value) {  
                            if (value == 'edit') {  
                              _showEditCharityBottomSheet(context, charity);  
                            } else if (value == 'delete') {  
                              _showDeleteConfirmDialog(context, charity.id!);  
                            }  
                          },  
                          itemBuilder: (context) => [  
                            const PopupMenuItem(  
                              value: 'edit',  
                              child: Text('Edit'),  
                            ),  
                            const PopupMenuItem(  
                              value: 'delete',  
                              child: Text('Delete'),  
                            ),  
                          ],  
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

  // Metode untuk menampilkan bottom sheet tambah charity  
// Metode untuk menampilkan bottom sheet tambah charity  
void _showAddCharityBottomSheet(BuildContext context) {
  controller.resetFormFields();
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add Charity',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildCharityForm(context, isEdit: false),
          ],
        ),
      );
    },
  );
}

// Metode untuk menampilkan bottom sheet edit charity  
void _showEditCharityBottomSheet(BuildContext context, Charity charity) {
  // controller.resetFormFields();
  controller.titleController.text = charity.title!;
  controller.descriptionController.text = charity.description!;
  controller.progressController.text = charity.progress.toString()!;
  controller.targetTotalController.text = charity.targetTotal.toString()!;
  controller.targetDateController.text = charity.targetDate!;
  controller.selectedCategoryId.value = charity.categoryId!;
  controller.selectedCompanyId.value = charity.companyId!;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Edit Charity',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildCharityForm(context, isEdit: true, charityId: charity.id),
          ],
        ),
      );
    },
  );
}

// Widget Form Charity
Widget _buildCharityForm(BuildContext context, {required bool isEdit, String? charityId}) {
  return Obx(() {
    return Column(
      children: [
        TextField(
          controller: controller.titleController,
          decoration: const InputDecoration(labelText: 'Title'),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: controller.descriptionController,
          decoration: const InputDecoration(labelText: 'Description'),
          maxLines: 3,
        ),
        const SizedBox(height: 16),
        TextField(
          controller: controller.progressController,
          decoration: const InputDecoration(labelText: 'Progress'),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16),
        // TextField(
        //   controller: controller.totalController,
        //   decoration: const InputDecoration(labelText: 'Total'),
        //   keyboardType: TextInputType.number,
        // ),
        // const SizedBox(height: 16),
        TextField(
          controller: controller.targetTotalController,
          decoration: const InputDecoration(labelText: 'Target Total'),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16),
        TextField(
  controller: controller.targetDateController,
  decoration: const InputDecoration(
    labelText: 'Target Date',
    suffixIcon: Icon(Icons.calendar_today), // Tambahkan ikon kalender
  ),
  keyboardType: TextInputType.datetime,
  readOnly: true, // Pastikan pengguna tidak mengetik manual
  onTap: () async {
    // Hilangkan fokus agar keyboard tidak muncul
    FocusScope.of(context).requestFocus(FocusNode());
    
    // Tampilkan DatePicker
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    // Jika pengguna memilih tanggal, format tanggalnya
    if (pickedDate != null) {
      controller.targetDateController.text =
          "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
    }
  },
),

        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          value: controller.selectedCategoryId.value.isEmpty
              ? null
              : controller.selectedCategoryId.value,
          onChanged: (value) => controller.selectedCategoryId.value = value ?? '',
          decoration: const InputDecoration(labelText: 'Category'),
          items: controller.categories
              .map((Category category) => DropdownMenuItem(
                    value: category.id,
                    child: Text(category.name.toString()),
                  ))
              .toList(),
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          value: controller.selectedCompanyId.value.isEmpty
              ? null
              : controller.selectedCompanyId.value,
          onChanged: (value) => controller.selectedCompanyId.value = value ?? '',
          decoration: const InputDecoration(labelText: 'Company'),
          items: controller.companies
              .map((Companies company) => DropdownMenuItem(
                    value: company.id,
                    child: Text(company.name.toString()),
                  ))
              .toList(),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: isEdit
              ? () => controller.updateCharity(charityId!)
              : () => controller.addCharity(),
          child: Obx(() => controller.isAddingCharity.value || controller.isUpdatingCharity.value
              ? const CircularProgressIndicator(strokeWidth: 2)
              : Text(isEdit ? 'Update Charity' : 'Add Charity')),
        ),
      ],
    );
  });
}

  // Metode untuk menampilkan dialog konfirmasi hapus  
  void _showDeleteConfirmDialog(BuildContext context, String charityId) {  
    showDialog(  
      context: context,  
      builder: (context) => AlertDialog(  
        title: const Text('Confirm Delete'),  
        content: const Text('Are you sure you want to delete this charity?'),  
        actions: [  
          TextButton(  
            onPressed: () => Navigator.of(context).pop(),  
            child: const Text('Cancel'),  
          ),  
          Obx(() => ElevatedButton(  
                onPressed: controller.isDeletingCharity.value  
                    ? null  
                    : () {  
                        controller.deleteCharity(charityId);  
                        Navigator.of(context).pop();  
                      },  
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),  
                child: controller.isDeletingCharity.value  
                    ? const SizedBox(  
                        width: 20,  
                        height: 20,  
                        child: CircularProgressIndicator(strokeWidth: 2),  
                      )  
                    : const Text('Delete'),  
              )),  
        ],  
      ),  
    );  
  }  
  
}