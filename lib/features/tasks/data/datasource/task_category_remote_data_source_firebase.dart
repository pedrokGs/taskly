import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskly/features/auth/domain/repositories/auth_repository.dart';
import 'package:taskly/features/tasks/data/datasource/task_category_remote_datasource.dart';
import 'package:taskly/features/tasks/data/models/task_category_model.dart';

class TaskCategoryRemoteDataSourceFirebase implements TaskCategoryRemoteDataSource{
  // Injeção de dependência
  final FirebaseFirestore firestore;

  // Necessário para saber qual id do usuário
  final AuthRepository authRepository;

  TaskCategoryRemoteDataSourceFirebase({required this.firestore, required this.authRepository});

  // Adiciona documento no firebase em "users/taskCategories/{doc}
  @override
  Future<TaskCategoryModel> createTaskCategory(TaskCategoryModel taskCategory) async {
    try{
      await firestore.collection("users/${authRepository.authUser}/categories").add(taskCategory.toMap());
      return taskCategory;
    } catch(e){
      // TODO: Tratamento de excessão melhor
      throw Exception();
    }
  }

  @override
  Future<void> deleteTaskCategory(String id) async {
    try{
      await firestore.collection("users/${authRepository.authUser}/categories").doc(id).delete();
    } catch(e){
      // TODO: Tratamento de excessão melhor
      throw Exception();
    }
  }

  @override
  Future<TaskCategoryModel?> findTaskCategoryById(String id) async {
    try{
      final result = await firestore.collection("users/${authRepository.authUser}/categories").doc(id).get();
      if(result.exists && result.data() != null){
        final taskCategoryModel = TaskCategoryModel.fromMap(result.data()!);
        return taskCategoryModel;
      }
    } catch(e){
      // TODO: Tratamento de excessão melhor
      throw Exception();
    }
  }

  @override
  Future<List<TaskCategoryModel>?> getTaskCategories() {
    // TODO: implement getTaskCategories
    throw UnimplementedError();
  }

  @override
  Future<TaskCategoryModel> updateTaskCategory(TaskCategoryModel taskCategory) {
    // TODO: implement updateTaskCategory
    throw UnimplementedError();
  }
}