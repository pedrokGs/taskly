import 'package:taskly/features/tasks/data/models/task_category_model.dart';

abstract class TaskCategoryRemoteDataSource{
  Future<List<TaskCategoryModel>> getTaskCategories();
  Future<TaskCategoryModel> findTaskCategoryById(String id);
  Future<TaskCategoryModel> createTaskCategory(TaskCategoryModel taskCategory);
  Future<TaskCategoryModel> updateTaskCategory(TaskCategoryModel taskCategory); // Com CopyWith()
  Future<void> deleteTaskCategory(String id);
}