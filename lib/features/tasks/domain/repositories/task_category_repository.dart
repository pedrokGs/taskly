import 'package:taskly/features/tasks/domain/entities/task_category_entity.dart';

abstract class TaskCategoryRepository{
  Future<List<TaskCategoryEntity>> getAllTaskCategories();
  Future<TaskCategoryEntity> getTaskCategoryById(String id);
  Future<void> addTaskCategory(TaskCategoryEntity taskCategoryEntity);
  Future<void> updateTaskCategory(TaskCategoryEntity taskCategoryEntity);
  Future<void> deleteTaskCategory(TaskCategoryEntity taskCategoryEntity);
}