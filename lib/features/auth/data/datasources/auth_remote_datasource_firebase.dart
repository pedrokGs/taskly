import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:taskly/features/auth/data/datasources/auth_remote_datasource.dart';

import '../models/auth_user_model.dart';

class AuthRemoteDataSourceFirebase implements AuthRemoteDataSource{
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn? googleSignIn; // TODO: ADICIONAR COMO REQUIRED POSTERIORMENTE

  AuthRemoteDataSourceFirebase({required this.firebaseAuth, this.googleSignIn});

  @override
  AuthUserModel? get currentUser {
    final user = firebaseAuth.currentUser;
    if(user == null) return null;
    return AuthUserModel(uid: user.uid, email: user.email ?? "");
  }

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

  @override
  Future<AuthUserModel> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn?.authenticate();
      if(googleUser == null) {
        throw GoogleSignInException(code: GoogleSignInExceptionCode.canceled);
      }
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final userCredential = await firebaseAuth.signInWithCredential(credential);
      return AuthUserModel.fromCredential(userCredential);
    } on FirebaseAuthException catch (_) {
      rethrow;
    } on GoogleSignInException catch(_){
      rethrow;
    }
  }
}