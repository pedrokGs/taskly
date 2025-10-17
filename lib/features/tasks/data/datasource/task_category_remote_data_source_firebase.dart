import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskly/features/auth/domain/repositories/auth_repository.dart';
import 'package:taskly/features/tasks/data/datasource/task_category_remote_datasource.dart';
import 'package:taskly/features/tasks/data/models/task_category_model.dart';
import 'package:taskly/features/tasks/domain/exceptions/generic/data_source_exception.dart';
import 'package:taskly/features/tasks/domain/exceptions/generic/unknown_data_source_exception.dart';

class TaskCategoryRemoteDataSourceFirebase
    implements TaskCategoryRemoteDataSource {
  // Injeção de dependência
  final FirebaseFirestore firestore;

  // Necessário para saber qual id do usuário
  final AuthRepository authRepository;

  TaskCategoryRemoteDataSourceFirebase({
    required this.firestore,
    required this.authRepository,
  });

  // Adiciona documento no firebase em "users/{uid}/categories/{doc}
  @override
  Future<TaskCategoryModel> createTaskCategory(
    TaskCategoryModel taskCategory,
  ) async {
    final currentUser = authRepository.currentUser;
    if (currentUser == null) throw DataSourceException(cause: "Usuário não autenticado");
    try {
      final docRef = await firestore
          .collection("users/${currentUser.uid}/categories")
          .add(taskCategory.toMap());
      final docId = docRef.id;
      return taskCategory.copyWith(id: docId);
    } on FirebaseException catch (e, stack) {
      throw DataSourceException(
        cause: "Erro ao criar categoria no firebase: ${e.message}",
        stack: stack,
      );
    } on Exception catch (e, stack) {
      throw UnknownDataSourceException(
        cause: "Erro Inesperado: $e",
        stack: stack,
      );
    }
  }

  @override
  Future<void> deleteTaskCategory(String id) async {
    final currentUser = authRepository.currentUser;
    if (currentUser == null) {
      throw DataSourceException(cause: "Usuário não autenticado");
    }

    try {
      await firestore
          .collection("users/${currentUser.uid}/categories")
          .doc(id)
          .delete();
    } on FirebaseException catch (e, stack) {
      throw DataSourceException(
        cause: "Erro ao deletar categoria no firebase: ${e.message}",
        stack: stack,
      );
    } on Exception catch (e, stack) {
      throw UnknownDataSourceException(
        cause: "Erro Inesperado: $e",
        stack: stack,
      );
    }
  }

  @override
  Future<TaskCategoryModel?> findTaskCategoryById(String id) async {
    final currentUser = authRepository.currentUser;
    if (currentUser == null) {
      throw DataSourceException(cause: "Usuário não autenticado");
    }

    try {
      final result = await firestore
          .collection("users/${currentUser.uid}/categories")
          .doc(id)
          .get();
      if (result.exists && result.data() != null) {
        final taskCategoryModel = TaskCategoryModel.fromMap(result.data()!);
        return taskCategoryModel;
      }
    } on FirebaseException catch (e, stack) {
      throw DataSourceException(
        cause: "Erro ao buscar categoria no firebase: ${e.message}",
        stack: stack,
      );
    } on Exception catch (e, stack) {
      throw UnknownDataSourceException(
        cause: "Erro Inesperado: $e",
        stack: stack,
      );
    }
    return null;
  }

  @override
  Future<List<TaskCategoryModel>> getTaskCategories() async {
    final List<TaskCategoryModel> categoriesList = [];

    final currentUser = authRepository.currentUser;
    if (currentUser == null) {
      throw DataSourceException(cause: "Usuário não autenticado");
    }

    try {
      final result = await firestore
          .collection('users/${currentUser.uid}/categories')
          .get();
      final docs = result.docs;

      if (docs.isEmpty) return [];
      for (var doc in docs) {
        final categoryMap = doc.data();
        if (categoryMap.isNotEmpty) {
          categoriesList.add(TaskCategoryModel.fromMap(categoryMap));
        }
      }
      return categoriesList;
    } on FirebaseException catch (e, stack) {
      throw DataSourceException(
        cause: "Erro ao buscar categoria no firebase: ${e.message}",
        stack: stack,
      );
    } on Exception catch (e, stack) {
      throw UnknownDataSourceException(
        cause: "Erro Inesperado: $e",
        stack: stack,
      );
    }
  }

  // Usado com copyWith antes de chamar a função
  @override
  Future<TaskCategoryModel> updateTaskCategory(TaskCategoryModel taskCategory) async {
    final currentUser = authRepository.currentUser;
    if (currentUser == null) {
      throw DataSourceException(
        cause: "Usuário não autenticado");
    }

    try {
      await firestore
          .collection("users/${currentUser.uid}/categories")
          .doc(taskCategory.id).update(taskCategory.toMap());

      return taskCategory;
    } on FirebaseException catch (e, stack) {
      throw DataSourceException(
        cause: "Erro ao atualizar categoria no firebase: ${e.message}",
        stack: stack,
      );
    } on Exception catch (e, stack) {
      throw UnknownDataSourceException(
        cause: "Erro Inesperado: $e",
        stack: stack,
      );
    }
  }
}
