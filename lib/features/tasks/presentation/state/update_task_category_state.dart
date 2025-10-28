import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskly/core/di/task_category_providers.dart';
import 'package:taskly/features/tasks/domain/entities/category/task_category_entity.dart';
import 'package:taskly/features/tasks/domain/exceptions/tasks/task_not_found_exception.dart';
import 'package:taskly/features/tasks/domain/usecases/category/update_task_category_use_case.dart';

class UpdateTaskCategoryState{
  String? errorMessage;
  bool success;
  bool isLoading;

  UpdateTaskCategoryState({this.errorMessage, this.success = false, this.isLoading = false});
}

class UpdateTaskCategoryStateNotifier extends Notifier<UpdateTaskCategoryState>{
  late final UpdateTaskCategoryUseCase updateTaskCategoryUseCase;

  @override
  UpdateTaskCategoryState build() {
    updateTaskCategoryUseCase = ref.watch(updateTaskCategoryUseCaseProvider);
    return UpdateTaskCategoryState();
  }

  Future<TaskCategoryEntity?> updateTaskCategory(TaskCategoryEntity taskCategoryEntity) async{
    state = UpdateTaskCategoryState(isLoading: true);
    try{
      final result = await updateTaskCategoryUseCase.call(taskCategoryEntity);
      state = UpdateTaskCategoryState(success: true, isLoading: false);
      return result;
    } on TaskNotFoundException catch(e) {
      state = UpdateTaskCategoryState(errorMessage: 'Categoria não encontrada', success: false, isLoading: false);
      return null;
    } catch(e){
      state = UpdateTaskCategoryState(errorMessage: 'Erro desconhecido: $e', success: false, isLoading: false);
      return null;
    }
  }
}