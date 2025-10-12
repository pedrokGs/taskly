import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskly/features/auth/data/datasources/auth_remote_datasource.dart';

import '../models/auth_user_model.dart';

class AuthRemoteDataSourceFirebase implements AuthRemoteDataSource{
  final FirebaseAuth firebaseAuth;

  AuthRemoteDataSourceFirebase({required this.firebaseAuth});

  @override
  Stream<AuthUserModel?> get authUser =>
      firebaseAuth.authStateChanges().map((user) {
        if (user == null) return null;
        return AuthUserModel(
          uid: user.uid,
          email: user.email ?? "",
        );
      });

  @override
  Future<AuthUserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential credentials = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      final authUser = AuthUserModel.fromCredential(credentials);
      return authUser;

    } on FirebaseAuthException catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AuthUserModel> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential credentials = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      final authUser = AuthUserModel.fromCredential(credentials);

      return authUser;
    } on FirebaseAuthException catch (_) {
      rethrow;
    }
  }
}