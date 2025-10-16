
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:taskly/features/tasks/data/datasource/task_category_remote_datasource.dart';
import 'package:taskly/features/tasks/data/models/task_category_model.dart';
import 'package:taskly/features/tasks/data/repositories/task_category_repository_impl.dart';
import 'package:taskly/features/tasks/domain/repositories/task_category_repository.dart';

import 'task_category_repository_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<TaskCategoryRemoteDataSource>()
])
void main(){
  late final MockTaskCategoryRemoteDataSource mockTaskCategoryRemoteDataSource;
  late final TaskCategoryRepository taskCategoryRepository;

  setUp(() {
    mockTaskCategoryRemoteDataSource = MockTaskCategoryRemoteDataSource();
    taskCategoryRepository = TaskCategoryRepositoryImpl(remoteDataSource: mockTaskCategoryRemoteDataSource);
  },);

  final testCategory = TaskCategoryModel(name: '123', isDefault: false);

  group('addTaskCategory', () {
    test('addTaskCategory should return an TaskCategoryEntity with id', () async {
      when(mockTaskCategoryRemoteDataSource.createTaskCategory(testCategory)).thenAnswer((_) async => testCategory.copyWith(id: '1'),);

      final result = await taskCategoryRepository.addTaskCategory(testCategory);

    },);
  },);
}