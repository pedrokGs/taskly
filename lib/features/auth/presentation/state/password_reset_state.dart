import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskly/core/di/auth_providers.dart';
import 'package:taskly/features/auth/domain/usecases/reset_password_use_case.dart';

class PasswordResetState{
  String? errorMessage;
  bool success;
  bool isLoading;

  PasswordResetState({this.errorMessage, this.success = false, this.isLoading = false});
}

class PasswordResetStateNotifier extends Notifier<PasswordResetState>{
  late final ResetPasswordUseCase resetPasswordUseCase;


  @override
  PasswordResetState build() {
    resetPasswordUseCase = ref.watch(resetPasswordUseCaseProvider);
    return PasswordResetState();
  }

  Future<void> sendResetPassword({required String email}) async{
    state = PasswordResetState(isLoading: true);
    try{
      await resetPasswordUseCase.call(email: email);
      state = PasswordResetState(isLoading: false, success: true);
    } catch(e){
      state = PasswordResetState(isLoading: false, errorMessage: "Erro deconhecido: $e");
    }
  }
}