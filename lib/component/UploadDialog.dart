import 'package:dompet_mal/app/modules/(admin)/categories/controllers/categories_controller.dart';
import 'package:dompet_mal/app/modules/(admin)/companies/controllers/companies_controller.dart';
import 'package:dompet_mal/app/modules/(admin)/list_user/controllers/list_user_controller.dart';
import 'package:dompet_mal/app/modules/(admin)/upload/controllers/upload_controller.dart';
import 'package:dompet_mal/app/modules/(admin)/charityAdmin/controllers/charity_admin_controller.dart';
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
              items: ['categories', 'users', 'companies', 'charities']
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
                    return DropdownMenuItem<String>(
                      value: data.id,
                      child: Text(data.name ?? ''),
                    );
                  }).toList(),
                  onChanged: (value) {
                    uploadController.selectedModuleId.value = value ?? '';
                  },
                );
              }
              if (uploadController.selectedModuleClass.value == 'users') {
                return DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Select Users',
                    border: OutlineInputBorder(),
                  ),
                  items: listUserController.usersList.map((Users data) {
                    return DropdownMenuItem<String>(
                      value: data.id,
                      child: Text(data.name ?? ''),
                    );
                  }).toList(),
                  onChanged: (value) {
                    uploadController.selectedModuleId.value = value ?? '';
                    uploadController.checkExistingFile();
                  },
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
                    return DropdownMenuItem<String>(
                      value: data.id,
                      child: Text(data.name ?? ''),
                    );
                  }).toList(),
                  onChanged: (value) {
                    uploadController.selectedModuleId.value = value ?? '';
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
                    return DropdownMenuItem<String>(
                      value: data.id,
                      child: Text(data.title ?? ''),
                    );
                  }).toList(),
                  onChanged: (value) {
                    uploadController.selectedModuleId.value = value ?? '';
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
