import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskly/features/auth/domain/entities/auth_user_entity.dart';
import 'package:taskly/features/auth/domain/exceptions/email_already_in_use_exception.dart';
import 'package:taskly/features/auth/domain/repositories/auth_repository.dart';

import '../../domain/exceptions/auth_exception.dart';
import '../../domain/exceptions/invalid_email_exception.dart';
import '../../domain/exceptions/logout_exception.dart';
import '../../domain/exceptions/user_not_found_exception.dart';
import '../../domain/exceptions/wrong_password_exception.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Stream<AuthUserEntity?> get authUser => remoteDataSource.authUser.map((user) {
    if(user == null) return null;
    return AuthUserEntity(uid: user.uid, email: user.email);
  },);

  @override
  Future<AuthUserEntity> signInWithEmailAndPassword({required String email, required String password}) async {
    try {
      final userModel = await remoteDataSource.signInWithEmailAndPassword(email: email, password: password);

      final userEntity = userModel.toEntity();
      return userEntity;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') throw UserNotFoundException();
      if (e.code == 'wrong-password') throw WrongPasswordException();
      throw AuthException(e.message ?? 'Erro de autenticação');
    }
  }

  @override
  Future<void> signOut() async {
    try{
      await remoteDataSource.signOut();
    } on FirebaseAuthException catch(_){
      throw LogoutException();
    }
  }

  @override
  Future<AuthUserEntity> signUpWithEmailAndPassword({required String email, required String password}) async {
    try{
      final userModel = await remoteDataSource.signUpWithEmailAndPassword(email: email, password: password);

      final userEntity = userModel.toEntity();
      return userEntity;
    } on FirebaseAuthException catch (e) {
      if(e.code == 'email-already-in-use') throw EmailAlreadyInUseException();
      if(e.code == 'invalid-email') throw InvalidEmailException();
      throw AuthException(e.message ?? 'Erro de autenticação');
    }
  }
}

