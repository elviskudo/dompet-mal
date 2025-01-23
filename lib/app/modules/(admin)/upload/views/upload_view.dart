import 'package:dompet_mal/component/UploadDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/upload_controller.dart';

class UploadView extends GetView<UploadController> {
  const UploadView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text('UploadView'),
                Gap(8),
                IconButton(
                    icon: const Icon(Icons.upload),
                    tooltip: 'Upload Foto',
                    onPressed: () => controller.showUploadDialog(context)),
                // Edit Mode Toggle
                IconButton(
                  icon: Obx(() => Icon(Icons.edit,
                      color: controller.isEditMode.value ? Colors.blue : null)),
                  tooltip: 'Edit Mode',
                  onPressed: () => controller.toggleEditMode(),
                ),
                // Delete Mode Toggle
                IconButton(
                  icon: Obx(() => Icon(Icons.delete,
                      color:
                          controller.isDeleteMode.value ? Colors.red : null)),
                  tooltip: 'Delete Mode',
                  onPressed: () => controller.toggleDeleteMode(),
                ),
                // Delete Confirm Button (visible only in delete mode)
                Obx(() => controller.isDeleteMode.value &&
                        controller.selectedFilesForDeletion.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.check, color: Colors.green),
                        onPressed: () => controller.deleteSelectedFiles(),
                      )
                    : const SizedBox.shrink()),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(() {
                return DropdownButton(
                  value: controller.selectedModuleClass.value.isNotEmpty
                      ? controller.selectedModuleClass.value
                      : 'all',
                  onChanged: (newValue) {
                    if (newValue != null) {
                      controller.selectedModuleClass.value = newValue;
                      controller.filterFiles(); // Apply filter
                    }
                  },
                  items: controller.moduleClasses
                      .map((moduleClass) => DropdownMenuItem(
                            value: moduleClass,
                            child: Text(moduleClass),
                          ))
                      .toList(),
                );
              }),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.filteredFileList.isEmpty) {
                return const Center(child: Text('No files available'));
              }
              return ListView.builder(
                itemCount: controller.filteredFileList.length,
                itemBuilder: (context, index) {
                  final file = controller.filteredFileList[index];
                  return Obx(() => ListTile(
                        leading: controller.isDeleteMode.value
                            ? Checkbox(
                                value: controller.selectedFilesForDeletion
                                    .contains(file.id),
                                onChanged: (bool? value) {
                                  controller.toggleFileSelection(file.id ?? '');
                                },
                              )
                            : (controller.isEditMode.value
                                ? IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () => controller.editFile(file),
                                  )
                                : null),
                        title: Text(
                            'Module Name: ${file.moduleName} (${file.moduleClass})'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Type: ${file.fileType}'),
                          ],
                        ),
                        trailing: controller.isDeleteMode.value
                            ? null // Remove trailing widget in delete mode
                            : Container(
                                width: 24,
                                height: 24,
                                child: Image.network(file.fileName ?? '')),
                      ),);
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
