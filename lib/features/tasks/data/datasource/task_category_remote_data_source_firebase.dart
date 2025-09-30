import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:taskly/features/tasks/data/datasource/task_category_remote_datasource.dart';
import 'package:taskly/features/tasks/data/models/task_category_model.dart';

class TaskCategoryRemoteDataSourceFirebase implements TaskCategoryRemoteDataSource{
  // Injeção de dependência
  final FirebaseFirestore firestore;

  TaskCategoryRemoteDataSourceFirebase({required this.firestore});

  // Adiciona documento no firebase em "users/taskCategories/{doc}
  @override
  Future<TaskCategoryModel> createTaskCategory(TaskCategoryModel taskCategory) {
    try{

    } catch(e){
      // TODO: Tratamento de erro
    }
  }

  @override
  Future<void> deleteTaskCategory(String id) {
    // TODO: implement deleteTaskCategory
    throw UnimplementedError();
  }

  @override
  Future<TaskCategoryModel> findTaskCategoryById(String id) {
    // TODO: implement findTaskCategoryById
    throw UnimplementedError();
  }

  @override
  Future<List<TaskCategoryModel>> getTaskCategories() {
    // TODO: implement getTaskCategories
    throw UnimplementedError();
  }

  @override
  Future<TaskCategoryModel> updateTaskCategory(TaskCategoryModel taskCategory) {
    // TODO: implement updateTaskCategory
    throw UnimplementedError();
  }
}