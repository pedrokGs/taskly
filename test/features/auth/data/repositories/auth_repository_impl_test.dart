import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:taskly/features/auth/data/datasources/auth_remote_datasource_firebase.dart';
import 'package:taskly/features/auth/data/models/auth_user_model.dart';
import 'package:taskly/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:taskly/features/auth/domain/entities/auth_user_entity.dart';

import 'auth_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AuthRemoteDataSourceFirebase>()])
void main() {
  late MockAuthRemoteDataSourceFirebase mockAuthRemoteDataSourceFirebase;
  late AuthRepositoryImpl authRepository;

  setUp(() {
    mockAuthRemoteDataSourceFirebase = MockAuthRemoteDataSourceFirebase();
    authRepository = AuthRepositoryImpl(
      remoteDataSource: mockAuthRemoteDataSourceFirebase,
    );
  });

  const email = 'test@gmail.com';
  const password = 'password12345';
  const authUserModel = AuthUserModel(uid: '123', email: 'test@test.com');

  group('authUser', () {
    test('emits AuthUser.empty when remoteDataSource.authUser emits null', () async {
      when(mockAuthRemoteDataSourceFirebase.authUser).thenAnswer((_) => Stream.value(null));

      final result = await authRepository.authUser.first;

      expect(result, AuthUserEntity.empty);
    },);

    test('emits an AuthUser when remoteDataSource.authUser emits non-null value', () async {
      when(mockAuthRemoteDataSourceFirebase.authUser).thenAnswer((_) => Stream.value(authUserModel));

      final result = await authRepository.authUser.first;

      expect(result, authUserModel.toEntity());
    });
  },);

  group('signUp', () {
    test('calls [signUpWithEmailAndPassword] and [write] with correct arguments', () async {
      when(
        mockAuthRemoteDataSourceFirebase.signUpWithEmailAndPassword(email: email, password: password)
      ).thenAnswer((_) async => authUserModel,);

      await authRepository.signUpWithEmailAndPassword(email: email, password: password);

      verify(
        mockAuthRemoteDataSourceFirebase.signUpWithEmailAndPassword(email: email, password: password)
      ).called(1);
    },);

    test('returns an AuthUserEntity when remoteDataSource.signUpWithEmailAndPassword returns an AuthUserModel successfully', () async {
      when(
        mockAuthRemoteDataSourceFirebase.signUpWithEmailAndPassword(email: email, password: password)
      ).thenAnswer((_) async => authUserModel,);

      final results = await authRepository.signUpWithEmailAndPassword(email: email, password: password);

      expect(results, equals(authUserModel.toEntity()));
    },);
  },);

  group('signIn', () {
    test('calls [signInWithEmailAndPassword] with correct arguments', () async {
      when(
        mockAuthRemoteDataSourceFirebase.signInWithEmailAndPassword(email: email, password: password)
      ).thenAnswer((_) async => authUserModel);

      await authRepository.signInWithEmailAndPassword(email: email, password: password);

      verify(mockAuthRemoteDataSourceFirebase.signInWithEmailAndPassword(email: email, password: password)).called(1);
    },);

    test('returns an AuthUserEntity when remoteDataSource.signUpWithEmailAndPassword returns an AuthUserModel successfully', () async {
      when(
        mockAuthRemoteDataSourceFirebase.signInWithEmailAndPassword(email: email, password: password)
      ).thenAnswer((_) async => authUserModel);

      final results = await authRepository.signInWithEmailAndPassword(email: email, password: password);

      expect(results, equals(authUserModel.toEntity()));
    },);
  },);

  group('signOut', () {
    test('calls signOut', () async {
      when(
        mockAuthRemoteDataSourceFirebase.signOut()
      ).thenAnswer((_) async {});

      await authRepository.signOut();

      verify(mockAuthRemoteDataSourceFirebase.signOut()).called(1);
    },);


  },);
}
