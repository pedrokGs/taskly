import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:taskly/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:taskly/features/auth/domain/entities/auth_user_entity.dart';
import 'package:taskly/features/auth/domain/usecases/sign_in_use_case.dart';

import 'auth_repository_mock.dart';

@GenerateNiceMocks([
  MockSpec<AuthRepositoryImpl>(),
])
void main(){
  late MockAuthRepositoryImpl mockAuthRepositoryImpl;
  late SignInUseCase signInUseCase;

  setUp(() {
    mockAuthRepositoryImpl = MockAuthRepositoryImpl();
    signInUseCase = SignInUseCase(authRepository: mockAuthRepositoryImpl);
  });

  const tEmail = 'user@test.com';
  const tPassword = '123456';
  final tUser = AuthUserEntity(uid: '1', email: tEmail);

  group('should return AuthUserEntity when login is successful', () {
    test('sign up should be called', () async {
      when(
        mockAuthRepositoryImpl.signInWithEmailAndPassword(email: anyNamed('email'), password: anyNamed('password'))
      ).thenAnswer((_) async => tUser);

      final result = await signInUseCase.call(email: tEmail, password: tPassword);

      expect(result, equals(tUser));
      verify(mockAuthRepositoryImpl.signInWithEmailAndPassword(email: tEmail, password: tPassword)).called(1);
    },);

    test('should throw Exception when login is not successful', () async {
      when(
        mockAuthRepositoryImpl.signInWithEmailAndPassword(email: anyNamed('email'), password: anyNamed('password'))
      ).thenThrow(Exception());

      final call = signInUseCase.call;

      expect(() => call(email: tEmail, password: tPassword), throwsA(isA<Exception>()));
    },);
  },);
}