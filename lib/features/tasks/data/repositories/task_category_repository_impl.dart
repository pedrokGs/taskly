import 'package:taskly/features/tasks/data/datasource/task_category_remote_datasource.dart';
import 'package:taskly/features/tasks/domain/entities/task_category_entity.dart';
import 'package:taskly/features/tasks/domain/exceptions/generic/data_source_exception.dart';
import 'package:taskly/features/tasks/domain/exceptions/generic/unknown_data_source_exception.dart';
import 'package:taskly/features/tasks/domain/repositories/task_category_repository.dart';

class TaskCategoryRepositoryImpl implements TaskCategoryRepository{
  final TaskCategoryRemoteDataSource remoteDataSource;

  TaskCategoryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<TaskCategoryEntity> addTaskCategory(TaskCategoryEntity taskCategoryEntity) {
    try{
          } on DataSourceException catch (e, stack){
      rethrow;
    } on UnknownDataSourceException catch (e, stack){
      rethrow;
    } on Exception catch(e){
      rethrow;
    }
  }

  @override
  Future<void> deleteTaskCategory(TaskCategoryEntity taskCategoryEntity) {
    // TODO: implement deleteTaskCategory
    throw UnimplementedError();
  }

  @override
  Future<List<TaskCategoryEntity>> getAllTaskCategories() {
    // TODO: implement getAllTaskCategories
    throw UnimplementedError();
  }

  @override
  Future<TaskCategoryEntity> getTaskCategoryById(String id) {
    // TODO: implement getTaskCategoryById
    throw UnimplementedError();
  }

  @override
  Future<TaskCategoryEntity> updateTaskCategory(TaskCategoryEntity taskCategoryEntity) {
    // TODO: implement updateTaskCategory
    throw UnimplementedError();
  }

}