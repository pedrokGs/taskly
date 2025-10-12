import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:taskly/features/auth/data/models/auth_user_model.dart';

import 'auth_user_model_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<User>()
])

void main(){
  late MockUser mockUser;

  setUp(() {
    mockUser = MockUser();

    when(mockUser.uid).thenReturn("test_uid");
    when(mockUser.email).thenReturn("test_email");
  },);

  const uid = 'testId';
  const email = 'test@test.com';

  const authUserModel = AuthUserModel(uid: uid, email: email);
  
  group('AuthUserModel', () {
    test('properties are correctly assigned on creation', () {
      expect(authUserModel.uid, equals(uid));
      expect(authUserModel.email, equals(email));
    },);
    
    test('creates model from firebase user', () {
      final authUserModel = AuthUserModel.fromFirebaseAuthUser(mockUser);

      expect(authUserModel.uid, equals(mockUser.uid));
      expect(authUserModel.email, equals(mockUser.email));
    },);

    test('converts do entity correctly', () {
      final authUserEntity = authUserModel.toEntity();

      expect(authUserEntity.uid, equals(uid));
      expect(authUserModel.uid, equals(uid));
    },);

    test('get props returns a list with all properties', () {
      final props = authUserModel.props;

      expect(props, containsAll([uid, email]));
    },);

    test('handles null value in firebase user correctly', () {
      when(mockUser.email).thenReturn('');

      final authUserModel = AuthUserModel.fromFirebaseAuthUser(mockUser);

      expect(authUserModel.email, equals(''));
    },);
  },);
}