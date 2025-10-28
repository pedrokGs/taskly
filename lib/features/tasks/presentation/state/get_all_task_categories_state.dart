import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskly/core/di/task_category_providers.dart';
import 'package:taskly/features/tasks/domain/entities/category/task_category_entity.dart';
import 'package:taskly/features/tasks/domain/usecases/category/get_all_task_categories_use_case.dart';

class GetAllTaskCategoriesState{
  String? errorMessage;
  bool isLoading;
  bool success;

  GetAllTaskCategoriesState({this.errorMessage, this.isLoading = false, this.success = false});
}

class GetAllTaskCategoriesStateNotifier extends Notifier<GetAllTaskCategoriesState>{
  late final GetAllTaskCategoriesUseCase getAllTaskCategoriesUseCase;

  @override
  GetAllTaskCategoriesState build() {
    getAllTaskCategoriesUseCase = ref.watch(getAllTasksCategoriesUseCaseProvider);
    return GetAllTaskCategoriesState();
  }

  Future<List<TaskCategoryEntity?>> getAllTaskCategories () async{
    state = GetAllTaskCategoriesState(isLoading: true);
    try{
      final results = getAllTaskCategoriesUseCase.call();
      state = GetAllTaskCategoriesState(success: true, isLoading: false);
      return results;
    } catch(e){
      state = GetAllTaskCategoriesState(success: false, errorMessage: 'erro desconhecido: $e', isLoading: false);
      return [];
    }
  }
}