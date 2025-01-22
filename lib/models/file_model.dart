import 'package:uuid/uuid.dart';

class FileModel {
  String? id;
  String moduleClass;
  String moduleId;
  String fileName;
  String fileType;
  DateTime? createdAt;

  FileModel({
    this.id,
    required this.moduleClass,
    required this.moduleId,
    required this.fileName,
    required this.fileType,
    this.createdAt,
  });

  // Method to convert JSON to Dart object
  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(
      id: json['id'] as String?,
      moduleClass: json['module_class'] as String,
      moduleId: json['module_id'] as String,
      fileName: json['file_name'] as String,
      fileType: json['file_type'] as String,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }

  // Method to convert Dart object to JSON
  Map<String, dynamic> toJson() => {
        "id": id ?? const Uuid().v4(),
        "module_class": moduleClass,
        "module_id": moduleId,
        "file_name": fileName,
        "file_type": fileType,
        "created_at":
            createdAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
      };
}
