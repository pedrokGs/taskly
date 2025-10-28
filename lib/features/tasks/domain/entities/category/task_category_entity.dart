import 'package:equatable/equatable.dart';

class TaskCategoryEntity extends Equatable {
  final String id;
  final String name;
  final bool isDefault;
  final String icon;
  final int color;
  final DateTime createdAt;

  const TaskCategoryEntity({
    required this.id,
    required this.name,
    required this.isDefault,
    required this.icon,
    required this.color,
    required this.createdAt,
  });

  static final TaskCategoryEntity empty = TaskCategoryEntity(
    id: '',
    name: '',
    isDefault: false,
    icon: '',
    color: 0,
    createdAt: DateTime.now(),
  );

  bool get isEmpty => this == TaskCategoryEntity.empty;

  TaskCategoryEntity copyWith({
    String? id,
    String? name,
    bool? isDefault,
    String? icon,
    int? color,
    DateTime? createdAt,
  }) {
    return TaskCategoryEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      isDefault: isDefault ?? this.isDefault,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    isDefault,
    icon,
    color,
    createdAt,
  ];
}
