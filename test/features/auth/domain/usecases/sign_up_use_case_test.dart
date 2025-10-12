import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:taskly/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:taskly/features/auth/domain/entities/auth_user_entity.dart';
import 'package:taskly/features/auth/domain/usecases/sign_up_use_case.dart';

import 'auth_repository_mock.dart';

@GenerateNiceMocks([
  MockSpec<AuthRepositoryImpl>()
])
void main(){
  late MockAuthRepositoryImpl mockAuthRepositoryImpl;
  late SignUpUseCase signUpUseCase;

  setUp(() {
    mockAuthRepositoryImpl = MockAuthRepositoryImpl();
    signUpUseCase = SignUpUseCase(authRepository: mockAuthRepositoryImpl);
  },);

  final tEmail = "test@gmail.com";
  final tPassword = "test123";
  final AuthUserEntity authUserEntity = AuthUserEntity(uid: '1', email: tEmail);

  group('signUp', () {
    test('should return an AuthUserEntity when sign up is successful', () async {
      when(
        mockAuthRepositoryImpl.signUpWithEmailAndPassword(email: anyNamed('email'), password: anyNamed('password'))
      ).thenAnswer((_) async => authUserEntity,);

      final result = await signUpUseCase.call(email: tEmail, password: tPassword);

      expect(result, equals(authUserEntity));
      verify(mockAuthRepositoryImpl.signUpWithEmailAndPassword(email: tEmail, password: tPassword)).called(1);
    },);

    test('should throw Exception when sign up is not successful', () async {
      when(
        mockAuthRepositoryImpl.signUpWithEmailAndPassword(email: anyNamed('email'), password: anyNamed('password'))
      ).thenThrow(Exception());

      final call = signUpUseCase.call;

      expect(() => call(email: tEmail, password: tPassword), throwsA(isA<Exception>()));
    },);
  },);
}