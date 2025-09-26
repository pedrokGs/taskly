import 'package:taskly/features/tasks/domain/entities/task_entity.dart';
import 'package:taskly/features/tasks/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository{
  @override
  Future<void> addTask(TaskEntity taskEntity) {
    // TODO: implement addTask
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTask(String id) {
    // TODO: implement deleteTask
    throw UnimplementedError();
  }

  @override
  Future<List<TaskEntity>> getAllTasks() {
    // TODO: implement getAllTasks
    throw UnimplementedError();
  }

  @override
  Future<TaskEntity> getTaskById(String id) {
    // TODO: implement getTaskById
    throw UnimplementedError();
  }

  @override
  Future<void> updateTask(TaskEntity taskEntity) {
    // TODO: implement updateTask
    throw UnimplementedError();
  }
  
}