import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:taskly/features/auth/domain/entities/auth_user_entity.dart';
import 'package:taskly/features/auth/domain/usecases/sign_in_with_google_use_case.dart';

import 'sign_in_use_case_test.mocks.dart';

void main(){
  late MockAuthRepositoryImpl mockAuthRepositoryImpl;
  late SignInWithGoogleUseCase signInWithGoogleUseCase;

  setUp(() {
    mockAuthRepositoryImpl = MockAuthRepositoryImpl();
    signInWithGoogleUseCase = SignInWithGoogleUseCase(authRepository: mockAuthRepositoryImpl);
  },);
  final tUser = AuthUserEntity(uid: '1', email: '123@gmail');

  group('call', () {
    test('sign in with google should be called and return an AuthUserEntity', () async {
      when(mockAuthRepositoryImpl.signInWithGoogle()).thenAnswer((_) async => tUser,);

      final result = await signInWithGoogleUseCase.call();

      expect(result, equals(tUser));
      verify(mockAuthRepositoryImpl.signInWithGoogle()).called(1);
    },);

    test('should throw Exception when sign in is not successful', () async {
      when(
          mockAuthRepositoryImpl.signInWithGoogle()
      ).thenThrow(Exception());

      final call = signInWithGoogleUseCase.call;

      expect(() => call(), throwsA(isA<Exception>()));
    },);
  },);
}