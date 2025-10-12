import 'package:taskly/features/auth/data/models/auth_user_model.dart';

abstract class AuthRemoteDataSource{
  Stream<AuthUserModel?> get authUser;
  Future<AuthUserModel> signInWithEmailAndPassword({required String email, required String password});
  Future<AuthUserModel> signUpWithEmailAndPassword({required String email, required String password});
  Future<void> signOut();
}