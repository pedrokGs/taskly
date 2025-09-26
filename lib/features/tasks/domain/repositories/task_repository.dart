import 'package:taskly/features/tasks/domain/entities/task_entity.dart';

abstract class TaskRepository{
  Future<List<TaskEntity>> getAllTasks();
  Future<TaskEntity> getTaskById(String id);
  Future<void> addTask(TaskEntity taskEntity);
  Future<void> updateTask(TaskEntity taskEntity);
  Future<void> deleteTask(String id);
}