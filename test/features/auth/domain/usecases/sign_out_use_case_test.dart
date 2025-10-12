import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:taskly/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:taskly/features/auth/domain/usecases/sign_out_use_case.dart';

import 'auth_repository_mock.dart';

@GenerateNiceMocks([
  MockSpec<AuthRepositoryImpl>()
])
void main(){
  late MockAuthRepositoryImpl mockAuthRepositoryImpl;
  late SignOutUseCase signOutUseCase;

  setUp(() {
    mockAuthRepositoryImpl = MockAuthRepositoryImpl();
    signOutUseCase = SignOutUseCase(authRepository: mockAuthRepositoryImpl);
  },);

  group('signOut', ()  {
    test('should call signOut', () async {
      when(mockAuthRepositoryImpl.signOut()).thenAnswer((_) async => {},);

      await signOutUseCase.call();

      verify(mockAuthRepositoryImpl.signOut()).called(1);
    });

    test('should throw an Exception when not successful', () async {
      when(mockAuthRepositoryImpl.signOut()).thenThrow(Exception());

      final call = signOutUseCase.call;

      expect(() => call(), throwsA(isA<Exception>()));
    });
  });
}