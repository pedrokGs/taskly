import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskly/features/tasks/domain/entities/category/task_category_entity.dart';

class TaskCategoryModel {
  String? id;
  String name;
  bool isDefault;
  String icon;
  int? color;
  Timestamp? createdAt;

  TaskCategoryModel({
    this.id,
    required this.name,
    required this.isDefault,
    required this.icon,
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
      icon: map['iconDataModel'],
    );
  }

  factory TaskCategoryModel.fromEntity(TaskCategoryEntity entity) {
    return TaskCategoryModel(
      id: entity.id,
      name: entity.name,
      isDefault: entity.isDefault,
      color: entity.color,
      createdAt: Timestamp.fromDate(entity.createdAt),
      icon: entity.icon
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'isDefault': isDefault,
      'color': color,
      'createdAt': createdAt,
      'iconDataModel': icon,
    };
  }

  TaskCategoryModel copyWith({
    String? id,
    String? name,
    bool? isDefault,
    String? icon,
    int? color,
    Timestamp? createdAt,
  }) {
    return TaskCategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      isDefault: isDefault ?? this.isDefault,
      icon: icon ?? this.icon,
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
      icon: icon,
    );
  }
}
