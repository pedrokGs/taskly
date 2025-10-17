import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:taskly/features/auth/domain/entities/auth_user_entity.dart';
import 'package:taskly/features/auth/domain/repositories/auth_repository.dart';
import 'package:taskly/features/tasks/data/datasource/task_category_remote_data_source_firebase.dart';
import 'package:taskly/features/tasks/data/models/task_category_model.dart';

import 'task_category_remote_data_source_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<FirebaseFirestore>(),
  MockSpec<CollectionReference>(),
  MockSpec<DocumentReference>(),
  MockSpec<QuerySnapshot>(),
  MockSpec<DocumentSnapshot>(),
  MockSpec<QueryDocumentSnapshot>(),
  MockSpec<AuthRepository>()
])
void main() {
  late MockFirebaseFirestore mockFirestore;
  late MockAuthRepository mockAuthRepository;
  late TaskCategoryRemoteDataSourceFirebase dataSource;

  setUp(() {
    mockFirestore = MockFirebaseFirestore();
    mockAuthRepository = MockAuthRepository();
    dataSource = TaskCategoryRemoteDataSourceFirebase(
      firestore: mockFirestore,
      authRepository: mockAuthRepository,
    );
  });

  final testCategory = TaskCategoryModel(id: '123', name: 'Teste', isDefault: true);
  final mockUser = AuthUserEntity(uid: '1', email: 'test@test.com');

  // TODO: Implementar testes unitários usando fake firestore
}
