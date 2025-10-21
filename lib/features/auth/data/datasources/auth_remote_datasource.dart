import 'package:taskly/features/auth/data/models/auth_user_model.dart';

abstract class AuthRemoteDataSource{
  Stream<AuthUserModel?> get authUser;
  AuthUserModel? get currentUser;
  Future<AuthUserModel> signInWithEmailAndPassword({required String email, required String password});
  Future<AuthUserModel> signUpWithEmailAndPassword({required String email, required String password});
  Future<AuthUserModel> signInWithGoogle();
  Future<void> sendResetPasswordEmail({required String email});
  Future<void> signOut();
}