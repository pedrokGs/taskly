import 'package:taskly/features/tasks/domain/entities/category/task_category_entity.dart';
import 'package:taskly/features/tasks/domain/repositories/category/task_category_repository.dart';

class UpdateTaskCategoryUseCase{
  final TaskCategoryRepository taskCategoryRepository;

  UpdateTaskCategoryUseCase({required this.taskCategoryRepository});

  Future<TaskCategoryEntity> call(TaskCategoryEntity taskCategoryEntity) async{
    return await taskCategoryRepository.updateTaskCategory(taskCategoryEntity);
  }
}