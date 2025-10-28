import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskly/core/di/task_category_providers.dart';
import 'package:taskly/features/tasks/domain/entities/category/task_category_entity.dart';
import 'package:taskly/features/tasks/domain/exceptions/categories/task_category_already_exists_exception.dart';
import 'package:taskly/features/tasks/domain/usecases/category/create_task_category_use_case.dart';

class CreateTaskCategoryState{
  final String? errorMessage;
  final bool isLoading;
  final bool success;

  const CreateTaskCategoryState({this.errorMessage, this.isLoading = false, this.success = false});
}

class CreateTaskCategoryStateNotifier extends Notifier<CreateTaskCategoryState>{
  late final CreateTaskCategoryUseCase createTaskCategoryUseCase;

  @override
  CreateTaskCategoryState build() {
    createTaskCategoryUseCase = ref.watch(createTaskCategoryUseCaseProvider);
    return CreateTaskCategoryState();
  }

  Future<TaskCategoryEntity?> createTaskCategory({required TaskCategoryEntity taskCategoryEntity}) async{
    state = CreateTaskCategoryState(isLoading: true);
    try{
      // Envia com ID vazio e volta com ID.
      final result = await createTaskCategoryUseCase.call(taskCategoryEntity: taskCategoryEntity);
      state = CreateTaskCategoryState(isLoading: false, success: true);
      return result;
    } on TaskCategoryAlreadyExistsException{
      state = CreateTaskCategoryState(errorMessage: 'Categoria já existe',isLoading: false, success: false);
      return null;
    } catch(e){
      state = CreateTaskCategoryState(errorMessage: 'Erro desconhecido: $e', isLoading:  false, success:  false);
      return null;
    }
  }
}