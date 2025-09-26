import 'package:taskly/features/tasks/domain/entities/icon_data_entity.dart';
import 'package:taskly/features/tasks/domain/entities/task_category_entity.dart';

import '../enums/task_difficulty_enum.dart';
import '../enums/task_type_enum.dart';

class TaskEntity {
  String id;
  String title;
  String? content;
  TaskDifficulty taskDifficulty;
  TaskType taskType;
  TaskCategoryEntity? category;
  IconDataEntity? iconDataEntity;
  DateTime createdAt;
  DateTime? completedAt;
  DateTime? dueDate;

  TaskEntity({
    required this.id,
    required this.title,
    this.content,
    required this.taskDifficulty,
    required this.taskType,
    this.category,
    this.iconDataEntity,
    required this.createdAt,
    this.completedAt,
    this.dueDate,
  });
}
