import 'package:taskly/features/auth/domain/entities/auth_user_entity.dart';
import 'package:taskly/features/auth/domain/repositories/auth_repository.dart';

class SignInUseCase{
  final AuthRepository authRepository;

  SignInUseCase({ required this.authRepository});

  Future<AuthUserEntity> call({required String email, required String password}) async{
    return authRepository.signInWithEmailAndPassword(email: email, password: password);
  }
}