import '../entities/auth_user_entity.dart';
import '../repositories/auth_repository.dart';

class SignInWithGoogleUseCase{
  final AuthRepository authRepository;

  SignInWithGoogleUseCase({ required this.authRepository});

  Future<AuthUserEntity> call() async{
    return authRepository.signInWithGoogle();
  }
}