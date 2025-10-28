import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskly/core/di/task_category_providers.dart';
import 'package:taskly/features/tasks/domain/entities/category/task_category_entity.dart';
import 'package:taskly/features/tasks/domain/exceptions/categories/task_category_not_found_exception.dart';
import 'package:taskly/features/tasks/domain/usecases/category/find_task_category_by_id_use_case.dart';

class FindTaskCategoryByIdState{
  String? errorMessage;
  bool isLoading;
  bool success;

  FindTaskCategoryByIdState({this.errorMessage, this.isLoading = false, this.success = false});
}

class FindTaskCategoryByIdStateNotifier extends Notifier<FindTaskCategoryByIdState>{
  late final FindTaskCategoryByIdUseCase findTaskCategoryByIdUseCase;

  @override
  FindTaskCategoryByIdState build() {
    findTaskCategoryByIdUseCase = ref.watch(findTaskCategoryByIdUseCaseProvider);
    return FindTaskCategoryByIdState();
  }

  Future<TaskCategoryEntity?> findTaskCategoryById({required String id}) async{
    state = FindTaskCategoryByIdState(isLoading: true);
    try{
      final result = await findTaskCategoryByIdUseCase.call(id: id);
      state = FindTaskCategoryByIdState(success: true, isLoading: false);
      return result;
    } on TaskCategoryNotFoundException {
      state = FindTaskCategoryByIdState(errorMessage: 'Task Category not found', success: false, isLoading: false);
      return null;
    } catch(e){
      state = FindTaskCategoryByIdState(errorMessage: 'Erro desconhecido: $e', success: false, isLoading: false);
      return null;
    }
  }
}