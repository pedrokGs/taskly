import 'package:taskly/features/auth/domain/entities/auth_user_entity.dart';

abstract class AuthRepository{
  Stream<AuthUserEntity?> get authUser;
  AuthUserEntity? get currentUser;
  Future<AuthUserEntity> signInWithEmailAndPassword({required String email, required String password});
  Future<AuthUserEntity> signUpWithEmailAndPassword({required String email, required String password});
  Future<AuthUserEntity> signInWithGoogle();
  Future<void> sendResetPasswordEmail({required String email});
  Future<void> signOut();
}