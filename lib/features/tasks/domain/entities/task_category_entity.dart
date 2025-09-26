import 'package:cloud_firestore/cloud_firestore.dart';

import 'icon_data_entity.dart';

class TaskCategoryEntity {
  String id;
  String name;
  bool isDefault;
  IconDataEntity? iconDataEntity;
  int color;
  Timestamp createdAt;

  TaskCategoryEntity({
    required this.id,
    required this.name,
    required this.isDefault,
    this.iconDataEntity,
    required this.color,
    required this.createdAt,
  });
}
