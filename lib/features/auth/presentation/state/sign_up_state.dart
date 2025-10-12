import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskly/core/dependencies_injector/riverpod.dart';
import 'package:taskly/features/auth/domain/exceptions/email_already_in_use_exception.dart';
import 'package:taskly/features/auth/domain/exceptions/invalid_credentials_exception.dart';
import 'package:taskly/features/auth/domain/usecases/sign_up_use_case.dart';

class SignUpState{
  final String? errorMessage;
  final bool isLoading;
  final bool success;

  SignUpState({this.errorMessage, this.isLoading = false, this.success = false});
}

class SignUpStateNotifier extends Notifier<SignUpState>{
  late final SignUpUseCase signUpUseCase;

  @override
  SignUpState build() {
    signUpUseCase = ref.watch(signUpUseCaseProvider);
    return SignUpState();
  }

  Future<void> signUp(String email, String password) async {
    state = SignUpState(isLoading: true);
    try{
      await signUpUseCase.call(email: email, password: password);
      state = SignUpState(isLoading: false, success: true);
    } on InvalidCredentialsException {
      state = SignUpState(isLoading: false, errorMessage: "Credenciais inválidas");
    } on EmailAlreadyInUseException {
      state = SignUpState(isLoading: false, errorMessage: "Este email já está em uso");
    } catch (e) {
      state = SignUpState(isLoading: false, errorMessage: "Erro desconhecido: $e");
    }
  }
}

final signUpNotifierProvider = NotifierProvider<SignUpStateNotifier, SignUpState>(() => SignUpStateNotifier(),);