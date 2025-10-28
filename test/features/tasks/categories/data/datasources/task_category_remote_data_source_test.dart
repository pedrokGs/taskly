import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taskly/features/auth/domain/entities/auth_user_entity.dart';
import 'package:taskly/features/auth/domain/repositories/auth_repository.dart';
import 'package:taskly/features/tasks/data/datasource/category/task_category_remote_data_source_firebase.dart';
import 'package:taskly/features/tasks/data/models/category/task_category_model.dart';
import 'package:taskly/features/tasks/domain/exceptions/generic/data_source_exception.dart';
import 'package:taskly/features/tasks/domain/exceptions/generic/unknown_data_source_exception.dart';

// Mocks
class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}
class MockCollectionReference extends Mock implements CollectionReference<Map<String, dynamic>> {}
class MockDocumentReference extends Mock implements DocumentReference<Map<String, dynamic>> {}
class MockAuthRepository extends Mock implements AuthRepository {}
class MockUser extends Mock implements AuthUserEntity {}

void main() {
  late TaskCategoryRemoteDataSourceFirebase dataSource;
  late MockFirebaseFirestore mockFirestore;
  late MockAuthRepository mockAuthRepository;
  late MockCollectionReference mockCollection;
  late MockDocumentReference mockDocRef;
  late MockUser mockUser;

  setUp(() {
    mockFirestore = MockFirebaseFirestore();
    mockAuthRepository = MockAuthRepository();
    mockCollection = MockCollectionReference();
    mockDocRef = MockDocumentReference();
    mockUser = MockUser();

    dataSource = TaskCategoryRemoteDataSourceFirebase(
      firestore: mockFirestore,
      authRepository: mockAuthRepository,
    );

    when(() => mockAuthRepository.currentUser).thenReturn(mockUser);
    when(() => mockUser.uid).thenReturn('123');
    when(() => mockFirestore.collection(any())).thenReturn(mockCollection);
    when(() => mockCollection.add(any())).thenAnswer((_) async => mockDocRef);
    when(() => mockDocRef.id).thenReturn('abc123');
  });

  final tTaskCategory = TaskCategoryModel(
    id: null,
    name: 'Test Category',
    isDefault: false,
    icon: '',
  );

  group('createCategory', () {
    test('should create a task category and return it with an ID', () async {
      final result = await dataSource.createTaskCategory(tTaskCategory);

      expect(result.id, 'abc123');
      expect(result.name, tTaskCategory.name);
      verify(() => mockFirestore.collection('users/123/categories')).called(1);
      verify(() => mockCollection.add(tTaskCategory.toMap())).called(1);
    });

    test('should throw DataSourceException if user is not authenticated', () {
      when(() => mockAuthRepository.currentUser).thenReturn(null);

      expect(
            () => dataSource.createTaskCategory(tTaskCategory),
        throwsA(isA<DataSourceException>()),
      );
    });

    test('should throw DataSourceException if FirebaseException occurs', () {
      when(() => mockCollection.add(any())).thenThrow(FirebaseException(
        plugin: 'firestore',
        message: 'Firebase error',
      ));

      expect(
            () => dataSource.createTaskCategory(tTaskCategory),
        throwsA(isA<DataSourceException>()),
      );
    });

    test('should throw UnknownDataSourceException for other exceptions', () {
      when(() => mockCollection.add(any())).thenThrow(Exception('Some error'));

      expect(
            () => dataSource.createTaskCategory(tTaskCategory),
        throwsA(isA<UnknownDataSourceException>()),
      );
    });
  });

  group('deleteCategory', () {
    test('should throw DataSourceException if user is not authenticated', () {
      when(() => mockAuthRepository.currentUser).thenReturn(null);

      expect(
            () => dataSource.deleteTaskCategory('1'),
        throwsA(isA<DataSourceException>()),
      );
    });

    test('should throw DataSourceException if FirebaseException occurs', () {
      when(() => mockCollection.doc(any()).delete()).thenThrow(FirebaseException(
        plugin: 'firestore',
        message: 'Firebase error',
      ));

      expect(
            () => dataSource.deleteTaskCategory('1'),
        throwsA(isA<DataSourceException>()),
      );
    });

    test('should throw UnknownDataSourceException for other exceptions', () {
      when(() => mockCollection.doc(any()).delete()).thenThrow(Exception('Some error'));

      expect(
            () => dataSource.deleteTaskCategory('1'),
        throwsA(isA<UnknownDataSourceException>()),
      );
    });
  },);
}
