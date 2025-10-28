import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskly/features/tasks/data/models/icon_data_model.dart';
import 'package:taskly/features/tasks/data/models/category/task_category_model.dart';
import 'package:taskly/features/tasks/domain/enums/task_difficulty_enum.dart';
import 'package:taskly/features/tasks/domain/enums/task_type_enum.dart';

class TaskModel {
  String? id;
  String title;
  String? content;
  TaskDifficulty taskDifficulty;
  TaskType taskType;
  TaskCategoryModel? category;
  IconDataModel? iconDataModel;
  Timestamp? createdAt;
  Timestamp? completedAt;
  Timestamp? dueDate;

  TaskModel({
    this.id,
    required this.title,
    this.content,
    required this.taskDifficulty,
    required this.taskType,
    this.category,
    this.iconDataModel,
    Timestamp? createdAt,
    this.completedAt,
    this.dueDate,
  }) : createdAt = Timestamp.now();

  factory TaskModel.fromMap(Map<String, dynamic> map, String? id) {
    return TaskModel(
      id: id,
      title: map['title'] ?? '',
      content: map['content'],
      taskDifficulty: TaskDifficulty.values[map['taskDifficulty'] ?? 0],
      taskType: TaskType.values[map['taskType'] ?? 0],
      category: map['category'] != null
          ? TaskCategoryModel.fromMap(map['category'])
          : null,
      iconDataModel: map['iconDataModel'] != null
          ? IconDataModel.fromMap(map['iconDataModel'])
          : null,
      createdAt: map['createdAt'],
      completedAt: map['completedAt'],
      dueDate: map['dueDate'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'taskDifficulty': taskDifficulty.index,
      'taskType': taskType.index,
      'category': category?.toMap(),
      'iconDataModel': iconDataModel?.toMap(),
      'createdAt': createdAt,
      'completedAt': completedAt,
      'dueDate': dueDate,
    };
  }

  TaskModel copyWith({
    String? id,
    String? title,
    String? content,
    TaskDifficulty? taskDifficulty,
    TaskType? taskType,
    TaskCategoryModel? category,
    IconDataModel? iconDataModel,
    Timestamp? createdAt,
    Timestamp? completedAt,
    Timestamp? dueDate,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      taskDifficulty: taskDifficulty ?? this.taskDifficulty,
      taskType: taskType ?? this.taskType,
      category: category ?? this.category,
      iconDataModel: iconDataModel ?? this.iconDataModel,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      dueDate: dueDate ?? this.dueDate,
    );
  }
}
