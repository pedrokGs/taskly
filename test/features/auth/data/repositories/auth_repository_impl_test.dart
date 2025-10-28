import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:taskly/core/di/auth_providers.dart';
import 'package:taskly/features/auth/data/datasources/auth_remote_datasource_firebase.dart';
import 'package:taskly/features/auth/data/models/auth_user_model.dart';
import 'package:taskly/features/auth/domain/entities/auth_user_entity.dart';

import 'auth_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AuthRemoteDataSourceFirebase>()])
void main() {
  late ProviderContainer container;
  late MockAuthRemoteDataSourceFirebase mockAuthRemoteDataSourceFirebase;

  setUp(() {
    mockAuthRemoteDataSourceFirebase = MockAuthRemoteDataSourceFirebase();

    container = ProviderContainer(
      overrides: [
        authRemoteDataSourceProvider.overrideWithValue(
          mockAuthRemoteDataSourceFirebase,
        ),
      ],
    );
  });

  const email = 'test@gmail.com';
  const password = 'password12345';
  const authUserModel = AuthUserModel(uid: '123', email: 'test@test.com');

  group('currentUser', () {
    test(
      'returns AuthUser.empty when remoteDataSource.currentUser returns null',
      () {
        when(mockAuthRemoteDataSourceFirebase.currentUser).thenReturn(null);

        final repository = container.read(authRepositoryProvider);

        final result = repository.currentUser;

        expect(result, AuthUserEntity.empty);
      },
    );

    test(
      'returns an AuthUserEntity when remoteDataSource.currentUser returns non-null value',
      () {
        when(
          mockAuthRemoteDataSourceFirebase.currentUser,
        ).thenReturn(authUserModel);

        final repository = container.read(authRepositoryProvider);

        final result = repository.currentUser;

        expect(result, authUserModel.toEntity());
      },
    );
  });

  group('authUser', () {
    test(
      'emits AuthUser.empty when remoteDataSource.authUser emits null',
      () async {
        when(
          mockAuthRemoteDataSourceFirebase.authUser,
        ).thenAnswer((_) => Stream.value(null));

        final repository = container.read(authRepositoryProvider);

        final result = await repository.authUser.first;

        expect(result, AuthUserEntity.empty);
      },
    );

    test(
      'emits an AuthUser when remoteDataSource.authUser emits non-null value',
      () async {
        when(
          mockAuthRemoteDataSourceFirebase.authUser,
        ).thenAnswer((_) => Stream.value(authUserModel));

        final repository = container.read(authRepositoryProvider);

        final result = await repository.authUser.first;

        expect(result, authUserModel.toEntity());
      },
    );
  });

  group('signUp', () {
    test(
      'calls [signUpWithEmailAndPassword] and [write] with correct arguments',
      () async {
        when(
          mockAuthRemoteDataSourceFirebase.signUpWithEmailAndPassword(
            email: email,
            password: password,
          ),
        ).thenAnswer((_) async => authUserModel);

        final repository = container.read(authRepositoryProvider);

        await repository.signUpWithEmailAndPassword(
          email: email,
          password: password,
        );

        verify(
          mockAuthRemoteDataSourceFirebase.signUpWithEmailAndPassword(
            email: email,
            password: password,
          ),
        ).called(1);
      },
    );

    test(
      'returns an AuthUserEntity when remoteDataSource.signUpWithEmailAndPassword returns an AuthUserModel successfully',
      () async {
        when(
          mockAuthRemoteDataSourceFirebase.signUpWithEmailAndPassword(
            email: email,
            password: password,
          ),
        ).thenAnswer((_) async => authUserModel);

        final repository = container.read(authRepositoryProvider);

        final results = await repository.signUpWithEmailAndPassword(
          email: email,
          password: password,
        );

        expect(results, equals(authUserModel.toEntity()));
      },
    );
  });

  group('signIn', () {
    test('calls [signInWithEmailAndPassword] with correct arguments', () async {
      when(
        mockAuthRemoteDataSourceFirebase.signInWithEmailAndPassword(
          email: email,
          password: password,
        ),
      ).thenAnswer((_) async => authUserModel);

      final repository = container.read(authRepositoryProvider);

      await repository.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      verify(
        mockAuthRemoteDataSourceFirebase.signInWithEmailAndPassword(
          email: email,
          password: password,
        ),
      ).called(1);
    });

    test(
      'returns an AuthUserEntity when remoteDataSource.signInWithEmailAndPassword returns an AuthUserModel successfully',
      () async {
        when(
          mockAuthRemoteDataSourceFirebase.signInWithEmailAndPassword(
            email: email,
            password: password,
          ),
        ).thenAnswer((_) async => authUserModel);

        final repository = container.read(authRepositoryProvider);

        final results = await repository.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        expect(results, equals(authUserModel.toEntity()));
      },
    );
  });

  group('signOut', () {
    test('calls signOut', () async {
      when(mockAuthRemoteDataSourceFirebase.signOut()).thenAnswer((_) async {});

      final repository = container.read(authRepositoryProvider);

      await repository.signOut();

      verify(mockAuthRemoteDataSourceFirebase.signOut()).called(1);
    });
  });

  group('signInWithGoogle', () {
    test(
      'returns an AuthUserEntity when remoteDataSource.signInWithGoogle returns an AuthUserModel successfully',
      () async {
        when(
          mockAuthRemoteDataSourceFirebase.signInWithGoogle(),
        ).thenAnswer((_) async => authUserModel);

        final repository = container.read(authRepositoryProvider);
        final result = await repository.signInWithGoogle();

        expect(result, equals(authUserModel.toEntity()));
        verify(mockAuthRemoteDataSourceFirebase.signInWithGoogle()).called(1);
      },
    );

    test(
      'throws an Exception when remoteDataSource.signInWithGoogle fails',
      () async {
        when(
          mockAuthRemoteDataSourceFirebase.signInWithGoogle(),
        ).thenThrow(Exception());

        final repository = container.read(authRepositoryProvider);

        final call = repository.signInWithGoogle;

        expect(call(), throwsA(isA<Exception>()));
        verify(mockAuthRemoteDataSourceFirebase.signInWithGoogle()).called(1);
      },
    );
  });
}
