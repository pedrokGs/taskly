import 'package:taskly/features/tasks/domain/entities/category/task_category_entity.dart';
import 'package:taskly/features/tasks/domain/repositories/category/task_category_repository.dart';

class GetAllTaskCategoriesUseCase{
  final TaskCategoryRepository taskCategoryRepository;

  GetAllTaskCategoriesUseCase({required this.taskCategoryRepository});

  Future<List<TaskCategoryEntity>> call() async {
    return await taskCategoryRepository.getAllTaskCategories();
  }
}