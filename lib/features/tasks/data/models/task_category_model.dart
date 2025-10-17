import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskly/features/tasks/domain/entities/task_category_entity.dart';

import '../../domain/entities/icon_data_entity.dart';
import 'icon_data_model.dart';

class TaskCategoryModel {
  String? id;
  String name;
  bool isDefault;
  IconDataModel? iconDataModel;
  int? color;
  Timestamp? createdAt;

  TaskCategoryModel({
    this.id,
    required this.name,
    required this.isDefault,
    this.iconDataModel,
    this.color,
    Timestamp? createdAt,
  }) : createdAt = createdAt ?? Timestamp.now();

  factory TaskCategoryModel.fromMap(Map<String, dynamic> map) {
    return TaskCategoryModel(
      id: map["id"] ?? '',
      name: map['name'] ?? '',
      isDefault: map['isDefault'] ?? false,
      color: map['color'],
      createdAt: map['createdAt'],
      iconDataModel: map['iconDataModel'] != null
          ? IconDataModel.fromMap(map['iconDataModel'])
          : null,
    );
  }

  factory TaskCategoryModel.fromEntity(TaskCategoryEntity entity) {
    return TaskCategoryModel(
      id: entity.id,
      name: entity.name,
      isDefault: entity.isDefault,
      color: entity.color,
      createdAt: Timestamp.fromDate(entity.createdAt),
      iconDataModel: entity.iconDataEntity == null
          ? null
          : IconDataModel(
              iconName: entity.iconDataEntity!.iconName,
              iconCodePoint: entity.iconDataEntity!.iconCodePoint,
              iconFontFamily: entity.iconDataEntity!.iconFontFamily,
              iconFontPackage: entity.iconDataEntity!.iconFontPackage,
            ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'isDefault': isDefault,
      'color': color,
      'createdAt': createdAt,
      'iconDataModel': iconDataModel?.toMap(),
    };
  }

  TaskCategoryModel copyWith({
    String? id,
    String? name,
    bool? isDefault,
    IconDataModel? iconDataModel,
    int? color,
    Timestamp? createdAt,
  }) {
    return TaskCategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      isDefault: isDefault ?? this.isDefault,
      iconDataModel: iconDataModel ?? this.iconDataModel,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  TaskCategoryEntity toEntity() {
    if (id == null) {
      throw StateError("TaskCategoryModel inválido: id ou name ausente");
    }

    return TaskCategoryEntity(
      id: id!,
      name: name,
      isDefault: isDefault,
      color: color ?? 0xFF000000,
      createdAt: createdAt?.toDate() ?? DateTime.now(),
      iconDataEntity: iconDataModel == null
          ? null
          : IconDataEntity(
        iconName: iconDataModel!.iconName,
        iconCodePoint: iconDataModel!.iconCodePoint,
        iconFontFamily: iconDataModel!.iconFontFamily,
        iconFontPackage: iconDataModel!.iconFontPackage,
      ),
    );
  }
}
