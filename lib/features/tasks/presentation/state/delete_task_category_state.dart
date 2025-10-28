import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskly/core/di/task_category_providers.dart';
import 'package:taskly/features/tasks/domain/entities/category/task_category_entity.dart';
import 'package:taskly/features/tasks/domain/exceptions/categories/task_category_cannot_be_deleted_exception.dart';
import 'package:taskly/features/tasks/domain/exceptions/categories/task_category_not_found_exception.dart';
import 'package:taskly/features/tasks/domain/usecases/category/delete_task_category_use_case.dart';

class DeleteTaskCategoryState{
  String? errorMessage;
  bool isLoading;
  bool success;

  DeleteTaskCategoryState({this.errorMessage, this.isLoading = false, this.success = false});
}

class DeleteTaskCategoryStateNotifier extends Notifier<DeleteTaskCategoryState>{
  late final DeleteTaskCategoryUseCase deleteTaskCategoryUseCase;

  @override
  DeleteTaskCategoryState build() {
    deleteTaskCategoryUseCase = ref.watch(deleteTaskCategoryUseCaseProvider);
    return DeleteTaskCategoryState();
  }

  Future<void> deleteTaskCategory({required TaskCategoryEntity taskCategoryEntity}) async {
    state = DeleteTaskCategoryState(isLoading: true);
    try{
      await deleteTaskCategoryUseCase.call(taskCategoryEntity: taskCategoryEntity);
      state = DeleteTaskCategoryState(success: true, isLoading: false);
    } on TaskCategoryCannotBeDeletedException{
      state = DeleteTaskCategoryState(errorMessage: 'Categoria não pode ser deletada', isLoading:  false, success:  false);
    } on TaskCategoryNotFoundException{
      state = DeleteTaskCategoryState(errorMessage: 'Categoria não encontrada', isLoading: false, success: false);
    } catch(e){
      state = DeleteTaskCategoryState(errorMessage: 'Erro desconhecido: $e', isLoading: false, success: false);
    }
  }
}