import 'package:taskly/features/tasks/domain/entities/category/task_category_entity.dart';
import 'package:taskly/features/tasks/domain/repositories/category/task_category_repository.dart';

class FindTaskCategoryByIdUseCase{
  final TaskCategoryRepository taskCategoryRepository;

  const FindTaskCategoryByIdUseCase({required this.taskCategoryRepository});

  Future<TaskCategoryEntity> call({required String id}) async{
    return await taskCategoryRepository.getTaskCategoryById(id);
  }
}