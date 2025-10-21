import 'package:taskly/features/auth/domain/repositories/auth_repository.dart';

class ResetPasswordUseCase{
  final AuthRepository authRepository;

  ResetPasswordUseCase({required this.authRepository});

  Future<void> call({required String email}) async {
    return authRepository.sendResetPasswordEmail(email: email);
  }
}