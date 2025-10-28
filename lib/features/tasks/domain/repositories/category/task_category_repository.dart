import 'package:taskly/features/tasks/domain/entities/category/task_category_entity.dart';

abstract class TaskCategoryRepository{
  Future<List<TaskCategoryEntity>> getAllTaskCategories();
  Future<TaskCategoryEntity> getTaskCategoryById(String id);
  Future<TaskCategoryEntity> addTaskCategory(TaskCategoryEntity taskCategoryEntity);
  Future<TaskCategoryEntity> updateTaskCategory(TaskCategoryEntity taskCategoryEntity);
  Future<void> deleteTaskCategory(TaskCategoryEntity taskCategoryEntity);
}