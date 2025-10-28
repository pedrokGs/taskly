import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskly/core/di/auth_providers.dart';
import 'package:taskly/features/tasks/data/datasource/category/task_category_remote_data_source_firebase.dart';
import 'package:taskly/features/tasks/data/datasource/category/task_category_remote_datasource.dart';
import 'package:taskly/features/tasks/data/repositories/category/task_category_repository_impl.dart';
import 'package:taskly/features/tasks/domain/repositories/category/task_category_repository.dart';
import 'package:taskly/features/tasks/domain/usecases/category/create_task_category_use_case.dart';
import 'package:taskly/features/tasks/domain/usecases/category/delete_task_category_use_case.dart';
import 'package:taskly/features/tasks/domain/usecases/category/find_task_category_by_id_use_case.dart';
import 'package:taskly/features/tasks/domain/usecases/category/get_all_task_categories_use_case.dart';
import 'package:taskly/features/tasks/domain/usecases/category/update_task_category_use_case.dart';
import 'package:taskly/features/tasks/presentation/state/create_task_category_state.dart';
import 'package:taskly/features/tasks/presentation/state/delete_task_category_state.dart';
import 'package:taskly/features/tasks/presentation/state/find_task_category_by_id_state.dart';
import 'package:taskly/features/tasks/presentation/state/get_all_task_categories_state.dart';
import 'package:taskly/features/tasks/presentation/state/update_task_category_state.dart';

// Data Layer
final firebaseFirestoreProvider = Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance,);
final taskCategoryRemoteDataSourceProvider = Provider<TaskCategoryRemoteDataSource>((ref) => TaskCategoryRemoteDataSourceFirebase(firestore: ref.watch(firebaseFirestoreProvider), authRepository: ref.watch(authRepositoryProvider)));
final taskCategoryRepositoryProvider = Provider<TaskCategoryRepository>((ref) => TaskCategoryRepositoryImpl(remoteDataSource: ref.watch(taskCategoryRemoteDataSourceProvider)));

// Use Cases
final createTaskCategoryUseCaseProvider = Provider<CreateTaskCategoryUseCase>((ref) => CreateTaskCategoryUseCase(categoryRepository: ref.watch(taskCategoryRepositoryProvider)));
final deleteTaskCategoryUseCaseProvider = Provider<DeleteTaskCategoryUseCase>((ref) => DeleteTaskCategoryUseCase(taskCategoryRepository: ref.watch(taskCategoryRepositoryProvider)));
final findTaskCategoryByIdUseCaseProvider = Provider<FindTaskCategoryByIdUseCase>((ref) => FindTaskCategoryByIdUseCase(taskCategoryRepository: ref.watch(taskCategoryRepositoryProvider)));
final getAllTasksCategoriesUseCaseProvider = Provider<GetAllTaskCategoriesUseCase>((ref) => GetAllTaskCategoriesUseCase(taskCategoryRepository: ref.watch(taskCategoryRepositoryProvider)));
final updateTaskCategoryUseCaseProvider = Provider<UpdateTaskCategoryUseCase>((ref) => UpdateTaskCategoryUseCase(taskCategoryRepository: ref.watch(taskCategoryRepositoryProvider)));

// Presentation
final createTaskCategoryStateNotifierProvider = NotifierProvider<CreateTaskCategoryStateNotifier, CreateTaskCategoryState>(() => CreateTaskCategoryStateNotifier());
final deleteTaskCategoryStateNotifierProvider = NotifierProvider<DeleteTaskCategoryStateNotifier, DeleteTaskCategoryState>(() => DeleteTaskCategoryStateNotifier());
final updateTaskCategoryStateNotifierProvider = NotifierProvider<UpdateTaskCategoryStateNotifier, UpdateTaskCategoryState>(() => UpdateTaskCategoryStateNotifier(),);
final findTaskCategoryByIdStateNotifierProvider = NotifierProvider<FindTaskCategoryByIdStateNotifier, FindTaskCategoryByIdState>(() => FindTaskCategoryByIdStateNotifier(),);
final getAllTaskCategoriesStateNotifierProvider = NotifierProvider<GetAllTaskCategoriesStateNotifier, GetAllTaskCategoriesState>(() => GetAllTaskCategoriesStateNotifier(),);