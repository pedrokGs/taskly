import 'package:taskly/features/tasks/data/datasource/category/task_category_remote_datasource.dart';
import 'package:taskly/features/tasks/data/models/category/task_category_model.dart';
import 'package:taskly/features/tasks/domain/entities/category/task_category_entity.dart';
import 'package:taskly/features/tasks/domain/exceptions/categories/task_category_not_found_exception.dart';
import 'package:taskly/features/tasks/domain/exceptions/generic/id_does_not_exist_exception.dart';
import 'package:taskly/features/tasks/domain/repositories/category/task_category_repository.dart';

class TaskCategoryRepositoryImpl implements TaskCategoryRepository {
  final TaskCategoryRemoteDataSource remoteDataSource;

  TaskCategoryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<TaskCategoryEntity> addTaskCategory(
    TaskCategoryEntity taskCategoryEntity,
  ) async {

    if(taskCategoryEntity.name.isEmpty){
      throw ArgumentError();
    }

    // categoryModel entra sem id e volta com id do datasource.
    final categoryModel = await remoteDataSource.createTaskCategory(
      TaskCategoryModel.fromEntity(taskCategoryEntity),
    );
    final categoryEntity = categoryModel.toEntity();
    return categoryEntity;
  }

  @override
  Future<void> deleteTaskCategory(TaskCategoryEntity taskCategoryEntity) async {
    if(taskCategoryEntity.id.isEmpty){
      throw IdDoesNotExistException(cause: 'id is null');
    }

    await remoteDataSource.deleteTaskCategory(taskCategoryEntity.id);
  }

  @override
  Future<List<TaskCategoryEntity>> getAllTaskCategories() async {
    final categories = await remoteDataSource.getTaskCategories();
    return categories.map((e) => e.toEntity()).toList();
  }

  @override
  Future<TaskCategoryEntity> getTaskCategoryById(String id) async {
    final result = await remoteDataSource.findTaskCategoryById(id);
    if (result == null) {
      throw TaskCategoryNotFoundException();
    }
    return result.toEntity();
  }

  @override
  Future<TaskCategoryEntity> updateTaskCategory(
    TaskCategoryEntity taskCategoryEntity,
  ) async {
    if(taskCategoryEntity.id.isEmpty){
      throw IdDoesNotExistException(cause: 'id is null');
    }

    final result = await remoteDataSource.updateTaskCategory(
      TaskCategoryModel.fromEntity(taskCategoryEntity),
    );

    return result.toEntity();
  }
}
