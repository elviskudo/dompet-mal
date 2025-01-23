import 'package:dompet_mal/app/modules/(admin)/bankAdmin/controllers/bank_admin_controller.dart';
import 'package:dompet_mal/app/modules/(admin)/categories/controllers/categories_controller.dart';
import 'package:dompet_mal/app/modules/(admin)/companies/controllers/companies_controller.dart';
import 'package:dompet_mal/app/modules/(admin)/list_user/controllers/list_user_controller.dart';
import 'package:dompet_mal/app/modules/(admin)/upload/controllers/upload_controller.dart';
import 'package:dompet_mal/app/modules/(admin)/charityAdmin/controllers/charity_admin_controller.dart';
import 'package:dompet_mal/models/BankModel.dart';
import 'package:dompet_mal/models/Category.dart';
import 'package:dompet_mal/models/CharityModel.dart';
import 'package:dompet_mal/models/Companies.dart';
import 'package:dompet_mal/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UploadDialog extends StatelessWidget {
  final CategoriesController categoriesController = Get.find();
  final ListUserController listUserController = Get.find();
  final CompaniesController companiesController = Get.find();
  final CharityAdminController charityAdminController = Get.find();
  final BankAdminController bankAdminController = Get.find();
  final UploadController uploadController = Get.put(UploadController());

  UploadDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16),
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Upload File',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),

            // Module Class Dropdown
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Module Type',
                border: OutlineInputBorder(),
              ),
              items: ['categories', 'users', 'companies', 'charities', 'bank']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value.capitalizeFirst!),
                );
              }).toList(),
              onChanged: (value) {
                uploadController.selectedModuleClass.value = value ?? '';
                uploadController.selectedModuleId.value = '';
              },
            ),

            const SizedBox(height: 16),

            // Module ID Dropdown (Categories)
            Obx(() {
              if (uploadController.selectedModuleClass.value == 'categories') {
                return DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Select Category',
                    border: OutlineInputBorder(),
                  ),
                  items: categoriesController.categories.map((Category data) {
                    // Check if a file exists for this category
                    bool hasFile = uploadController.fileList.any((file) =>
                        file.moduleClass == 'categories' &&
                        file.moduleId == data.id);

                    return DropdownMenuItem<String>(
                      value: data.id,
                      child: Text(
                          '${data.name ?? ''} ${hasFile ? '(Sudah)' : ''}'),
                    );
                  }).toList(),
                  onChanged: (value) {
                    var selectedCategory = categoriesController.categories
                        .firstWhere((data) => data.id == value);

                    // Check if a file exists for this category
                    bool hasFile = uploadController.fileList.any((file) =>
                        file.moduleClass == 'charities' &&
                        file.moduleId == selectedCategory.id);

                    if (hasFile) {
                      // Show error popup
                      Get.defaultDialog(
                        title: 'Error',
                        middleText: 'Category ini sudah diisi.',
                        textConfirm: 'OK',
                        onConfirm: () => Get.back(),
                      );
                    } else {
                      // Update selected module ID
                      uploadController.selectedModuleId.value = value ?? '';
                    }
                    uploadController.checkExistingFile();
                  },
                );
              }
              if (uploadController.selectedModuleClass.value == 'users') {
                return Column(
                  children: [
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Select Users',
                        border: OutlineInputBorder(),
                      ),
                      value: uploadController.selectedModuleId.value.isEmpty
                          ? null
                          : uploadController.selectedModuleId.value,
                      items: [
                        const DropdownMenuItem<String>(
                          value: 'all',
                          child: Text('All Users'),
                        ),
                        ...listUserController.usersList.map((Users data) {
                          // Check if a file exists for this user
                          bool hasFile = uploadController.fileList.any((file) =>
                              file.moduleClass == 'users' &&
                              file.moduleId == data.id);

                          return DropdownMenuItem<String>(
                            value: data.id,
                            child: Text(
                                '${data.name ?? ''} ${hasFile ? '(Sudah)' : ''}'),
                          );
                        }).toList(),
                      ],
                      onChanged: (value) {
                        uploadController.selectedModuleId.value = value ?? '';
                        if (value != 'all') {
                          uploadController.checkExistingFile();
                        }
                      },
                    ),
                  ],
                );
              }
              if (uploadController.selectedModuleClass.value == 'companies') {
                return DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Select Companies',
                    border: OutlineInputBorder(),
                  ),
                  items:
                      companiesController.companiesList.map((Companies data) {
                    // Check if a file exists for this company
                    bool hasFile = uploadController.fileList.any((file) =>
                        file.moduleClass == 'companies' &&
                        file.moduleId == data.id);

                    return DropdownMenuItem<String>(
                      value: data.id,
                      child: Text(
                          '${data.name ?? ''} ${hasFile ? '(Sudah)' : ''}'),
                    );
                  }).toList(),
                  onChanged: (value) {
                    var selectedCategory = categoriesController.categories
                        .firstWhere((data) => data.id == value);

                    // Check if a file exists for this category
                    bool hasFile = uploadController.fileList.any((file) =>
                        file.moduleClass == 'companies' &&
                        file.moduleId == selectedCategory.id);

                    if (hasFile) {
                      // Show error popup
                      Get.defaultDialog(
                        title: 'Error',
                        middleText: 'Category ini sudah diisi.',
                        textConfirm: 'OK',
                        onConfirm: () => Get.back(),
                      );
                    } else {
                      // Update selected module ID
                      uploadController.selectedModuleId.value = value ?? '';
                    }
                    uploadController.checkExistingFile();
                  },
                );
              }
              if (uploadController.selectedModuleClass.value == 'charities') {
                return DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Select Charities',
                    border: OutlineInputBorder(),
                  ),
                  items: charityAdminController.charities.map((Charity data) {
                    // Check if a file exists for this charity
                    bool hasFile = uploadController.fileList.any((file) =>
                        file.moduleClass == 'charities' &&
                        file.moduleId == data.id);

                    return DropdownMenuItem<String>(
                      value: data.id,
                      child: Text(
                          '${data.title ?? ''} ${hasFile ? '(Sudah)' : ''}'),
                    );
                  }).toList(),
                  onChanged: (value) {
                    var selectedCategory = categoriesController.categories
                        .firstWhere((data) => data.id == value);

                    // Check if a file exists for this category
                    bool hasFile = uploadController.fileList.any((file) =>
                        file.moduleClass == 'charities' &&
                        file.moduleId == selectedCategory.id);

                    if (hasFile) {
                      // Show error popup
                      Get.defaultDialog(
                        title: 'Error',
                        middleText: 'Category ini sudah diisi.',
                        textConfirm: 'OK',
                        onConfirm: () => Get.back(),
                      );
                    } else {
                      // Update selected module ID
                      uploadController.selectedModuleId.value = value ?? '';
                    }
                    uploadController.checkExistingFile();
                  },
                );
              }
              if (uploadController.selectedModuleClass.value == 'bank') {
                return DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Select Bank',
                    border: OutlineInputBorder(),
                  ),
                  items: bankAdminController.bankList.map((Bank data) {
                    // Check if a file exists for this bank
                    bool hasFile = uploadController.fileList.any((file) =>
                        file.moduleClass == 'bank' && file.moduleId == data.id);

                    return DropdownMenuItem<String>(
                      value: data.id,
                      child: Text(
                          '${data.name ?? ''} ${hasFile ? '(Sudah)' : ''}'),
                    );
                  }).toList(),
                  onChanged: (value) {
                    var selectedCategory = categoriesController.categories
                        .firstWhere((data) => data.id == value);

                    // Check if a file exists for this category
                    bool hasFile = uploadController.fileList.any((file) =>
                        file.moduleClass == 'bank' &&
                        file.moduleId == selectedCategory.id);

                    if (hasFile) {
                      // Show error popup
                      Get.defaultDialog(
                        title: 'Error',
                        middleText: 'Category ini sudah diisi.',
                        textConfirm: 'OK',
                        onConfirm: () => Get.back(),
                      );
                    } else {
                      // Update selected module ID
                      uploadController.selectedModuleId.value = value ?? '';
                    }
                    uploadController.checkExistingFile();
                  },
                );
              }

              return const SizedBox.shrink();
            }),

            const SizedBox(height: 20),

            // Image Preview
            Obx(() => uploadController.imageUrl.isNotEmpty
                ? Column(
                    children: [
                      Image.network(
                        uploadController.imageUrl.value,
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 8),
                      Text('File type: ${uploadController.fileType.value}'),
                    ],
                  )
                : const SizedBox.shrink()),

            const SizedBox(height: 20),

            // Choose File Button
            ElevatedButton.icon(
              icon: const Icon(Icons.image),
              label: const Text('Choose Image'),
              onPressed: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? image = await picker.pickImage(
                  source: ImageSource.gallery,
                );

                if (image != null) {
                  uploadController.selectedImage.value = image;
                  await uploadController.uploadFileToCloudinary(image);
                }
              },
            ),

            const SizedBox(height: 16),

            // Submit Button
            Obx(() => uploadController.isLoading.value
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: uploadController.imageUrl.isEmpty ||
                            uploadController.selectedModuleId.isEmpty
                        ? null
                        : () => uploadController.saveFileInfo(),
                    child: const Text('Submit'),
                  )),
          ],
        ),
      ),
    );
  }
}

class UploadDialogImage extends StatelessWidget {
  final UploadController uploadController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16),
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Edit Image',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),

            // Image Preview
            Obx(() => uploadController.imageUrl.isNotEmpty
                ? Column(
                    children: [
                      Image.network(
                        uploadController.imageUrl.value,
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 8),
                      Text('File type: ${uploadController.fileType.value}'),
                    ],
                  )
                : const SizedBox.shrink()),

            const SizedBox(height: 20),

            // Choose File Button
            ElevatedButton.icon(
              icon: const Icon(Icons.image),
              label: const Text('Choose Image'),
              onPressed: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? image = await picker.pickImage(
                  source: ImageSource.gallery,
                );

                if (image != null) {
                  uploadController.selectedImage.value = image;
                  await uploadController.uploadFileToCloudinary(image);
                }
              },
            ),

            const SizedBox(height: 16),

            // Submit Button
            Obx(() => uploadController.isLoading.value
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: uploadController.imageUrl.isEmpty
                        ? null
                        : () async {
                            await uploadController.saveFileInfo();
                            // Optionally, you can add an explicit refresh
                            await uploadController.fetchFiles();
                          },
                    child: const Text('Submit'),
                  )),
          ],
        ),
      ),
    );
  }
}
