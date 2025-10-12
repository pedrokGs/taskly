import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:taskly/features/auth/data/datasources/auth_remote_datasource_firebase.dart';
import 'package:taskly/features/auth/data/models/auth_user_model.dart';

import 'auth_remote_data_source_firebase_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<FirebaseAuth>(),
  MockSpec<UserCredential>(),
  MockSpec<User>(),
])
void main() {
  late MockFirebaseAuth mockFirebaseAuth;
  late MockUserCredential mockUserCredential;
  late MockUser mockUser;
  late AuthRemoteDataSourceFirebase authRemoteDataSource;
  late AuthUserModel authUserModel;

  const tEmail = 'test@test.com';
  const tPassword = 'test_password';

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockUserCredential = MockUserCredential();
    mockUser = MockUser();
    when(mockUser.uid).thenReturn("test_uid");
    when(mockUser.email).thenReturn("test_email");
    authUserModel = AuthUserModel.fromFirebaseAuthUser(mockUser);
    authRemoteDataSource = AuthRemoteDataSourceFirebase(
      firebaseAuth: mockFirebaseAuth,
    );
  });

  group('signUpWithEmailAndPassword', () {
    test(
      'should call signInWithEmailAndPassword on FirebaseAuth with correct email and password',
          () async {
        when(mockFirebaseAuth.signInWithEmailAndPassword(
          email: anyNamed('email'),
          password: anyNamed('password'),
        )).thenAnswer((_) async => mockUserCredential);
        when(mockUserCredential.user).thenReturn(mockUser);

        final result = await authRemoteDataSource.signInWithEmailAndPassword(
          email: 'test@test.com',
          password: 'test_password',
        );

        expect(result, equals(authUserModel));

        verify(mockFirebaseAuth.signInWithEmailAndPassword(
          email: 'test@test.com',
          password: 'test_password',
        ));
      },
    );

    test(
      'should throw Exception when signUpWithEmailAndPassword fails',
      () async {
        when(
          mockFirebaseAuth.createUserWithEmailAndPassword(
            email: anyNamed('email'),
            password: anyNamed('password'),
          ),
        ).thenThrow(Exception());

        final call = authRemoteDataSource.signUpWithEmailAndPassword;

        expect(() => call(email: tEmail, password: tPassword), throwsA(isA<Exception>()));
      },
    );
  });
  
  group('signInWithEmailAndPassword', () {
    test('should call signInWithEmailAndPassword on FirebaseAuth with correct email and password', () async {
      when(
        mockFirebaseAuth.signInWithEmailAndPassword(email: anyNamed('email'), password: anyNamed('password'))
      ).thenAnswer((_) async => mockUserCredential);
      when(mockUserCredential.user).thenReturn(mockUser);

      final result = await authRemoteDataSource.signInWithEmailAndPassword(email: tEmail, password: tPassword);

      expect(result, equals(authUserModel));

      verify(mockFirebaseAuth.signInWithEmailAndPassword(email: 'test@test.com', password: 'test_password'));
    });

    test('should throw an Exception when firebase throws an exception', () async {
      when(
        mockFirebaseAuth.signInWithEmailAndPassword(email: anyNamed('email'), password: anyNamed('password'))
      ).thenThrow(Exception());

      final call = authRemoteDataSource.signInWithEmailAndPassword;

      expect(() => call(email: tEmail, password: tPassword), throwsA(isA<Exception>()));
    },);
  },);

  group('signOut', () {
    test('signOut should be called on firebaseAuth', () async {
      when(
          mockFirebaseAuth.signOut()
      ).thenAnswer((_) async {});

      await authRemoteDataSource.signOut();

      verify(mockFirebaseAuth.signOut());
    },);
  },);

  test('should throw an Exception when Firebase Throws an exception', () async {
    when(
      mockFirebaseAuth.signOut()
    ).thenThrow(Exception());

    final call = authRemoteDataSource.signOut;

    expect(() => call(), throwsA(isA<Exception>()));
  },);
}
