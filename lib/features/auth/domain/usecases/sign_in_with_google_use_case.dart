import '../entities/auth_user_entity.dart';
import '../repositories/auth_repository.dart';

class SignInUseCase{
  final AuthRepository authRepository;

  SignInUseCase({ required this.authRepository});

  Future<AuthUserEntity> call() async{
    return authRepository.signInWithGoogle();
  }
}