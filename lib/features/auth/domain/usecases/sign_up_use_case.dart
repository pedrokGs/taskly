import 'package:taskly/features/auth/domain/entities/auth_user_entity.dart';
import 'package:taskly/features/auth/domain/repositories/auth_repository.dart';

class SignUpUseCase{
  final AuthRepository authRepository;

  SignUpUseCase({required this.authRepository});

  Future<AuthUserEntity> call({required String email, required String password}){
    return authRepository.signUpWithEmailAndPassword(email: email, password: password);
  }
}