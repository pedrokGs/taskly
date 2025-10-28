import 'package:taskly/features/tasks/domain/entities/category/task_category_entity.dart';
import 'package:taskly/features/tasks/domain/repositories/category/task_category_repository.dart';

class CreateTaskCategoryUseCase {
  final TaskCategoryRepository categoryRepository;

  const CreateTaskCategoryUseCase({required this.categoryRepository});

  Future<TaskCategoryEntity> call({ required TaskCategoryEntity taskCategoryEntity}) async{
    return await categoryRepository.addTaskCategory(taskCategoryEntity);
  }
}