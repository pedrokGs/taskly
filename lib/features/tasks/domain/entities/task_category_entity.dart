import 'package:equatable/equatable.dart';

import 'icon_data_entity.dart';

class TaskCategoryEntity extends Equatable {
  final String id;
  final String name;
  final bool isDefault;
  final IconDataEntity? iconDataEntity;
  final int color;
  final DateTime createdAt;

  const TaskCategoryEntity({
    required this.id,
    required this.name,
    required this.isDefault,
    this.iconDataEntity,
    required this.color,
    required this.createdAt,
  });

  static final TaskCategoryEntity empty = TaskCategoryEntity(
    id: '',
    name: '',
    isDefault: false,
    color: 0,
    createdAt: DateTime.now(),
  );

  bool get isEmpty => this == TaskCategoryEntity.empty;

  TaskCategoryEntity copyWith({
    String? id,
    String? name,
    bool? isDefault,
    IconDataEntity? iconDataEntity,
    int? color,
    DateTime? createdAt,
  }) {
    return TaskCategoryEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      isDefault: isDefault ?? this.isDefault,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    isDefault,
    iconDataEntity,
    color,
    createdAt,
  ];
}
