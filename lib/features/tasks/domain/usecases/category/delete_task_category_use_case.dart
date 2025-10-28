import 'package:taskly/features/tasks/domain/entities/category/task_category_entity.dart';
import 'package:taskly/features/tasks/domain/repositories/category/task_category_repository.dart';

class DeleteTaskCategoryUseCase{
  final TaskCategoryRepository taskCategoryRepository;

  const DeleteTaskCategoryUseCase({required this.taskCategoryRepository});

  Future<void> call({required TaskCategoryEntity taskCategoryEntity}) async {
    return await taskCategoryRepository.deleteTaskCategory(taskCategoryEntity);
  }
}