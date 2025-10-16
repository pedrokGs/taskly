// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:taskly/features/auth/domain/entities/auth_user_entity.dart';
// import 'package:taskly/features/auth/domain/repositories/auth_repository.dart';
// import 'package:taskly/features/tasks/data/datasource/task_category_remote_data_source_firebase.dart';
// import 'package:taskly/features/tasks/data/models/task_category_model.dart';
//
// import 'task_category_remote_data_source_test.mocks.dart';
//
// @GenerateNiceMocks([
//   MockSpec<FirebaseFirestore>(),
//   MockSpec<CollectionReference>(),
//   MockSpec<DocumentReference>(),
//   MockSpec<QuerySnapshot>(),
//   MockSpec<DocumentSnapshot>(),
//   MockSpec<QueryDocumentSnapshot>(),
//   MockSpec<AuthRepository>()
// ])
// void main() {
//   late MockFirebaseFirestore mockFirestore;
//   late MockAuthRepository mockAuthRepository;
//   late TaskCategoryRemoteDataSourceFirebase dataSource;
//
//   setUp(() {
//     mockFirestore = MockFirebaseFirestore();
//     mockAuthRepository = MockAuthRepository();
//     dataSource = TaskCategoryRemoteDataSourceFirebase(
//       firestore: mockFirestore,
//       authRepository: mockAuthRepository,
//     );
//   });
//
//   final testCategory = TaskCategoryModel(id: '123', name: 'Teste', isDefault: true);
//   final mockUser = AuthUserEntity(uid: '1', email: 'test@test.com');
//
//   group('TaskCategoryRemoteDataSourceFirebase CRUD', () {
//     test('createTaskCategory should add document to firestore', () async {
//       final mockCollection = MockCollectionReference();
//       final mockDoc = MockDocumentReference();
//
//       when(mockAuthRepository.currentUser).thenReturn(mockUser);
//       when(mockFirestore.collection(any)).thenReturn(mockCollection);
//       when(mockCollection.add(any)).thenAnswer((_) async => mockDoc);
//       when(mockDoc.id).thenReturn('123');
//
//       final result = await dataSource.createTaskCategory(testCategory);
//
//       expect(result.id, '123');
//       verify(mockCollection.add(any)).called(1);
//     });
//
//     test('deleteTaskCategory should call delete on document', () async {
//       final mockCollection = MockCollectionReference();
//       final mockDoc = MockDocumentReference();
//
//       when(mockAuthRepository.currentUser).thenReturn(mockUser);
//       when(mockFirestore.collection(any)).thenReturn(mockCollection as CollectionReference<Map<String, dynamic>>);
//       when(mockCollection.doc('123')).thenReturn(mockDoc);
//       when(mockDoc.delete()).thenAnswer((_) async => Future.value());
//
//       await dataSource.deleteTaskCategory('123');
//
//       verify(mockDoc.delete()).called(1);
//     });
//
//     test('findTaskCategoryById should return model when doc exists', () async {
//       final mockCollection = MockCollectionReference();
//       final mockDoc = MockDocumentReference();
//       final mockSnapshot = MockDocumentSnapshot();
//
//       when(mockAuthRepository.currentUser).thenReturn(mockUser);
//       when(mockFirestore.collection(any)).thenReturn(mockCollection as CollectionReference<Map<String, dynamic>>);
//       when(mockCollection.doc('123')).thenReturn(mockDoc);
//       when(mockDoc.get()).thenAnswer((_) async => mockSnapshot);
//       when(mockSnapshot.exists).thenReturn(true);
//       when(mockSnapshot.data()).thenReturn(testCategory.toMap());
//
//       final result = await dataSource.findTaskCategoryById('123');
//
//       expect(result?.id, '123');
//       expect(result?.name, 'Teste');
//     });
//   });
// }
