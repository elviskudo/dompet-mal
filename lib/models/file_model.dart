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
