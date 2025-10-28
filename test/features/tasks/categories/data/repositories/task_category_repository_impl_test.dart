import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:taskly/features/tasks/data/datasource/category/task_category_remote_datasource.dart';
import 'package:taskly/features/tasks/data/models/icon_data_model.dart';
import 'package:taskly/features/tasks/data/models/category/task_category_model.dart';
import 'package:taskly/features/tasks/data/repositories/category/task_category_repository_impl.dart';
import 'package:taskly/features/tasks/domain/entities/category/task_category_entity.dart';
import 'package:taskly/features/tasks/domain/exceptions/categories/task_category_already_exists_exception.dart';
import 'package:taskly/features/tasks/domain/exceptions/categories/task_category_cannot_be_deleted_exception.dart';
import 'package:taskly/features/tasks/domain/exceptions/categories/task_category_not_found_exception.dart';
import 'package:taskly/features/tasks/domain/exceptions/generic/data_source_exception.dart';
import 'package:taskly/features/tasks/domain/exceptions/generic/unknown_data_source_exception.dart';
import 'package:taskly/features/tasks/domain/repositories/category/task_category_repository.dart';

import 'task_category_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<TaskCategoryRemoteDataSource>()])
void main() {
  late MockTaskCategoryRemoteDataSource mockTaskCategoryRemoteDataSource;
  late TaskCategoryRepository taskCategoryRepository;

  setUp(() {
    mockTaskCategoryRemoteDataSource = MockTaskCategoryRemoteDataSource();
    taskCategoryRepository = TaskCategoryRepositoryImpl(
      remoteDataSource: mockTaskCategoryRemoteDataSource,
    );
  });

  final taskCategoryModel = TaskCategoryModel(
    id: '',
    name: 'any',
    isDefault: false,
    color: 0xFFFFFFFF,
    createdAt: Timestamp.fromDate(DateTime.utc(2000)),
    iconDataModel: IconDataModel(
      iconName: 'teste',
      iconCodePoint: 100,
      iconFontFamily: 'teste',
      iconFontPackage: 'teste',
    ),
  );

  final taskCategoryModel1 = TaskCategoryModel(
    id: '1',
    name: 'Work',
    isDefault: true,
    color: 0xFF0000FF, // Azul
    createdAt: Timestamp.fromDate(DateTime.utc(2023, 1, 1)),
    iconDataModel: IconDataModel(
      iconName: 'work_icon',
      iconCodePoint: 0xe001,
      iconFontFamily: 'MaterialIcons',
      iconFontPackage: 'material_icons',
    ),
  );

  final taskCategoryModel2 = TaskCategoryModel(
    id: '2',
    name: 'Personal',
    isDefault: false,
    color: 0xFFFF0000, // Vermelho
    createdAt: Timestamp.fromDate(DateTime.utc(2023, 2, 1)),
    iconDataModel: IconDataModel(
      iconName: 'personal_icon',
      iconCodePoint: 0xe002,
      iconFontFamily: 'MaterialIcons',
      iconFontPackage: 'material_icons',
    ),
  );

  final taskCategoryModel3 = TaskCategoryModel(
    id: '3',
    name: 'Shopping',
    isDefault: false,
    color: 0xFF00FF00, // Verde
    createdAt: Timestamp.fromDate(DateTime.utc(2023, 3, 1)),
    iconDataModel: IconDataModel(
      iconName: 'shopping_icon',
      iconCodePoint: 0xe003,
      iconFontFamily: 'MaterialIcons',
      iconFontPackage: 'material_icons',
    ),
  );

  group('addTaskCategory', () {
    test(
      'addTaskCategory should return an TaskCategoryEntity with id',
      () async {
        when(
          mockTaskCategoryRemoteDataSource.createTaskCategory(any),
        ).thenAnswer((_) async => taskCategoryModel.copyWith(id: '1'));

        final resultedEntity = await taskCategoryRepository.addTaskCategory(
          taskCategoryModel.toEntity(),
        );
        final expectedEntity = taskCategoryModel.copyWith(id: '1').toEntity();

        expect(resultedEntity, equals(expectedEntity));
        verify(
          mockTaskCategoryRemoteDataSource.createTaskCategory(any),
        ).called(1);
      },
    );

    test('should throw an TaskCategoryAlreadyExistsException when trying to add a category with same name', () async {
      when(mockTaskCategoryRemoteDataSource.createTaskCategory(any)).thenThrow(TaskCategoryAlreadyExistsException());

      final call = taskCategoryRepository.addTaskCategory;

      expect(call(taskCategoryModel.toEntity()), throwsA(isA<TaskCategoryAlreadyExistsException>()));
    },);

    test(
      'addTaskCategory should throw DataSourceException when failing with Known Error',
      () async {
        when(
          mockTaskCategoryRemoteDataSource.createTaskCategory(any),
        ).thenThrow(DataSourceException(cause: 'erro'));

        final call = taskCategoryRepository.addTaskCategory;

        expect(
          () => call(taskCategoryModel.toEntity()),
          throwsA(isA<DataSourceException>()),
        );
      },
    );

    test(
      'addTaskCategory should throw UnknownDataSourceException when failling with unkonwn Error',
      () async {
        when(
          mockTaskCategoryRemoteDataSource.createTaskCategory(any),
        ).thenThrow(UnknownDataSourceException(cause: 'erro'));

        final call = taskCategoryRepository.addTaskCategory;

        expect(
          () => call(taskCategoryModel.toEntity()),
          throwsA(isA<UnknownDataSourceException>()),
        );
      },
    );

    test(
      'addTaskCategory should throw ArgumentError when name is empty',
      () async {
        final invalidCategory = taskCategoryModel.copyWith(name: '');

        final call = taskCategoryRepository.addTaskCategory;

        expect(
          () => call(invalidCategory.toEntity()),
          throwsA(isA<ArgumentError>()),
        );
        verifyNever(mockTaskCategoryRemoteDataSource.createTaskCategory(any));
      },
    );
  });

  group('getAllTaskCategories', () {
    test(
      'Should return all TaskCategories from datasource as entities',
      () async {
        when(mockTaskCategoryRemoteDataSource.getTaskCategories()).thenAnswer(
          (_) async => [
            taskCategoryModel1,
            taskCategoryModel2,
            taskCategoryModel3,
          ],
        );

        final List<TaskCategoryEntity> result = await taskCategoryRepository
            .getAllTaskCategories();

        expect(
          result,
          equals([
            taskCategoryModel1.toEntity(),
            taskCategoryModel2.toEntity(),
            taskCategoryModel3.toEntity(),
          ]),
        );
        verify(mockTaskCategoryRemoteDataSource.getTaskCategories()).called(1);
      },
    );

    test(
      'should return an empty list when there are no categories from datasource',
      () async {
        when(
          mockTaskCategoryRemoteDataSource.getTaskCategories(),
        ).thenAnswer((_) async => []);

        final List<TaskCategoryEntity> result = await taskCategoryRepository
            .getAllTaskCategories();

        expect(result, []);
        verify(mockTaskCategoryRemoteDataSource.getTaskCategories()).called(1);
      },
    );

    test(
      'should return throw DataSourceException when an error occurs',
      () async {
        when(
          mockTaskCategoryRemoteDataSource.getTaskCategories(),
        ).thenThrow(DataSourceException(cause: ''));

        final call = taskCategoryRepository.getAllTaskCategories;

        expect(call(), throwsA(isA<DataSourceException>()));
        verify(mockTaskCategoryRemoteDataSource.getTaskCategories()).called(1);
      },
    );

    test(
      'should return throw UnknownDataSourceException when an unknown error occurs',
      () async {
        when(
          mockTaskCategoryRemoteDataSource.getTaskCategories(),
        ).thenThrow(UnknownDataSourceException(cause: ''));

        final call = taskCategoryRepository.getAllTaskCategories;

        expect(call(), throwsA(isA<UnknownDataSourceException>()));
        verify(mockTaskCategoryRemoteDataSource.getTaskCategories()).called(1);
      },
    );
  });

  group('findTaskCategoryById', () {
    test(
      'should return an category as an entity when it exists in datasource',
      () async {
        when(
          mockTaskCategoryRemoteDataSource.findTaskCategoryById('1'),
        ).thenAnswer((_) async => taskCategoryModel1);

        final result = await taskCategoryRepository.getTaskCategoryById('1');

        expect(result, equals(taskCategoryModel1.toEntity()));
        verify(
          mockTaskCategoryRemoteDataSource.findTaskCategoryById(any),
        ).called(1);
      },
    );

    test(
      'should throw an TaskCategoryNotFoundException when it does not exist in datasource',
      () async {
        when(
          mockTaskCategoryRemoteDataSource.findTaskCategoryById(any),
        ).thenThrow(TaskCategoryNotFoundException());

        final call = taskCategoryRepository.getTaskCategoryById;

        expect(call('1'), throwsA(isA<TaskCategoryNotFoundException>()));
        verify(
          mockTaskCategoryRemoteDataSource.findTaskCategoryById(any),
        ).called(1);
      },
    );

    test(
      'should return throw DataSourceException when an error occurs',
      () async {
        when(
          mockTaskCategoryRemoteDataSource.findTaskCategoryById(any),
        ).thenThrow(DataSourceException(cause: ''));

        final call = taskCategoryRepository.getTaskCategoryById;

        expect(call('14'), throwsA(isA<DataSourceException>()));
        verify(
          mockTaskCategoryRemoteDataSource.findTaskCategoryById(any),
        ).called(1);
      },
    );

    test(
      'should return throw UnknownDataSourceException when an unknown error occurs',
      () async {
        when(
          mockTaskCategoryRemoteDataSource.findTaskCategoryById(any),
        ).thenThrow(UnknownDataSourceException(cause: ''));

        final call = taskCategoryRepository.getTaskCategoryById;

        expect(call('10'), throwsA(isA<UnknownDataSourceException>()));
        verify(
          mockTaskCategoryRemoteDataSource.findTaskCategoryById(any),
        ).called(1);
      },
    );
  });

  group('deleteCategoryById', () {
    test('should call function from DataSource', () async {
      await taskCategoryRepository.deleteTaskCategory(
        taskCategoryModel1.toEntity(),
      );

      verify(
        mockTaskCategoryRemoteDataSource.deleteTaskCategory(any),
      ).called(1);
    });

    test('should throw an TaskCategoryCannotBeDeletedException when trying to delete a default category', () async {
      when(mockTaskCategoryRemoteDataSource.deleteTaskCategory('1')).thenThrow(TaskCategoryCannotBeDeletedException());

      final call = taskCategoryRepository.deleteTaskCategory;

      expect(call(taskCategoryModel1.toEntity()), throwsA(isA<TaskCategoryCannotBeDeletedException>()));
    },);

    test(
      'should return throw DataSourceException when an error occurs',
      () async {
        when(
          mockTaskCategoryRemoteDataSource.deleteTaskCategory(any),
        ).thenThrow(DataSourceException(cause: ''));

        final call = taskCategoryRepository.deleteTaskCategory;

        expect(
          call(taskCategoryModel1.toEntity()),
          throwsA(isA<DataSourceException>()),
        );
        verify(
          mockTaskCategoryRemoteDataSource.deleteTaskCategory(any),
        ).called(1);
      },
    );

    test(
      'should return throw UnknownDataSourceException when an unknown error occurs',
      () async {
        when(
          mockTaskCategoryRemoteDataSource.deleteTaskCategory(any),
        ).thenThrow(UnknownDataSourceException(cause: ''));

        final call = taskCategoryRepository.deleteTaskCategory;

        expect(
          call(taskCategoryModel1.toEntity()),
          throwsA(isA<UnknownDataSourceException>()),
        );
        verify(
          mockTaskCategoryRemoteDataSource.deleteTaskCategory(any),
        ).called(1);
      },
    );
  });

  group('updateTaskCategory', () {
    test('should return an entity equal to model send from datasource', () async {
      when(mockTaskCategoryRemoteDataSource.updateTaskCategory(any)).thenAnswer((_) async => taskCategoryModel1,);

      final result = await taskCategoryRepository.updateTaskCategory(taskCategoryModel1.toEntity());

      expect(result, equals(taskCategoryModel1.toEntity()));
    },);

    test('should throw an TaskCategoryNotFoundException', () async {
      when(mockTaskCategoryRemoteDataSource.updateTaskCategory(any)).thenThrow(TaskCategoryNotFoundException());

      final call = taskCategoryRepository.updateTaskCategory;

      expect(call(taskCategoryModel1.toEntity()), throwsA(isA<TaskCategoryNotFoundException>()));
    },);

    test(
      'should return throw DataSourceException when an error occurs',
          () async {
        when(
          mockTaskCategoryRemoteDataSource.updateTaskCategory(any),
        ).thenThrow(DataSourceException(cause: ''));

        final call = taskCategoryRepository.updateTaskCategory;

        expect(
          call(taskCategoryModel1.toEntity()),
          throwsA(isA<DataSourceException>()),
        );
        verify(
          mockTaskCategoryRemoteDataSource.updateTaskCategory(any),
        ).called(1);
      },
    );

    test(
      'should return throw UnknownDataSourceException when an unknown error occurs',
          () async {
        when(
          mockTaskCategoryRemoteDataSource.updateTaskCategory(any),
        ).thenThrow(UnknownDataSourceException(cause: ''));

        final call = taskCategoryRepository.updateTaskCategory;

        expect(
          call(taskCategoryModel1.toEntity()),
          throwsA(isA<UnknownDataSourceException>()),
        );
        verify(
          mockTaskCategoryRemoteDataSource.updateTaskCategory(any),
        ).called(1);
      },
    );
  },);
}
