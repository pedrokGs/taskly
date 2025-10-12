import 'package:cloud_firestore/cloud_firestore.dart';

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
}
