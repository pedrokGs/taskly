import 'package:taskly/features/auth/domain/repositories/auth_repository.dart';

class SignOutUseCase{
  final AuthRepository authRepository;

  SignOutUseCase({required this.authRepository});

  Future<void> call(){
    return authRepository.signOut();
  }
}